package stepDefinitions;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.RestAssured;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import org.junit.Assert;
import utilities.ApiManager;
import utilities.Hooks;
import utilities.StringGenerator;
import static io.restassured.module.jsv.JsonSchemaValidator.matchesJsonSchema;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;
import java.util.stream.Collectors;

public class ProductStepDefinition {

    static RequestSpecification requestSpecification;
    static Response response;
    String productId;
    Map<String, String> collect;

    @Given("user prepare the json request to (.*) {string} using {string}")
    public synchronized void user_prepare_the_json_request_to_create(String resource, String jsonName, DataTable dataTable) {
        HashMap<String, String> data = new HashMap<>(dataTable.asMap(String.class, String.class));
        if (Objects.nonNull(data.get("checkMaxLength")) && data.get("checkMaxLength").equalsIgnoreCase("true")) {
            collect = data.entrySet().stream().filter(x -> x.getValue().contains("length")).collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
            Optional.of(collect.size() >= 1).ifPresent(d -> data.putAll(Hooks.updateTestData(collect)));
        } else if (Objects.nonNull(data.get("checkSpecialChar")) && data.get("checkSpecialChar").equalsIgnoreCase("true")) {
            for (String key : data.keySet()) {
                if (data.get(key).equalsIgnoreCase("special char")) {
                    data.put(key, "!#$%&'()*+,-./:;<=>?@[]^_`{|}~");
                }
            }
        }
        Hooks.updateEndpoint(resource);
        requestSpecification = RestAssured.given().config(Hooks.config).contentType("application/json").body(ApiManager.jsonBody(jsonName, data));
        requestSpecification.log().uri();
        requestSpecification.log().body();

    }


    @When("user executes the {string} request")
    public void user_executes_the_request(String requestType) {
        switch (requestType.toLowerCase()) {
            case "post":
                response = requestSpecification.when().post();
                break;
            case "get":
                response = requestSpecification.when().get();
                break;
            case "getbyid":
                response = requestSpecification.pathParam("id", productId).when().get("/{id}");
                break;
            case "patch":
                response = requestSpecification.pathParam("id", productId).when().patch("{id}");
                break;
            case "delete":
                response = requestSpecification.pathParam("id", productId).when().delete("/{id}");
                break;
            default:
                Assert.fail("provided api operation does not exists. please provide one of the given. {post, get, patch, delete} ");
        }
        response.prettyPrint();

    }

    @Then("user validate the response")
    public void user_verifies_product_detail_in_response(DataTable dataTable) {
        HashMap<String, String> hm = new HashMap<>(dataTable.asMap(String.class, String.class));
        response.then().statusCode(Integer.parseInt(hm.get("statusCode")));
        Optional.ofNullable(hm.get("schemaFileName")).ifPresent(file -> {
            try {
                response.then().assertThat().body(matchesJsonSchema(new String(Files.readAllBytes(Path.of("jsonResponseSchema/" + file)))));
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
        Optional.ofNullable(hm.get("productName")).ifPresent(name -> Assert.assertEquals(name, response.body().jsonPath().get("name")));
        Optional.ofNullable(hm.get("productType")).ifPresent(name -> Assert.assertEquals(name, response.body().jsonPath().get("type")));
        Optional.ofNullable(hm.get("productPrice")).ifPresent(name -> Assert.assertEquals(name, response.body().jsonPath().get("price").toString()));
        Optional.ofNullable(hm.get("productDesc")).ifPresent(name -> Assert.assertEquals(name, response.body().jsonPath().get("description")));
        Optional.ofNullable(hm.get("productUrl")).ifPresent(name -> Assert.assertEquals(name, response.body().jsonPath().get("url")));
    }

    @When("user validate the response status code {int} and error message {string}")
    public void user_validate_the_response_status_code_and_error_message(int code, String errorMessage) {
        response.then().statusCode(code);
        System.out.println(response.body().jsonPath().get("errors[0]").toString());
        Assert.assertEquals(errorMessage, response.body().jsonPath().get("errors[0]").toString());

    }

    @When("user fetch {string} id")
    public void user_fetch_id(String entity) {
        if (List.of("product", "category").contains(entity)) {
            productId = response.body().jsonPath().get("id").toString();
        } else {
            productId = StringGenerator.generateRandomNumber() + StringGenerator.generateStringOfLength(5);
        }

    }

    @Given("user prepare request without body for {string}")
    public void user_prepare_request_without_body(String resource) {
        Hooks.updateEndpoint(resource);
        requestSpecification = RestAssured.given().config(Hooks.config).contentType("application/json");
        requestSpecification.log().uri();
        requestSpecification.log().body();
    }
}
