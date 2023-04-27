import airflow.utils.dates
from airflow import DAG 
from airflow.operators.empty import EmptyOperator
import pendulum

dag = DAG(
    dag_id="01_umbrella",
    description="Umbrella example with dummy operator",
    start_date=pendulum.today('UTC').add(-2),
    schedule="@daily"
)

fetch_weather_forecast = EmptyOperator(
    task_id="fetch_weather_forecast",
    dag = dag
)
fetch_sales_data=EmptyOperator(
    task_id="fetch_sales_data",
    dag= dag
)
clean_forecast_data = EmptyOperator(
    task_id="clean_forecast",
    dag= dag
)
clean_sales_data = EmptyOperator(
    task_id="clean_sales_data",
    dag= dag
)
join_datasets = EmptyOperator(
    task_id="join_data",
    dag= dag    
)
train_ml_model= EmptyOperator(
    task_id="train_ml_model",
    dag=dag
)
deploy_ml_model= EmptyOperator(
    task_id="deploy_ml_model",
    dag=dag
)

fetch_weather_forecast >> clean_forecast_data
fetch_sales_data >> clean_sales_data
[clean_sales_data, clean_forecast_data] >> join_datasets
join_datasets >> train_ml_model >> deploy_ml_model