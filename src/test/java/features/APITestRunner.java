package features;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.Test;
import org.junit.runner.RunWith;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit4.Karate;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

//@RunWith(Karate.class)

public class APITestRunner {

	@Test
	public void testParallel() {
		 //String karateOutputPath = "target/surefire-reports";
		// Results results = Runner.path("classpath:features").tags("@reqres").parallel(0);
		 Results results = Runner.path("classpath:features").parallel(0);
	     generateReport(results.getReportDir());
	     
		 //generateReport(karateOutputPath);
	}
	
	private static void generateReport(String karateOutputPath) {
		Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
		List<String> jsonPaths = new ArrayList<String>(jsonFiles.size());
		jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
		
		Configuration config = new Configuration(new File("target"), "APITestingProject");
		ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
		reportBuilder.generateReports();
	}
}	
