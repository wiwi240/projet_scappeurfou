# 🎄 Project: Mairie Christmas - Val d'Oise Scraper

## 📖 Overview
This project is part of the **The Hacking Project** (THP) curriculum. The goal is to build a scalable web scraper using **Ruby** to extract contact information for all municipalities in the **Val d'Oise** department from the official French administrative directory.

## 🛠️ Tech Stack
- **Language:** Ruby
- **Gems:** - `Nokogiri`: For parsing HTML and navigating the DOM using XPath.
  - `Open-URI`: To fetch the HTML content of the web pages.
  - `RSpec`: For Test-Driven Development (TDD) and verifying code logic.

## ⚙️ Methods & Logic

The program is architected into three distinct methods to separate concerns and ensure maintainability:

### 1. `get_townhall_email(townhall_url)`
- **Purpose:** Extracts the email address and city name from a specific town hall's detail page.
- **Logic:** It targets the `<h1>` tag for the city name and uses a specific XPath to locate the email link within the contact section.
- **Return:** A single Hash: `{ "City Name" => "email@address.fr" }`.

### 2. `get_townhall_urls`
- **Purpose:** Scans the directory listing page to collect the URLs of every town hall in the Val d'Oise.
- **Logic:** It parses the results list and prepends the base domain to the relative links found in the `<a>` tags.
- **Return:** An Array of strings (URLs).

### 3. `perform`
- **Purpose:** The "Orchestrator" method.
- **Logic:** It calls `get_townhall_urls` to get the list, then iterates through each URL to call `get_townhall_email`. 
- **Return:** The final Array of Hashes required by the project specifications.

## 🧪 Testing Justification
Testing is crucial to ensure that the scraper doesn't break when the website structure changes slightly.
- **Consistency:** We check if the methods return the correct data types (`Hash` for email, `Array` for URLs).
- **Accuracy:** We verify that the extracted strings actually look like emails (containing the `@` symbol).
- **Presence:** We ensure the scraper doesn't return empty results, confirming the XPath selectors are still valid.

## 🚀 How to Run

1. **Install dependencies:**
   ```bash
   bundle install