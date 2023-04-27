from airflow.decorators import dag, task
from datetime import datetime

@dag(start_date=datetime(2023, 1,1),schedule='@daily')
def my_dag():
    @task
    def task_a(val):
        return val + 42
    @task
    def task_b(val):
        print(val)
    task_b(task_a(42))
my_dag()