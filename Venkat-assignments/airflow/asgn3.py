from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2023, 4, 12,21,40),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}
dag = DAG(
    'sample_dag',
    default_args=default_args,
    description='A sample DAG for Airflow',
    schedule_interval=timedelta(days=1),
)
task1 = BashOperator(
    task_id='task1',
    bash_command='echo "Task 1"',
    dag=dag,
)
task2 = BashOperator(
    task_id='task2',
    bash_command='echo "Task 2"',
    dag=dag,
)
task3 = BashOperator(
    task_id='task3',
    bash_command='echo "Task 3"',
    dag=dag,
)

task1>>[task2,task3]