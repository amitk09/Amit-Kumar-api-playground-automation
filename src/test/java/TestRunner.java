import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;
import utilities.Hooks;

@RunWith(Cucumber.class)
@CucumberOptions(monochrome = true,
        features = "src/test/features",
        tags = "@test",
        glue = {"stepDefinitions", "utilities"},
        plugin = {
                "json:target/cucumber-reports/cucumber.json",
                "html:target/cucumber-html-report"
        })
public class TestRunner extends Hooks {


}
