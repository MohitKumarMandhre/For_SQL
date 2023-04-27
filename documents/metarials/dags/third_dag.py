from datetime import datetime,timedelta

from airflow.operators.bash import BashOperator

from airflow import DAG

default_args={
    'owner': 'airflow', 
    'retries': 5, 
    'retry_delay': timedelta(minutes=2) 
}

with DAG (
    dag_id= 'third_dag',
    default_args=default_args,
    description='This is our 3rd dag that we write',
    start_date=datetime (2021, 7, 29, 2),
    schedule='@daily'
) as dag:
    
    task1 =  BashOperator (
        task_id='1st_task',
        bash_command="echo hello world, this is the first task!"
    )

    task2 =  BashOperator (
        task_id='2nd_task',
        bash_command="echo hello world, this is the second task!"
    )

    task3 =  BashOperator (
        task_id='3rd_task',
        bash_command="echo hello world, this is the third task!"
    )

# task1.set_downstream(task2)
# task1.set_downstream(task3)

# task1 >> task2
# task1 >> task3

task1 >> [task2, task3]