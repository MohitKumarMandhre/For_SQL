from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.python import PythonOperator

default_args={
    'owner':'ram',
    'retries':3,
    'retry_delay': timedelta(minutes=2)
}

def func1(ti):
    ti.xcom_push(key='fname',value='Rama')
    ti.xcom_push(key='lname',value='Krishna')

def func2(ti):
    name=ti.xcom_pull(task_ids='get_name',key='fname')+" "+ti.xcom_pull(task_ids='get_name',key='lname')
    print(f"Hello world ! My name is {name}")

with DAG(
default_args=default_args,
dag_id="dag2_pyth",
description="dag for python operator",
start_date=datetime(2023,4,13),
schedule_interval='@daily'
) as dag:
    task1 = PythonOperator(
        task_id='func2',
        python_callable=func2
        
    )
    task2=PythonOperator(
        task_id='func1',
        python_callable=func1

    )
task2>>task1