#Author: Amit Kumar
Feature: To verify create operation of product API

  @test
  Scenario Outline: To verify creation of product
    Given user prepare the json request to create "product" using "create_product_with_all_fields.json"
      | productName         | <productName>         |
      | productType         | <productType>         |
      | productPrice        | <productPrice>        |
      | productShipping     | <productShipping>     |
      | productUpc          | <productUpc>          |
      | productDesc         | <productDesc>         |
      | productManufacturer | <productManufacturer> |
      | productModel        | <productModel>        |
      | productUrl          | <productUrl>          |
      | productImage        | <productImage>        |
    When user executes the "post" request
    And user validate the response
      | statusCode     | 201                                                 |
      | schemaFileName | create-product-with-all-fields-response-schema.json |
      | productName    | <productName>                                       |
      | productType    | <productType>                                       |
      | productPrice   | <productPrice>                                      |
      | productDesc    | <productDesc>                                       |
      | productUrl     | <productUrl>                                        |
    Examples:
      | productName | productType | productPrice | productShipping | productUpc | productDesc | productManufacturer | productModel | productUrl             | productImage   |
      | iphone 12   | smart phone | 100          | 2               | test upc   | desc test   | Apple               | Ap097.kl     | http://www.myapplu.com | image.png test |


  @test
  Scenario Outline: To verify creation of product with maximum length allowed
    Given user prepare the json request to create "product" using "create_product_with_all_fields.json"
      | checkMaxLength      | true                  |
      | productName         | <productName>         |
      | productType         | <productType>         |
      | productPrice        | <productPrice>        |
      | productShipping     | <productShipping>     |
      | productUpc          | <productUpc>          |
      | productDesc         | <productDesc>         |
      | productManufacturer | <productManufacturer> |
      | productModel        | <productModel>        |
      | productUrl          | <productUrl>          |
      | productImage        | <productImage>        |
    When user executes the "post" request
    And user validate the response
      | statusCode     | 201                                                 |
      | schemaFileName | create-product-with-all-fields-response-schema.json |
    Examples:
      | productName | productType | productPrice | productShipping | productUpc | productDesc | productManufacturer | productModel | productUrl | productImage |
      | length 100  | length 30   | 1            | 2               | length 15  | length 100  | length 50           | length 25    | length 500 | length 100   |


  @test
  Scenario Outline: To verify validation message if more than allowed length or decimal point is given in request payload
    Given user prepare the json request to create "product" using "create_product_with_all_fields.json"
      | checkMaxLength      | true                  |
      | productName         | <productName>         |
      | productType         | <productType>         |
      | productPrice        | <productPrice>        |
      | productShipping     | <productShipping>     |
      | productUpc          | <productUpc>          |
      | productDesc         | <productDesc>         |
      | productManufacturer | <productManufacturer> |
      | productModel        | <productModel>        |
      | productUrl          | <productUrl>          |
      | productImage        | <productImage>        |
    When user executes the "post" request
    And user validate the response status code 400 and error message "<errorMessage>"

    Examples:
      | productName | productType | productPrice | productShipping | productUpc | productDesc | productManufacturer | productModel | productUrl | productImage | errorMessage                                           |
      | length 101  | length 30   | 1            | 2               | length 15  | length 100  | length 50           | length 25    | length 500 | length 500   | 'name' should NOT be longer than 100 characters        |
      | length 100  | length 31   | 1            | 2               | length 15  | length 100  | length 50           | length 25    | length 500 | length 500   | 'type' should NOT be longer than 30 characters         |
      | length 100  | length 30   | 1            | 2               | length 16  | length 100  | length 50           | length 25    | length 500 | length 500   | 'upc' should NOT be longer than 15 characters          |
      | length 100  | length 30   | 1            | 2               | length 15  | length 101  | length 50           | length 25    | length 500 | length 500   | 'description' should NOT be longer than 100 characters |
      | length 100  | length 30   | 1            | 2               | length 15  | length 100  | length 51           | length 25    | length 500 | length 500   | 'manufacturer' should NOT be longer than 50 characters |
      | length 100  | length 30   | 1            | 2               | length 15  | length 100  | length 50           | length 26    | length 500 | length 500   | 'model' should NOT be longer than 25 characters        |
      | length 100  | length 30   | 1            | 2               | length 15  | length 100  | length 50           | length 25    | length 501 | length 500   | 'url' should NOT be longer than 500 characters         |
      | length 100  | length 30   | 1            | 2               | length 15  | length 100  | length 50           | length 25    | length 500 | length 501   | 'image' should NOT be longer than 500 characters       |
      | length 100  | length 30   | 1.656        | 2               | length 15  | length 100  | length 50           | length 25    | length 500 | length 500   | 'price' should be multiple of 0.01                     |
      | length 100  | length 30   | 1.66         | 2.098           | length 15  | length 100  | length 50           | length 25    | length 500 | length 500   | 'shipping' should be multiple of 0.01                  |


  @test
  Scenario Outline: To verify error message of minimum length required to create product
    Given user prepare the json request to create "product" using "create_product_with_all_fields.json"
      | productName         | <productName>         |
      | productType         | <productType>         |
      | productPrice        | <productPrice>        |
      | productShipping     | <productShipping>     |
      | productUpc          | <productUpc>          |
      | productDesc         | <productDesc>         |
      | productManufacturer | <productManufacturer> |
      | productModel        | <productModel>        |
      | productUrl          | <productUrl>          |
      | productImage        | <productImage>        |
    When user executes the "post" request
    And user validate the response status code 400 and error message "<errorMessage>"
    Examples:
      | productName | productType | productPrice | productShipping | productUpc | productDesc | productManufacturer | productModel | productUrl | productImage   | errorMessage                                           |
      |             | test Type   | 1            | 2               | test upc   | desc test   | test manufacturer   | model test   | url est    | image.png test | 'name' should NOT be shorter than 1 characters         |
      | test name   |             | 1            | 2               | test upc   | desc test   | test manufacturer   | model test   | url est    | image.png test | 'type' should NOT be shorter than 1 characters         |
      | test name   | test Type   | 1            | 2               |            | desc test   | test manufacturer   | model test   | url est    | image.png test | 'upc' should NOT be shorter than 1 characters          |
      | test name   | test Type   | 1            | 2               | test upc   |             | test manufacturer   | model test   | url est    | image.png test | 'description' should NOT be shorter than 1 characters  |
      | test name   | test Type   | 1            | 2               | test upc   | desc test   |                     | model test   | url est    | image.png test | 'manufacturer' should NOT be shorter than 1 characters |
      | test name   | test Type   | 1            | 2               | test upc   | desc test   | test manufacturer   |              | url est    | image.png test | 'model' should NOT be shorter than 1 characters        |
      | test name   | test Type   | 1            | 2               | test upc   | desc test   | test manufacturer   | model test   |            | image.png test | 'url' should NOT be shorter than 1 characters          |
      | test name   | test Type   | 1            | 2               | test upc   | desc test   | test manufacturer   | model test   | url test   |                | 'image' should NOT be shorter than 1 characters        |


  @test
  Scenario Outline: To verify creation of product with mandatory fields
    Given user prepare the json request to create "product" using "create_product_with_mandatory_fields.json"
      | productName  | <productName>  |
      | productType  | <productType>  |
      | productUpc   | <productUpc>   |
      | productDesc  | <productDesc>  |
      | productModel | <productModel> |
    When user executes the "post" request
    And user validate the response
      | statusCode     | 201                                                       |
      | schemaFileName | create-product-with-mandatory-fields-response-schema.json |
      | productName    | <productName>                                             |
      | productType    | <productType>                                             |
      | productDesc    | <productDesc>                                             |

    Examples:
      | productName | productType | productUpc | productDesc | productModel |
      | test Name   | test Type   | test upc   | desc test   | model test   |

  @test
  Scenario: To verify creation of product with special character in each string field
    Given user prepare the json request to create "product" using "create_product_with_all_fields.json"
      | checkSpecialChar    | true           |
      | productName         | special char   |
      | productType         | special char   |
      | productPrice        | 1              |
      | productShipping     | 2              |
      | productUpc          | !#$%&'()*+,-./ |
      | productDesc         | special char   |
      | productManufacturer | special char   |
      | productModel        | !#$%&'()*+,-./ |
      | productUrl          | special char   |
      | productImage        | special char   |
    When user executes the "post" request
    And user validate the response
      | statusCode     | 201                                                 |
      | schemaFileName | create-product-with-all-fields-response-schema.json |

