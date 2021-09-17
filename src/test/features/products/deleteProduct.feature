#Author: Amit Kumar
Feature: To verify delete functionality of product api

  @test
  Scenario: To verify deletion of product
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
    And user prepare request without body for "product"
    When user executes the "delete" request
    And user validate the response
      | statusCode | 200 |
    When user executes the "getById" request
    And user validate the response
      | statusCode | 404 |


  @test
  Scenario: To verify error message if wrong id is passed for deletion
    Given user fetch "random" id
    And user prepare request without body for "product"
    When user executes the "delete" request
    And user validate the response
      | statusCode | 404 |