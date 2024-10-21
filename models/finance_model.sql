{{ config(materialized='table') }}


with base_finance as (
SELECT
    *
from {{ref("base_finance")}}
),

with fact_finance as(
SELECT 
    TO_DATE(base_finance.DATA, 'DD/MM/YYYY') AS DATA,
    REPLACE(base_finance.VALOR, '-', '') AS VALOR,
    base_finance.LANCAMENTO,
    base_finance."TIPO LANCAMENTO",
    TRIM(
        REGEXP_REPLACE(
            CASE 
                WHEN base_finance.DETALHES IS NULL THEN base_finance.LANCAMENTO 
                ELSE base_finance.DETALHES 
            END, 
            '[^A-Za-z ]', ''
        )
    ) AS DETALHES
FROM
    base_finance
WHERE
    base_finance."TIPO LANCAMENTO" IS NOT NULL 
    AND base_finance."TIPO LANCAMENTO" IN ('Entrada','Saída')
)

select *from fact_finance
