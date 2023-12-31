import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.edge.EdgeDriver;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

public class Main {

    public static void main(String[] args) {
        String csvFilePath = "path/to/your/csvfile.csv";

        // Set the path to the EdgeDriver executable
        System.setProperty("webdriver.edge.driver", "path/to/edge/driver/msedgedriver.exe");

        WebDriver driver = new EdgeDriver();

        try {
            List<String> productNames = readProductNamesFromCSV(csvFilePath);

            for (String productName : productNames) {
                List<String> imageUrls = searchAndRetrieveImagesWithSelenium(driver, productName);
                System.out.println("Product: " + productName);
                System.out.println("Images:");

                for (String imageUrl : imageUrls) {
                    System.out.println(imageUrl);

                    // Save the image to a local directory
                    saveImage(imageUrl, "path/to/save/images");
                }

                System.out.println();
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            // Close the WebDriver
            driver.quit();
        }
    }

    private static List<String> readProductNamesFromCSV(String csvFilePath) throws IOException {
        List<String> productNames = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(csvFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] columns = line.split(",");
                if (columns.length > 0) {
                    String productName = columns[0].trim();
                    productNames.add(productName);
                }
            }
        }

        return productNames;
    }

    private static List<String> searchAndRetrieveImagesWithSelenium(WebDriver driver, String productName) {
        List<String> imageUrls = new ArrayList<>();

        try {
            // Modify the search URL as needed
            String searchUrl = "https://www.google.com/search?q=" + productName + "&tbm=isch";
            driver.get(searchUrl);
            driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);

            List<WebElement> imageElements = driver.findElements(By.tagName("img"));
            int count = 0;

            for (WebElement element : imageElements) {
                String imageUrl = element.getAttribute("src");
                if (imageUrl != null && !imageUrl.isEmpty()) {
                    imageUrls.add(imageUrl);
                    count++;

                    if (count >= 3) {
                        break;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return imageUrls;
    }

    private static void saveImage(String imageUrl, String savePath) {
        // Implement code to save the image to the specified local directory
        // You can use libraries like Apache HttpClient or Java's URL and InputStream classes for this
        // Example: https://stackoverflow.com/a/9216746
    }
}
