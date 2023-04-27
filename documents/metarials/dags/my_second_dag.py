from datetime import datetime
from airflow.decorators import dag, task
from airflow.utils.dates import days_ago

# Define default arguments for the DAG
default_args = {
    'start_date': days_ago(1),
    'owner': 'airflow',
}

# Define the DAG using the @dag decorator
@dag(default_args=default_args, schedule_interval='@daily', catchup=False)
def my_simple_dag():

    # Define the first task using the @task decorator
    @task()
    def extract_data():
        return "Data extracted successfully!"

    # Define the second task using the @task decorator
    @task()
    def transform_data(data):
        return data.upper()

    # Define the third task using the @task decorator
    @task()
    def load_data(data):
        print(f"Data loaded: {data}")

    # Define the order of the tasks
    data = extract_data()
    transformed_data = transform_data(data)
    load_data(transformed_data)

# Instantiate the DAG
dag = my_simple_dag()
