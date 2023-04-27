from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.postgres_operator import PostgresOperator
from airflow.operators.python_operator import PythonOperator
# from airflow.operators.http_operator import SimpleHTTPOperator
# from airflow.operators.sensor_operator import HttpSensorOperator
# from airflow.providers.aws.hooks.s3 import S3Hook 

default_args = {
    'owner': 'airflow',
    'start_date': datetime(2023, 4, 12),
    'retries': 3,
    'retry_delay': timedelta(minutes=2)
}

def user_creation():
    return {
        'id': 102,
        'fname': 'John',
        'lname': 'Smith'
    }
    
def user_storing(user):
    user['name'] = user['fname']+user['lname'] 
    return user

# def 

with DAG(
    'day1_dag',
    default_args=default_args,
    description='day 1 dag functioning',
    schedule_interval=timedelta(days = 1),
) as dag:
    
    create_table_task1 = PostgresOperator(
        task_id='creating_table_in_pgsql',
        postgres_conn_id='postgres_default',
        sql='''create table if not exists emp(id int, fname varchar(40), lname varchar(40));''',
        dag=dag
    )

    # insert_table_task2 = PostgresOperator(
    #     task_id='insert_data',
    #     postgres_conn_id='postgres_default',
    #     sql='''insert into table emp (id, fname, lname) values(100, 'John', 'Doe');''',
    #     dag=dag
    # )

    user_creation_task2=PythonOperator(
        task_id='creating_user_data',
        python_callable=user_creation,
        dag=dag
    )

    store_user_task3= PythonOperator(
        task_id= 'storing_user_data',
        python_callable=user_storing,
        op_kwargs={'user': '{{ti.xcom_pull(task_id="creating_user_data")}}'},
        dag=dag
    )

create_table_task1 >> user_creation_task2 >> store_user_task3