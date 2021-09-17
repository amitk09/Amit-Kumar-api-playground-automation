#Author: Amit Kumar
Feature: To test product API get operation

  @test
  Scenario: To verify get all products
    Given user prepare request without body for "product"
    When user executes the "get" request
    And user validate the response
      | statusCode     | 200                         |
      | schemaFileName | get_all_product_schema.json |

  @test
  Scenario Outline: To verify get by id of product
    Given user prepare the json request to create "product" using "create_product_with_all_fields.json"
      | productName         | <productName>  |
      | productType         | <productType>  |
      | productPrice        | <productPrice> |
      | productShipping     | 2              |
      | productUpc          | upc            |
      | productDesc         | <productDesc>  |
      | productManufacturer | Apple          |
      | productModel        | IC 9.97        |
      | productUrl          | <productUrl>   |
      | productImage        | iphone12c.png  |
    When user executes the "post" request
    And user validate the response
      | statusCode | 201 |
    And user fetch "product" id
    And user prepare request without body for "product"
    When user executes the "getById" request
    And user validate the response
      | statusCode     | 200                           |
      | schemaFileName | get_product_by_id_schema.json |
      | productName    | <productName>                 |
      | productType    | <productType>                 |
      | productPrice   | <productPrice>                |
      | productDesc    | <productDesc>                 |
    Examples:
      | productName | productType | productPrice | productDesc                                            | productUrl                       |
      | iphone 12   | smart phone | 100          | Brand new version of Apple phone with face recognition | http://www.applecompanyphone.com |


  @test
  Scenario: To verify error message if wrong id is passed
    Given user fetch "random" id
    And user prepare request without body for "product"
    When user executes the "getById" request
    And user validate the response
      | statusCode | 404 |

