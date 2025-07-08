
from bs4 import BeautifulSoup
import os
import time
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options

def scrape_api_trc20():
    url = "https://api.trc20api.com/"
    chrome_options = Options()
    chrome_options.add_argument("--headless")  # Run in headless mode
    service = Service('/usr/bin/chromedriver')  # Update path to chromedriver
    
    driver = webdriver.Chrome(service=service, options=chrome_options)
    driver.get(url)

    try:
        start_time = time.time()
        print("Page loaded successfully")

        html_content = driver.page_source
        soup = BeautifulSoup(html_content, 'html.parser')

        print("Finding all links...")
        php_files = soup.find_all('a', href=True)

        print(f"Found {len(php_files)} links")

        successful_downloads = 0

        for file in php_files:
            if file['href'].endswith('.php'):
                filename = file['href'].split('/')[-1]
                print(f"Processing: {filename}")

                file_url = f"https://api.trc20api.com{file['href']}"  # Remove leading slash
                print(f"Requesting URL: {file_url}")
                driver.get(file_url)

                file_response = driver.page_source
                file_soup = BeautifulSoup(file_response, 'html.parser')

                if file_soup.title.string:
                    print(f"Successfully retrieved: {filename}")
                    successful_downloads += 1

                    with open(filename, 'w', encoding='utf-8') as f:
                        f.write(str(file_soup))
                else:
                    print(f"Failed to retrieve {filename}")

        end_time = time.time()
        total_time = end_time - start_time
        print(f"All files processed in {total_time:.2f} seconds")
        print(f"Total successful retrievals: {successful_downloads}")

    except Exception as e:
        print(f"An error occurred: {e}")

    finally:
        driver.quit()

# Run the scraper
scrape_api_trc20()
