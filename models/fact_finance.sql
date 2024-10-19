{{ config(materialized='table') }}

with finance as (

    select * from {{ref('base_finance')}}
) 

fact_finance as (

    SELECT 
    TO_DATE(DATA, 'DD/MM/YYYY') AS DATA,
    REPLACE(VALOR, '-', '') AS VALOR,
    LANCAMENTO,
    "TIPO LANCAMENTO",
    TRIM(
        REGEXP_REPLACE(
            CASE 
                WHEN DETALHES IS NULL THEN LANCAMENTO 
                ELSE DETALHES 
            END, 
            '[^A-Za-z ]', ''
        )
    ) AS DETALHES
FROM
    base_finance
WHERE
    "TIPO LANCAMENTO" IS NOT NULL 
    AND "TIPO LANCAMENTO" IN ('Entrada','Saída')

)

select * from fact_finance