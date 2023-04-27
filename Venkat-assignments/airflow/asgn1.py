from airflow import DAG
from datetime import datetime
from airflow.providers.postgres.operators.postgres import PostgresOperator


with DAG('asgn1',start_date=datetime(2023,1,1),schedule_interval='@daily',catchup=False) as dag:
    create_table=PostgresOperator(
        task_id='create_table',
        postgres_conn_id='airflow',
        sql='''
            CREATE TABLE IF NOT EXISTS asgn1 (
                firstname TEXT NOT NULL,
                lastname TEXT NOT NULL,
                country TEXT NOT NULL,
                username TEXT NOT NULL,
                password TEXT NOT NULL,
                email TEXT NOT NULL
            );
        '''
    )
    create_table