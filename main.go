package main

import (
	"fmt"
	"log"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/likexian/whois"
)

// Handler is your Lambda function handler
// It uses Amazon API Gateway request/responses provided by the aws-lambda-go/events package,
// However you could use other event sources (S3, Kinesis etc), or JSON-decoded primitive types such as 'string'.
func Handler(request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	fmt.Printf("event.HTTPMethod %v\n", request.HTTPMethod)
	fmt.Printf("event.Body %v\n", request.Body)
	fmt.Printf("event.QueryStringParameters %v\n", request.QueryStringParameters)
	fmt.Printf("event %v\n", request)

	address := ""

	if request.HTTPMethod == "GET" {
		address = request.QueryStringParameters["address"]
	}

	result, err := whois.Whois(address)
	if err == nil {
		fmt.Println(result)
	}

	return events.APIGatewayProxyResponse{
		Body:       fmt.Sprintf("Results: %v\n", result),
		StatusCode: 200,
		Headers: map[string]string{
			"Content-Type":                 "application/json",
			"Access-Control-Allow-Headers": "Content-Type",
			"Access-Control-Allow-Origin":  "*",
			"Access-Control-Allow-Methods": "GET",
		},
	}, nil

}

func main() {
	log.Printf("Start lambda")
	lambda.Start(Handler)
}
