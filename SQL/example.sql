/* This query provides an example of a Snowflake query that is
consistent with the styling guide outlined in this repository.
The table and variable names are fictional for this example. */

-- Extract List of Diabetes ICD Codes
WITH DIAB AS (
  SELECT
    ICD_CODE
  FROM ICD.DISEASES
  -- Select diabetes only
  WHERE DISEASE = 'DIABETES'
)

SELECT
  -- Unique Medical Record Number for the Patient
  MORB_EP.UMRN,
  -- Convert TRANSFER_STATUS to text format
  CASE
    WHEN MORB_EP.TRANSFER_STATUS = 1 THEN 'Transferred to Another Hospital'
    WHEN MORB_EP.TRANSFER_STATUS = 0 THEN 'Not Transferred'
    ELSE NULL
  END AS TRANSFER_TEXT,
  -- Demographic Information from CLIENT table
  CLIENT.DATE_OF_BIRTH,
  CLIENT.SEX,
  CLIENT.ATSI,
  -- Calculating the total
  SUM(MORB_EP.LENGTH_OF_STAY_DAYS) AS SUM_LOS
FROM HMDC.MORBIDITY_EPISODE AS MORB_EP
-- Inner Join to List of Diabetes ICD Codes to extract episodes where diabetes is the principal diagnosis only
INNER JOIN DIAB
  ON DIAB.ICD_CODE = MORB_EP.PRINCIPAL_DIAGNOSIS
-- Left Join to Client Table for Demographic Information
LEFT JOIN HMDC.CLIENT AS CLIENT
  ON CLIENT.UMRN = MORB_EP.UMRN
WHERE
  -- Select publicly funded patients only
  PUBLIC_PATIENT = 1
  -- Select Episodes from 2020 to 2022
  AND SEPARATION_DATE >= '2020-01-01'
  AND SEPARATION_DATE <= '2022-12-31'
-- Apply Group By across all non aggregated variables
GROUP BY
  MORB_EP.UMRN,
  CLIENT.DATE_OF_BIRTH,
  CLIENT.SEX,
  CLIENT.ATSI,
  TRANSFER_TEXT
-- Order by UMRN
ORDER BY
  MORB_EP.UMRN ASC