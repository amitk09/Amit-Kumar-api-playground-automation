#Author: Amit Kumar
Feature: To test product API Patch operation

  @test
  Scenario Outline: To verify update of product with all fields
    Given user prepare the json request to create "product" using "create_product_with_all_fields.json"
      | productName         | iphone 12                                              |
      | productType         | smart phone                                            |
      | productPrice        | 100                                                    |
      | productShipping     | 2                                                      |
      | productUpc          | upc                                                    |
      | productDesc         | Brand new version of Apple phone with face recognition |
      | productManufacturer | Apple                                                  |
      | productModel        | IC 9.97                                                |
      | productUrl          | http://www.applecompanyphone.com                       |
      | productImage        | iphone12c.png                                          |
    When user executes the "post" request
    And user validate the response
      | statusCode | 201 |
    And user fetch "product" id
    And user prepare the json request to update "product" using "create_product_with_all_fields.json"
      | productName         | <productName>     |
      | productType         | <productType>     |
      | productPrice        | <productPrice>    |
      | productShipping     | 5                 |
      | productUpc          | upc not available |
      | productDesc         | <productDesc>     |
      | productManufacturer | IKEA              |
      | productModel        | cpt767            |
      | productUrl          | <productUrl>      |
      | productImage        | <productImage>    |
    When user executes the "patch" request
    And user validate the response
      | statusCode     | 200                                                 |
      | schemaFileName | create-product-with-all-fields-response-schema.json |
      | productName    | <productName>                                       |
      | productType    | <productType>                                       |
      | productPrice   | <productPrice>                                      |
      | productDesc    | <productDesc>                                       |
      | productUrl     | <productUrl>                                        |
      | productImage   | <productImage>                                      |
    Examples:
      | productName | productType | productPrice | productDesc  | productUrl                 | productImage  |
      | Chair       | Furniture   | 500          | office chair | http://www.ikeamystore.com | chair878.jpeg |


  @test
  Scenario Outline: To verify update of product with limited fields
    Given user prepare the json request to create "product" using "create_product_with_all_fields.json"
      | productName         | Easy Chair        |
      | productType         | Antique furniture |
      | productPrice        | 100               |
      | productShipping     | 2                 |
      | productUpc          | upc               |
      | productDesc         | <productDesc>     |
      | productManufacturer | IKEA              |
      | productModel        | CC 9.97           |
      | productUrl          | <productUrl>      |
      | productImage        | <productImage>    |
    When user executes the "post" request
    And user validate the response
      | statusCode | 201 |
    And user fetch "product" id
    And user prepare the json request to update "product" using "update_product_with_limited_fields.json"
      | productName  | <productName>  |
      | productType  | <productType>  |
      | productPrice | <productPrice> |
    When user executes the "patch" request
    And user validate the response
      | statusCode     | 200                                                 |
      | schemaFileName | create-product-with-all-fields-response-schema.json |
      | productName    | <productName>                                       |
      | productType    | <productType>                                       |
      | productPrice   | <productPrice>                                      |
      | productDesc    | <productDesc>                                       |
      | productUrl     | <productUrl>                                        |
      | productImage   | <productImage>                                      |
    Examples:
      | productName | productType | productPrice | productDesc  | productUrl                 | productImage  |
      | Chair       | Furniture   | 500          | office chair | http://www.ikeamystore.com | chair878.jpeg |

