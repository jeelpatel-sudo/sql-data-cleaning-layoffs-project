-- Data Cleaning plan -------------------------------------------------------------------------------------------------------------------------
-- 1. Remove duplicates
-- 2. Standardize the data 
-- 3. Remove null values or blank values 
-- 4. Remove unneccessary columns 

-- Create a staging table ------------------------------------------------------------------------------------------------------------------------- 
Create table layoffs_staging Like layoffs ;
insert layoffs_staging select * from layoffs ;
select * from layoffs_staging ;

-- 1. Remove duplicates from the data ------------------------------------------------------------------------------------------------------------------------- 
		-- 1.a) Assign row numbers within the partition to identify duplicate rows  -------------------------------------------------------------------------------------- 
select * , 
	row_number () over (partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as `row_num`
	from layoffs_staging ; 

with dulicate_cte as
 (select * , row_number () over (partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as `row_num`
	from layoffs_staging)
select * 
    from dulicate_cte
    where `row_num` > 1 ;
    
		-- 1.b) create another table as layoffs_staging 2 with a new column called row_num. Then, delete rows where row_num ---------------------------------------------
CREATE TABLE `layoffs_staging_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into layoffs_staging_2
select * , 
	row_number () over (partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as `row_num`
	from layoffs_staging ;
    
Delete from layoffs_staging_2 
	where `row_num` > 1 ;  
	
-- 2. Standardize the data ------------------------------------------------------------------------------------------------------------------------- 
		-- 2.a) Trim the data. ------------------------------------------------------------------------------------------------------------------------- 
Select trim(company), trim(location), trim(industry), trim(total_laid_off), trim(percentage_laid_off), trim(`date`) , trim(stage), trim(country), trim(funds_raised_millions)
	from layoffs_staging_2 ; 
    
UPDATE layoffs_staging_2 
	SET 
    company = TRIM(company),
    location = TRIM(location),
    industry = TRIM(industry),
    total_laid_off = TRIM(total_laid_off),
    percentage_laid_off = TRIM(percentage_laid_off),
    `date` = TRIM(`date`),
    stage = TRIM(stage),
    country = TRIM(country),
    funds_raised_millions = TRIM(funds_raised_millions);

Select distinct industry
	from layoffs_staging_2 ; 
    
Select *
	from layoffs_staging_2 
    where industry like 'crypto%' 
    order by 3 desc;
    
update layoffs_staging_2 
	set industry = 'Crypto'
	where industry like 'Crypto%' ;

Select distinct country
	from layoffs_staging_2
    order by country; 
    
update layoffs_staging_2 
	set country = 'United States'
	where country like 'United States%' ; 
    
		-- 2.b) Fix `date` type to Date ------------------------------------------------------------------------------------------------------------------------- 
Select `date`
	from layoffs_staging_2 ;
    
update layoffs_staging_2
	set `date` = str_to_date(`date`, '%m/%d/%Y') ;
    
Alter table layoffs_staging_2
	modify column `date` date ;
    
    -- 3. Remove null values or blank values -------------------------------------------------------------------------------------------------------------------------
Select * 
	from layoffs_staging_2 
    where industry is null 
	or industry = ''
    order by 1; 

update layoffs_staging_2
	set industry = null
	where industry = '' ; 
    
Select * 
	from layoffs_staging_2 
    where industry is null 
    order by 1;

Select * 
	from layoffs_staging_2 t1
    Join layoffs_staging_2 t2 
		on t1.company = t2.company
        where t1.industry is null 
        And t2.industry is not null ;
        
		-- 3.a) Accidently duplicated all the data somewhere. Lets repeat the step 1. -----------------------------------------------------------------
        
	Select * , row_number () over (partition by company, location, industry, total_laid_off, percentage_laid_off, date , stage, country, funds_raised_millions) as `row_num_2`
		from layoffs_staging_2
        order by 11 desc;
        
	With duplicate_cte_2 as (Select * , row_number () over (partition by company, location, industry, total_laid_off, percentage_laid_off, date , stage, country, funds_raised_millions) as `row_num_2`
		from layoffs_staging_2
        order by 11 desc )
	select * 
		from duplicate_cte_2 
        where `row_num_2` > 1 ;
	
    Create table layoff_staging_3 
	(
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` date DEFAULT NULL,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int DEFAULT NULL, 
  `row_num_2` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

  insert into layoff_staging_3
	select * , row_number () over (partition by company, location, industry, total_laid_off, percentage_laid_off, date , stage, country, funds_raised_millions) as `row_num_2`
	from layoffs_staging_2 ; 
        
Delete 
	from layoff_staging_3
    where `row_num_2` > 1 ; 
    
Select * 
	 from layoff_staging_3
     order by 3 ; 

		-- 3.b) Fill the null in the data. -----------------------------------------------------------------
update layoff_staging_3
		set industry = null
		where industry = '' ; 
    
Select *
		from layoff_staging_3 t1
        join layoff_staging_3 t2 
        on t1.company = t2.company 
        and t1.location= t2.location
        where t1.industry is null
        and t2.industry is not null ;
	
update layoff_staging_3 t1
		join layoff_staging_3 t2
        on t1.company = t2.company 
        set t1.industry = t2.industry
        where t1.industry is null
        and t2.industry is not null ; 
        
Select * 
    from layoff_staging_3 ;
        
       -- 4. Remove unneccessary rows and columns -----------------------------------------------------------------------------------------------
        
Delete  
	from layoff_staging_3
    where total_laid_off is null
    And percentage_laid_off is null ;
	
Alter table layoff_staging_3
	drop column `row_num`;

Alter table layoff_staging_3
	drop column `row_num_2`;
    
		-- Final data after data cleaning. --------------------------------------------------------------------------------------------------
Select * 
    from layoff_staging_3
    order by 9 desc;
