package utilities;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.Objects;

public class ApiManager {


    public static synchronized String jsonBody(String jsonFileName, HashMap<String, String> data) {
        String jsonBody = "";
        try {
            jsonBody = new String(Files.readAllBytes(Path.of("jsonRequestFiles/" + jsonFileName)));
            if (Objects.nonNull(data)) {
                for (String jsonKey : data.keySet()) {
                    data.putIfAbsent(jsonKey, "");
                    jsonBody = jsonBody.replace("${" + jsonKey + "}", data.get(jsonKey));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return jsonBody;
    }




}
