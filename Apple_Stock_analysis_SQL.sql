-- Table creation
CREATE TABLE apple_stock_prices (
    id INT PRIMARY KEY AUTO_INCREMENT,
    trade_date DATE NOT NULL,
    open_price DECIMAL(10,2) NOT NULL,
    close_price DECIMAL(10,2) NOT NULL,
    high_price DECIMAL(10,2) NOT NULL,
    low_price DECIMAL(10,2) NOT NULL,
    volume BIGINT NOT NULL
);

-- Sample queries for dashboard

-- 1. Latest closing price
SELECT trade_date, close_price
FROM apple_stock_prices
ORDER BY trade_date DESC
LIMIT 1;

-- 2. Price trend for last 30 days
SELECT trade_date, close_price
FROM apple_stock_prices
WHERE trade_date >= CURDATE() - INTERVAL 30 DAY
ORDER BY trade_date ASC;

-- 3. Highest price in the last year
SELECT MAX(high_price) AS highest_price, trade_date
FROM apple_stock_prices
WHERE trade_date >= CURDATE() - INTERVAL 1 YEAR;

-- 4. Lowest price in the last year
SELECT MIN(low_price) AS lowest_price, trade_date
FROM apple_stock_prices
WHERE trade_date >= CURDATE() - INTERVAL 1 YEAR;

-- 5. Average trading volume in the last 30 days
SELECT AVG(volume) AS avg_volume
FROM apple_stock_prices
WHERE trade_date >= CURDATE() - INTERVAL 30 DAY;

-- 6. Moving average (7-day) of closing price (last 30 days)
SELECT
    trade_date,
    AVG(close_price) OVER (ORDER BY trade_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS moving_avg_7d
FROM apple_stock_prices
WHERE trade_date >= CURDATE() - INTERVAL 30 DAY
ORDER BY trade_date ASC;
