# 10 Academy: Artificial Intelligence Mastery - Week 7 Challenge

## Project: Building a Data Warehouse for Ethiopian Medical Business Data

**Date:** July 09 - july 15, 2025

**Overview:**

This project focuses on building a data warehouse to store and analyze data related to Ethiopian medical businesses scraped from Telegram channels. The goal is to develop a robust, scalable solution that incorporates data scraping, cleaning, transformation, object detection using YOLO, and data warehousing best practices. This project also exposes the collect data through a fast API

**Business Need:**

Kara Solutions, a leading data science company, requires a data warehouse to centralize and analyze data on Ethiopian medical businesses. This will enable comprehensive analysis, identification of trends, and improved decision-making for their clients.

**Core Tasks:**

1.  **Data Scraping and Collection Pipeline:** Extract data from relevant Telegram channels.
2.  **Data Cleaning and Transformation Pipeline:** Clean and transform the scraped data for analysis.
3.  **Object Detection using YOLO:** Integrate YOLO for object detection in images scraped from Telegram channels.
4.  **Data Warehouse Design and Implementation:** Design and implement a data warehouse to store the processed data.
5.  **Data Integration and Enrichment:** Integrate and enrich the data within the data warehouse.
6.  **Expose the collect data using Fast API.**

## Deliverables:

### Task 1: Data Scraping and Collection Pipeline

**Objective:** Extract data from Telegram channels and store it for further processing.

**Steps:**

1.  **Telegram Scraping:**

    - Utilize the Telegram API (e.g., via `telethon`) or custom scripts to extract data from public Telegram channels relevant to Ethiopian medical businesses.
    - **Example Channels:**
      - [https://t.me/DoctorsET](https://t.me/DoctorsET)
      - Chemed Telegram Channel (Link needed. Assumed to be a channel named "Chemed")
      - [https://t.me/lobelia4cosmetics](https://t.me/lobelia4cosmetics)
      - [https://t.me/yetenaweg](https://t.me/yetenaweg)
      - [https://t.me/EAHCI](https://t.me/EAHCI)
      - Explore more channels from [https://et.tgstat.com/medicine](https://et.tgstat.com/medicine)
    - **Tools:**
      - Python libraries: `telethon` (for Telegram API interaction)

2.  **Image Scraping:**

    - Collect images from:
      - Chemed Telegram Channel (Link needed. Assumed to be a channel named "Chemed")
      - [https://t.me/lobelia4cosmetics](https://t.me/lobelia4cosmetics)

3.  **Storing Raw Data:**

    - Store the raw scraped data (text and images) in a temporary storage location (e.g., local database, files).

4.  **Monitoring and Logging:**
    - Implement logging to track the scraping process, capture errors, and monitor progress.

### Task 2: Data Cleaning and Transformation

**Objective:** Clean, transform, and prepare the scraped data for loading into the data warehouse.

**Steps:**

1.  **Data Cleaning:**

    - Remove duplicates.
    - Handle missing values (e.g., imputation, removal).
    - Standardize formats (e.g., date formats, units of measure).
    - Data validation to ensure data integrity.

2.  **Storing Cleaned Data:**

    - Store the cleaned data in a database (e.g., PostgreSQL, MySQL).

3.  **DBT for Data Transformation:**

    - **Setting Up DBT:**
      ```bash
      pip install dbt-core dbt-postgres # or appropriate adapter
      dbt init my_project
      ```
    - **Defining Models:**

      - Create DBT models (SQL files) to define transformations on your data (e.g., creating fact and dimension tables).
      - Example: `models/dim_businesses.sql`

      ```sql
      {{ config(materialized='table') }}

      SELECT
          business_id,
          business_name,
          -- other relevant fields
      FROM {{ source('raw_data', 'businesses') }}
      ```

    - **Running DBT:**
      ```bash
      dbt run
      ```
    - **Testing and Documentation:**
      ```bash
      dbt test
      dbt docs generate
      dbt docs serve
      ```

4.  **Monitoring and Logging:**
    - Implement logging to track the transformation process, capture errors, and monitor progress.

### Task 3: Object Detection Using YOLO

**Objective:** Use YOLO to detect objects in images scraped from Telegram channels.

**Steps:**

1.  **Setting Up the Environment:**

    ```bash
    pip install opencv-python
    pip install torch torchvision torchaudio  # PyTorch-based YOLO (recommended)
    # pip install tensorflow  # TensorFlow-based YOLO (alternative)
    ```

2.  **Downloading the YOLO Model (YOLOv5 example):**

    ```bash
    git clone https://github.com/ultralytics/yolov5.git
    cd yolov5
    pip install -r requirements.txt
    ```

3.  **Preparing the Data:**

    - Ensure you have images collected from the specified Telegram channels.

4.  **Running Object Detection:**

    - Use the pre-trained YOLO model to detect objects in the images.
    - Example (using YOLOv5):

      ```python
      import torch

      # Load the YOLOv5 model
      model = torch.hub.load('ultralytics/yolov5', 'yolov5s')  # or yolov5m, yolov5l, yolov5x

      # Load an image
      img = 'path/to/your/image.jpg'  # Replace with your image path

      # Perform object detection
      results = model(img)

      # Print the results
      results.print()

      # Save results (images with detections)
      results.save()  # saves in 'runs/detect/exp'
      ```

5.  **Processing the Detection Results:**

    - Extract relevant data from the detection results, such as bounding box coordinates, confidence scores, and class labels.

6.  **Storing Detection Data:**

    - Store the detection data (image name, bounding box coordinates, confidence scores, class labels) into a database table.

7.  **Monitoring and Logging:**
    - Implement logging to track the object detection process, capture errors, and monitor progress.

### Task 4: Expose the Collected Data using FastAPI

**Objective:** Create a REST API using FastAPI to expose the collected and processed data.

**Steps:**

1.  **Setting Up the Environment:**

    ```bash
    pip install fastapi uvicorn sqlalchemy psycopg2-binary  #Example database driver
    ```

2.  **Project Structure (Example):**

        ```
        my_project/
        ├── main.py
        ├── database.py
        ├── models.py
        ├── schemas.py
        └── crud.py
        ```

        **Running the FastAPI application:**

        ```bash
        uvicorn main:app --reload
        ```

         Add Environment & Orchestration

    Add how you’ll orchestrate the whole flow:

markdown
Copy
Edit

### Orchestration and Automation

To automate the data pipeline — from scraping to transformation — Dagster or Airflow can be used.

**Example:**

- **Dagster:** Define separate jobs for scraping, cleaning, YOLO detection, DBT runs, and API refresh.
- Schedule pipelines to run hourly/daily.
- Monitor runs & handle retries automatically.

> _Setup Example:_
>
> ```bash
> pip install dagster dagit
> dagster project scaffold -m medical_dw_pipeline
> dagit -f my_pipeline.py
> ```
>
> Add Dockerization
> Add a clear note on how Docker packages all parts:

markdown
Copy
Edit

### Dockerization

To ensure portability, the scraper, YOLO, DBT, and FastAPI will run inside containers.

**Files:**

- `Dockerfile` for FastAPI & Python scripts.
- `docker-compose.yml` to spin up:
  - PostgreSQL
  - FastAPI server
  - Optional: separate worker container for scraping & YOLO tasks.
    Add .env Example
    markdown
    Copy
    Edit

### Environment Variables

Add a `.env` file to store secrets:

````env
POSTGRES_USER=myuser
POSTGRES_PASSWORD=mypassword
POSTGRES_DB=medical_dw
DATABASE_URL=postgresql://myuser:mypassword@db:5432/medical_dw
TELEGRAM_API_ID=YOUR_TELEGRAM_ID
TELEGRAM_API_HASH=YOUR_TELEGRAM_HASH
yaml
Copy
Edit

---

Add CI/CD**

```markdown
### CI/CD Automation

Use GitHub Actions to:
- Run DBT models on push.
- Run unit tests for API.
- Lint Python scripts.

**Example `.github/workflows/main.yml`**

```yaml
name: CI Pipeline

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.10'
    - name: Install dependencies
      run: |
        pip install -r requirements.txt
    - name: Run DBT
      run: |
        dbt run
    - name: Run tests
      run: |
        pytest
yaml
Copy
Edit

---

Add ERD (Schema) Example**

```markdown
### Database Schema (ERD)

**Tables:**
- `raw_messages`: id, text, date, channel
- `images`: id, file_name, related_message_id
- `detected_objects`: id, image_id, label, confidence, bbox coords
- `businesses`: id, name, category

**Relationships:**
- `raw_messages` ➜ `images` ➜ `detected_objects`
- `businesses` link to `raw_messages` for context
Add Security & Docs
markdown
Copy
Edit
### API Security & Docs

Add:
- JWT token auth or API key auth.
- Automatic docs with Swagger (`/docs`) via FastAPI.
- Example:

```python
from fastapi import Depends
from fastapi.security import OAuth2PasswordBearer

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

def get_current_user(token: str = Depends(oauth2_scheme)):
    # Verify & decode JWT
    return token
yaml
Copy
Edit

---

 Add Testing**

```markdown
### Testing

- Use `pytest` to test:
  - Scraper output
  - DBT transformation checks
  - API endpoints

**Example:**

```python
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_root():
    response = client.get("/")
    assert response.status_code == 200
yaml
Copy
Edit

---

 Add Future Improvements**

```markdown
### Future Improvements

- Add dashboards (Metabase, Superset)
- Add versioned data lake (S3, MinIO)
- Add alerting (Prometheus + Grafana)
- Retrain YOLO on local images for custom detection

## Conclusion:

This project successfully demonstrates the end-to-end process of building a data warehouse solution for a real-world business need. By combining data scraping techniques, data cleaning and transformation methodologies using DBT, object detection with YOLO, and a robust data warehouse architecture, this project delivers a valuable tool for analyzing Ethiopian medical business data. The exposed API using FastAPI further enhances accessibility and utility, enabling Kara Solutions and their clients to efficiently query and utilize the collected insights. The key takeaway is the ability to leverage modern data engineering and AI techniques to transform raw, unstructured data into actionable intelligence, ultimately driving better decision-making within the Ethiopian medical business sector. Future work can focus on improving the accuracy of object detection, expanding the data sources, and refining the API to offer more sophisticated analytical capabilities.
````


