
{{ config(materialized='view') }}

WITH base_finance as (

    SELECT 
    SHEET1.DATA,
    SHEET1.VALOR,
    SHEET1.LANCAMENTO,
    SHEET1."TIPO LANCAMENTO",
    SHEET1.DETALHES 
                
FROM
    {{source('raw_finance','SHEET1')}}
    
)

SELECT * FROM base_finance
