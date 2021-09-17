package utilities;

import com.github.javafaker.Faker;

public class StringGenerator {

    public static String generateStringOfLength(int stringLength) {
        return Faker.instance().lorem().fixedString(stringLength);
    }

    public static String generateRandomNumber() {
        return String.valueOf(Faker.instance().random().nextLong());
    }
}
