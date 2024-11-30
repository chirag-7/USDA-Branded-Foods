Use  Food;

-- Drop existing tables if they exist, in the correct order
DROP TABLE IF EXISTS food_attribute;
DROP TABLE IF EXISTS food_update_log_entry;
DROP TABLE IF EXISTS food_nutrient;
DROP TABLE IF EXISTS microbe;
DROP TABLE IF EXISTS nutrient_incoming_name;
DROP TABLE IF EXISTS food;
DROP TABLE IF EXISTS food_attribute_type;
DROP TABLE IF EXISTS branded_food; -- Now safe to drop
DROP TABLE IF EXISTS measure_unit;
DROP TABLE IF EXISTS nutrient;

-- Create the branded_food table
CREATE TABLE branded_food (
    fdc_id INT PRIMARY KEY,
    brand_owner VARCHAR(255),
    brand_name VARCHAR(255),
    subbrand_name VARCHAR(255),
    gtin_upc VARCHAR(255),
    ingredients TEXT,
    not_a_significant_source_of VARCHAR(255),
    serving_size FLOAT,
    serving_size_unit VARCHAR(50),
    household_serving_fulltext TEXT,
    branded_food_category VARCHAR(255),
    data_source VARCHAR(255),
    package_weight VARCHAR(50),
    modified_date DATE,
    available_date DATE,
    market_country VARCHAR(100),
    discontinued_date DATE,
    preparation_state_code VARCHAR(50),
    trade_channel VARCHAR(50),
    short_description TEXT
);

-- Create the food_attribute_type table
CREATE TABLE food_attribute_type (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT
);

-- Create the food_attribute table
CREATE TABLE food_attribute (
    id INT PRIMARY KEY,
    fdc_id INT,
    seq_num FLOAT,
    food_attribute_type_id INT,
    name VARCHAR(255),
    value INT,
    FOREIGN KEY (fdc_id) REFERENCES branded_food(fdc_id),
    FOREIGN KEY (food_attribute_type_id) REFERENCES food_attribute_type(id)
);

-- Create the food_update_log_entry table
CREATE TABLE food_update_log_entry (
    id INT PRIMARY KEY,
    description TEXT,
    last_updated DATE,
    fdc_id INT,
    FOREIGN KEY (fdc_id) REFERENCES branded_food(fdc_id)
);

-- Create the measure_unit table
CREATE TABLE measure_unit (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

-- Create the nutrient table
CREATE TABLE nutrient (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    unit_name VARCHAR(50),
    nutrient_nbr FLOAT,
    `rank` FLOAT  -- Enclose 'rank' in backticks
);

-- Create the food table
CREATE TABLE food (
    fdc_id INT PRIMARY KEY,
    data_type VARCHAR(100),
    description TEXT,
    food_category_id FLOAT,
    publication_date DATE,
    market_country VARCHAR(100),
    trade_channel VARCHAR(100),
    microbe_data TEXT,
    FOREIGN KEY (fdc_id) REFERENCES branded_food(fdc_id)
);

-- Create the food_nutrient table
CREATE TABLE food_nutrient (
    id INT PRIMARY KEY,
    fdc_id INT,
    nutrient_id INT,
    amount FLOAT,
    data_points FLOAT,
    derivation_id FLOAT,
    min FLOAT,
    max FLOAT,
    median FLOAT,
    footnote FLOAT,
    min_year_acquired FLOAT,
    unit_id INT,
    FOREIGN KEY (fdc_id) REFERENCES food(fdc_id),
    FOREIGN KEY (nutrient_id) REFERENCES nutrient(id),
    FOREIGN KEY (unit_id) REFERENCES measure_unit(id)
);

-- Create the microbe table
CREATE TABLE microbe (
    id INT PRIMARY KEY,
    foodId INT,
    method VARCHAR(255),
    microbe_code VARCHAR(255),
    min_value INT,
    max_value FLOAT,
    uom VARCHAR(50),
    FOREIGN KEY (foodId) REFERENCES food(fdc_id)
);

-- Create the nutrient_incoming_name table
CREATE TABLE nutrient_incoming_name (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    nutrient_id INT,
    FOREIGN KEY (nutrient_id) REFERENCES nutrient(id)
);
