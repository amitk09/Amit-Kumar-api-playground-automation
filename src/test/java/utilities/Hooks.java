package utilities;

import io.restassured.RestAssured;
import io.restassured.config.HttpClientConfig;
import io.restassured.config.RestAssuredConfig;
import org.junit.Assert;
import org.junit.BeforeClass;

import java.io.FileReader;
import java.io.IOException;
import java.util.*;


public class Hooks {

    static HashMap<String, String> properties = new HashMap<>();
    public static RestAssuredConfig config = RestAssuredConfig.config().httpClient(HttpClientConfig.httpClientConfig()
            .setParam("http.socket.timeout", 3000)
            .setParam("http.connection.timeout", 3000));

    @BeforeClass
    public static void beforeTest() throws IOException {
        FileReader reader = new FileReader("config.properties");
        Properties p = new Properties();
        p.load(reader);
        HashMap<Object, Object> hm = new HashMap<>(p);
        for (Object obj : hm.keySet()) {
            properties.put(String.valueOf(obj), String.valueOf(hm.get(obj)));
        }
        RestAssured.baseURI = properties.get("BaseURL");
    }

    public static synchronized void updateEndpoint(String resourceName) {
        RestAssured.basePath = properties.get(resourceName.toLowerCase());
        if (RestAssured.basePath == null || RestAssured.basePath.isEmpty()) {
            Assert.fail("Endpoint does not exists  for provided resource in properties. Either update resource or property file. Provided resource = " + resourceName);
        }
    }

    public static Map updateTestData( Map<String,String> data ) {

        for (String key : data.keySet()) {
           String[] arr = data.get(key).split("length");
           int length = Integer.parseInt(arr[1].trim());
            data.put(key, StringGenerator.generateStringOfLength(length));

        }
        return data;
    }
}
