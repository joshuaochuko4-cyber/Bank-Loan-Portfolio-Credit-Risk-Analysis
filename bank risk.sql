USE master;
GO

DROP DATABASE IF EXISTS BankCreditRisk;
GO

CREATE DATABASE BankCreditRisk;
GO

USE BankCreditRisk;
GO

DROP TABLE IF EXISTS dbo.LoanApplication;
GO

USE BankCreditRisk;
GO

SELECT COUNT(*) AS Total_Rows
FROM dbo.LoanApplication;

SELECT 
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT SK_ID_CURR) AS Unique_Customers
FROM dbo.LoanApplication;

USE BankCreditRisk;
GO

SELECT
    TARGET,
    COUNT(*) AS Application_Count,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS DECIMAL(10,2)) AS Percentage
FROM dbo.LoanApplication
GROUP BY TARGET
ORDER BY TARGET;

SELECT
    COUNT(*) AS Total_Applications,
    SUM(AMT_CREDIT) AS Total_Credit_Exposure,
    AVG(AMT_CREDIT) AS Average_Credit,
    AVG(AMT_INCOME_TOTAL) AS Average_Income,
    AVG(AMT_ANNUITY) AS Average_Annuity
FROM dbo.LoanApplication;

SELECT
    NAME_CONTRACT_TYPE AS Loan_Type,
    COUNT(*) AS Applications,
    SUM(AMT_CREDIT) AS Total_Credit_Exposure,
    AVG(AMT_CREDIT) AS Average_Credit,
    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) AS Repayment_Difficulty_Count,
    CAST(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Repayment_Difficulty_Rate
FROM dbo.LoanApplication
GROUP BY NAME_CONTRACT_TYPE
ORDER BY Applications DESC;

SELECT
    NAME_INCOME_TYPE AS Income_Type,
    COUNT(*) AS Applications,
    SUM(AMT_CREDIT) AS Total_Credit_Exposure,
    AVG(AMT_CREDIT) AS Average_Credit,
    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) AS Repayment_Difficulty_Count,
    CAST(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Repayment_Difficulty_Rate
FROM dbo.LoanApplication
GROUP BY NAME_INCOME_TYPE
ORDER BY Repayment_Difficulty_Rate DESC;

SELECT
    NAME_EDUCATION_TYPE AS Education_Type,
    COUNT(*) AS Applications,
    SUM(AMT_CREDIT) AS Total_Credit_Exposure,
    AVG(AMT_CREDIT) AS Average_Credit,
    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) AS Repayment_Difficulty_Count,
    CAST(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Repayment_Difficulty_Rate
FROM dbo.LoanApplication
GROUP BY NAME_EDUCATION_TYPE
ORDER BY Applications DESC;

SELECT
    NAME_HOUSING_TYPE AS Housing_Type,
    COUNT(*) AS Applications,
    SUM(AMT_CREDIT) AS Total_Credit_Exposure,
    AVG(AMT_CREDIT) AS Average_Credit,
    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) AS Repayment_Difficulty_Count,
    CAST(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Repayment_Difficulty_Rate
FROM dbo.LoanApplication
GROUP BY NAME_HOUSING_TYPE
ORDER BY Applications DESC;

SELECT
    CASE
        WHEN Loan_to_Income < 2 THEN 'Below 2x'
        WHEN Loan_to_Income < 4 THEN '2x - 4x'
        WHEN Loan_to_Income < 6 THEN '4x - 6x'
        WHEN Loan_to_Income < 10 THEN '6x - 10x'
        ELSE '10x+'
    END AS Loan_to_Income_Band,
    COUNT(*) AS Applications,
    SUM(AMT_CREDIT) AS Total_Credit_Exposure,
    AVG(AMT_CREDIT) AS Average_Credit,
    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) AS Repayment_Difficulty_Count,
    CAST(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Repayment_Difficulty_Rate
FROM dbo.LoanApplication
WHERE Loan_to_Income IS NOT NULL
GROUP BY
    CASE
        WHEN Loan_to_Income < 2 THEN 'Below 2x'
        WHEN Loan_to_Income < 4 THEN '2x - 4x'
        WHEN Loan_to_Income < 6 THEN '4x - 6x'
        WHEN Loan_to_Income < 10 THEN '6x - 10x'
        ELSE '10x+'
    END
ORDER BY
    CASE
        WHEN Loan_to_Income < 2 THEN 1
        WHEN Loan_to_Income < 4 THEN 2
        WHEN Loan_to_Income < 6 THEN 3
        WHEN Loan_to_Income < 10 THEN 4
        ELSE 5
    END;

	SELECT
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age < 35 THEN '25 - 34'
        WHEN Age < 45 THEN '35 - 44'
        WHEN Age < 55 THEN '45 - 54'
        ELSE '55+'
    END AS Age_Band,
    COUNT(*) AS Applications,
    SUM(AMT_CREDIT) AS Total_Credit_Exposure,
    AVG(AMT_CREDIT) AS Average_Credit,
    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) AS Repayment_Difficulty_Count,
    CAST(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Repayment_Difficulty_Rate
FROM dbo.LoanApplication
WHERE Age IS NOT NULL
GROUP BY
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age < 35 THEN '25 - 34'
        WHEN Age < 45 THEN '35 - 44'
        WHEN Age < 55 THEN '45 - 54'
        ELSE '55+'
    END
ORDER BY
    CASE
        WHEN Age < 25 THEN 1
        WHEN Age < 35 THEN 2
        WHEN Age < 45 THEN 3
        WHEN Age < 55 THEN 4
        ELSE 5
    END;

	SELECT
    CASE
        WHEN EXT_SOURCE_2 < 0.25 THEN 'Very Low'
        WHEN EXT_SOURCE_2 < 0.50 THEN 'Low'
        WHEN EXT_SOURCE_2 < 0.75 THEN 'Medium'
        ELSE 'High'
    END AS EXT_Source_2_Band,
    COUNT(*) AS Applications,
    SUM(AMT_CREDIT) AS Total_Credit_Exposure,
    AVG(AMT_CREDIT) AS Average_Credit,
    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) AS Repayment_Difficulty_Count,
    CAST(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Repayment_Difficulty_Rate
FROM dbo.LoanApplication
WHERE EXT_SOURCE_2 IS NOT NULL
GROUP BY
    CASE
        WHEN EXT_SOURCE_2 < 0.25 THEN 'Very Low'
        WHEN EXT_SOURCE_2 < 0.50 THEN 'Low'
        WHEN EXT_SOURCE_2 < 0.75 THEN 'Medium'
        ELSE 'High'
    END
ORDER BY
    CASE
        WHEN EXT_SOURCE_2 < 0.25 THEN 1
        WHEN EXT_SOURCE_2 < 0.50 THEN 2
        WHEN EXT_SOURCE_2 < 0.75 THEN 3
        ELSE 4
    END;

	SELECT
    REGION_RATING_CLIENT AS Region_Rating,
    COUNT(*) AS Applications,
    SUM(AMT_CREDIT) AS Total_Credit_Exposure,
    AVG(AMT_CREDIT) AS Average_Credit,
    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) AS Repayment_Difficulty_Count,
    CAST(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Repayment_Difficulty_Rate
FROM dbo.LoanApplication
WHERE REGION_RATING_CLIENT IS NOT NULL
GROUP BY REGION_RATING_CLIENT
ORDER BY REGION_RATING_CLIENT;

SELECT
    CODE_GENDER AS Gender,
    COUNT(*) AS Applications,
    SUM(AMT_CREDIT) AS Total_Credit_Exposure,
    AVG(AMT_CREDIT) AS Average_Credit,
    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) AS Repayment_Difficulty_Count,
    CAST(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Repayment_Difficulty_Rate
FROM dbo.LoanApplication
GROUP BY CODE_GENDER
ORDER BY Applications DESC;

SELECT
    FLAG_OWN_CAR AS Owns_Car,
    COUNT(*) AS Applications,
    SUM(AMT_CREDIT) AS Total_Credit_Exposure,
    AVG(AMT_CREDIT) AS Average_Credit,
    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) AS Repayment_Difficulty_Count,
    CAST(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Repayment_Difficulty_Rate
FROM dbo.LoanApplication
GROUP BY FLAG_OWN_CAR
ORDER BY Applications DESC;

SELECT
    FLAG_OWN_REALTY AS Owns_Realty,
    COUNT(*) AS Applications,
    SUM(AMT_CREDIT) AS Total_Credit_Exposure,
    AVG(AMT_CREDIT) AS Average_Credit,
    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) AS Repayment_Difficulty_Count,
    CAST(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Repayment_Difficulty_Rate
FROM dbo.LoanApplication
GROUP BY FLAG_OWN_REALTY
ORDER BY Applications DESC;

SELECT
    NAME_FAMILY_STATUS AS Family_Status,
    COUNT(*) AS Applications,
    SUM(AMT_CREDIT) AS Total_Credit_Exposure,
    AVG(AMT_CREDIT) AS Average_Credit,
    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) AS Repayment_Difficulty_Count,
    CAST(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Repayment_Difficulty_Rate
FROM dbo.LoanApplication
GROUP BY NAME_FAMILY_STATUS
ORDER BY Applications DESC;

SELECT
    CASE
        WHEN Loan_to_Income < 2 THEN 'Below 2x'
        WHEN Loan_to_Income < 3 THEN '2x - 3x'
        WHEN Loan_to_Income < 5 THEN '3x - 5x'
        WHEN Loan_to_Income < 10 THEN '5x - 10x'
        ELSE '10x and above'
    END AS Loan_to_Income_Band,
    COUNT(*) AS Applications,
    SUM(AMT_CREDIT) AS Total_Credit_Exposure,
    AVG(AMT_CREDIT) AS Average_Credit,
    AVG(Loan_to_Income) AS Average_Loan_to_Income,
    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) AS Repayment_Difficulty_Count,
    CAST(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Repayment_Difficulty_Rate
FROM dbo.LoanApplication
WHERE Loan_to_Income IS NOT NULL
GROUP BY
    CASE
        WHEN Loan_to_Income < 2 THEN 'Below 2x'
        WHEN Loan_to_Income < 3 THEN '2x - 3x'
        WHEN Loan_to_Income < 5 THEN '3x - 5x'
        WHEN Loan_to_Income < 10 THEN '5x - 10x'
        ELSE '10x and above'
    END
ORDER BY
    MIN(Loan_to_Income);

	SELECT
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age < 35 THEN '25 - 34'
        WHEN Age < 45 THEN '35 - 44'
        WHEN Age < 55 THEN '45 - 54'
        WHEN Age < 65 THEN '55 - 64'
        ELSE '65+'
    END AS Age_Band,
    COUNT(*) AS Applications,
    SUM(AMT_CREDIT) AS Total_Credit_Exposure,
    AVG(AMT_CREDIT) AS Average_Credit,
    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) AS Repayment_Difficulty_Count,
    CAST(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Repayment_Difficulty_Rate
FROM dbo.LoanApplication
WHERE Age IS NOT NULL
GROUP BY
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age < 35 THEN '25 - 34'
        WHEN Age < 45 THEN '35 - 44'
        WHEN Age < 55 THEN '45 - 54'
        WHEN Age < 65 THEN '55 - 64'
        ELSE '65+'
    END
ORDER BY
    MIN(Age);

	SELECT
    CASE
        WHEN EXT_SOURCE_2 < 0.3 THEN 'Below 0.30'
        WHEN EXT_SOURCE_2 < 0.5 THEN '0.30 - 0.49'
        WHEN EXT_SOURCE_2 < 0.7 THEN '0.50 - 0.69'
        WHEN EXT_SOURCE_2 < 0.9 THEN '0.70 - 0.89'
        ELSE '0.90+'
    END AS External_Score_Band,
    
    COUNT(*) AS Applications,
    
    SUM(AMT_CREDIT) AS Total_Credit_Exposure,
    
    AVG(AMT_CREDIT) AS Average_Credit,
    
    AVG(EXT_SOURCE_2) AS Average_External_Score,
    
    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END)
        AS Repayment_Difficulty_Count,
    
    CAST(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Repayment_Difficulty_Rate

FROM dbo.LoanApplication

WHERE EXT_SOURCE_2 IS NOT NULL

GROUP BY
    CASE
        WHEN EXT_SOURCE_2 < 0.3 THEN 'Below 0.30'
        WHEN EXT_SOURCE_2 < 0.5 THEN '0.30 - 0.49'
        WHEN EXT_SOURCE_2 < 0.7 THEN '0.50 - 0.69'
        WHEN EXT_SOURCE_2 < 0.9 THEN '0.70 - 0.89'
        ELSE '0.90+'
    END

ORDER BY
    MIN(EXT_SOURCE_2);

	SELECT
    CASE
        WHEN EXT_SOURCE_3 < 0.3 THEN 'Below 0.30'
        WHEN EXT_SOURCE_3 < 0.5 THEN '0.30 - 0.49'
        WHEN EXT_SOURCE_3 < 0.7 THEN '0.50 - 0.69'
        WHEN EXT_SOURCE_3 < 0.9 THEN '0.70 - 0.89'
        ELSE '0.90+'
    END AS External_Score_Band,

    COUNT(*) AS Applications,

    SUM(AMT_CREDIT) AS Total_Credit_Exposure,

    AVG(AMT_CREDIT) AS Average_Credit,

    AVG(EXT_SOURCE_3) AS Average_External_Score,

    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END)
        AS Repayment_Difficulty_Count,

    CAST(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Repayment_Difficulty_Rate

FROM dbo.LoanApplication

WHERE EXT_SOURCE_3 IS NOT NULL

GROUP BY
    CASE
        WHEN EXT_SOURCE_3 < 0.3 THEN 'Below 0.30'
        WHEN EXT_SOURCE_3 < 0.5 THEN '0.30 - 0.49'
        WHEN EXT_SOURCE_3 < 0.7 THEN '0.50 - 0.69'
        WHEN EXT_SOURCE_3 < 0.9 THEN '0.70 - 0.89'
        ELSE '0.90+'
    END

ORDER BY
    MIN(EXT_SOURCE_3);

	SELECT TOP 10
    ORGANIZATION_TYPE AS Organization_Type,
    COUNT(*) AS Applications,
    SUM(AMT_CREDIT) AS Total_Credit_Exposure,
    AVG(AMT_CREDIT) AS Average_Credit,
    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END)
        AS Repayment_Difficulty_Count,
    CAST(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Repayment_Difficulty_Rate
FROM dbo.LoanApplication
GROUP BY ORGANIZATION_TYPE
ORDER BY Total_Credit_Exposure DESC;

WITH OrganizationAnalysis AS
(
    SELECT
        ORGANIZATION_TYPE AS Organization_Type,
        COUNT(*) AS Applications,
        SUM(AMT_CREDIT) AS Total_Credit_Exposure,
        AVG(AMT_CREDIT) AS Average_Credit,
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END)
            AS Repayment_Difficulty_Count,
        CAST(
            SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
            / COUNT(*)
            AS DECIMAL(10,2)
        ) AS Repayment_Difficulty_Rate
    FROM dbo.LoanApplication
    GROUP BY ORGANIZATION_TYPE
),
OverallRate AS
(
    SELECT
        CAST(
            SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
            / COUNT(*)
            AS DECIMAL(10,2)
        ) AS Overall_Difficulty_Rate
    FROM dbo.LoanApplication
)

SELECT
    O.Organization_Type,
    O.Applications,
    O.Total_Credit_Exposure,
    O.Average_Credit,
    O.Repayment_Difficulty_Count,
    O.Repayment_Difficulty_Rate,
    R.Overall_Difficulty_Rate
FROM OrganizationAnalysis O
CROSS JOIN OverallRate R
WHERE O.Applications >= 1000
  AND O.Repayment_Difficulty_Rate > R.Overall_Difficulty_Rate
ORDER BY O.Total_Credit_Exposure DESC;

SELECT
    REGION_RATING_CLIENT AS Region_Rating,
    COUNT(*) AS Applications,
    SUM(AMT_CREDIT) AS Total_Credit_Exposure,
    AVG(AMT_CREDIT) AS Average_Credit,
    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END)
        AS Repayment_Difficulty_Count,
    CAST(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Repayment_Difficulty_Rate
FROM dbo.LoanApplication
GROUP BY REGION_RATING_CLIENT
ORDER BY REGION_RATING_CLIENT;

SELECT
    ORGANIZATION_TYPE AS Organization_Type,
    COUNT(*) AS Applications,
    SUM(AMT_CREDIT) AS Total_Credit_Exposure,
    CAST(
        SUM(AMT_CREDIT) * 100.0
        / SUM(SUM(AMT_CREDIT)) OVER ()
        AS DECIMAL(10,2)
    ) AS Exposure_Share_Percent,
    RANK() OVER (
        ORDER BY SUM(AMT_CREDIT) DESC
    ) AS Exposure_Rank
FROM dbo.LoanApplication
GROUP BY ORGANIZATION_TYPE
ORDER BY Exposure_Rank;

SELECT
    CASE
        WHEN Loan_to_Income < 2 THEN 'Below 2x'
        WHEN Loan_to_Income < 3 THEN '2x - 3x'
        WHEN Loan_to_Income < 5 THEN '3x - 5x'
        WHEN Loan_to_Income < 10 THEN '5x - 10x'
        ELSE '10x+'
    END AS Loan_to_Income_Band,

    COUNT(*) AS Applications,

    SUM(AMT_CREDIT) AS Total_Credit_Exposure,

    AVG(Loan_to_Income) AS Average_Loan_to_Income,

    SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END)
        AS Repayment_Difficulty_Count,

    CAST(
        SUM(CASE WHEN TARGET = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Repayment_Difficulty_Rate

FROM dbo.LoanApplication

WHERE Loan_to_Income IS NOT NULL

GROUP BY
    CASE
        WHEN Loan_to_Income < 2 THEN 'Below 2x'
        WHEN Loan_to_Income < 3 THEN '2x - 3x'
        WHEN Loan_to_Income < 5 THEN '3x - 5x'
        WHEN Loan_to_Income < 10 THEN '5x - 10x'
        ELSE '10x+'
    END

ORDER BY
    MIN(Loan_to_Income);

