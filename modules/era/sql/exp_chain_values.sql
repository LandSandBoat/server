-- Updates exp_chain_values back to Era-2007
UPDATE exp_chain_values SET chain_time = 80000 WHERE chain_number = 0 and upper_level = 10; -- Chaintime to 1min 20sec
UPDATE exp_chain_values SET chain_time = 80000 WHERE chain_number = 1 and upper_level = 10; -- Chaintime to 1min 20sec
UPDATE exp_chain_values SET chain_time = 60000 WHERE chain_number = 2 and upper_level = 10; -- Chaintime to 1min
UPDATE exp_chain_values SET chain_time = 40000 WHERE chain_number = 3 and upper_level = 10; -- Chaintime to 40sec
UPDATE exp_chain_values SET chain_time = 30000 WHERE chain_number = 4 and upper_level = 10; -- Chaintime to 30sec
UPDATE exp_chain_values SET chain_time = 15000 WHERE chain_number = 5 and upper_level = 10; -- Chaintime to 15sec
UPDATE exp_chain_values SET chain_time = 15000, exp_multiplier = 1.50 WHERE chain_number = 6 and upper_level = 10; -- Chaintime to 15sec, exp % to 1.5

UPDATE exp_chain_values SET chain_time = 130000 WHERE chain_number = 0 and upper_level = 20; -- Chaintime to 2min 10sec
UPDATE exp_chain_values SET chain_time = 130000 WHERE chain_number = 1 and upper_level = 20; -- Chaintime to 2min 10sec
UPDATE exp_chain_values SET chain_time = 110000 WHERE chain_number = 2 and upper_level = 20; -- Chaintime to 1min 50sec
UPDATE exp_chain_values SET chain_time = 80000  WHERE chain_number = 3 and upper_level = 20; -- Chaintime to 1min 20sec
UPDATE exp_chain_values SET chain_time = 60000  WHERE chain_number = 4 and upper_level = 20; -- Chaintime to 1min
UPDATE exp_chain_values SET chain_time = 25000  WHERE chain_number = 5 and upper_level = 20; -- Chaintime to 15sec
UPDATE exp_chain_values SET chain_time = 25000, exp_multiplier = 1.50 WHERE chain_number = 6 and upper_level = 20; -- Chaintime to 25sec, exp % to 1.5

UPDATE exp_chain_values SET chain_time = 160000 WHERE chain_number = 0 and upper_level = 30; -- Chaintime to 2min 40sec
UPDATE exp_chain_values SET chain_time = 150000 WHERE chain_number = 1 and upper_level = 30; -- Chaintime to 2min 30sec
UPDATE exp_chain_values SET chain_time = 120000 WHERE chain_number = 2 and upper_level = 30; -- Chaintime to 2min
UPDATE exp_chain_values SET chain_time = 90000  WHERE chain_number = 3 and upper_level = 30; -- Chaintime to 1min 30sec
UPDATE exp_chain_values SET chain_time = 60000  WHERE chain_number = 4 and upper_level = 30; -- Chaintime to 1min
UPDATE exp_chain_values SET chain_time = 30000  WHERE chain_number = 5 and upper_level = 30; -- Chaintime to 30sec
UPDATE exp_chain_values SET chain_time = 30000, exp_multiplier = 1.50 WHERE chain_number = 6 and upper_level = 30; -- Chaintime to 30sec, exp % to 1.5

UPDATE exp_chain_values SET chain_time = 200000 WHERE chain_number = 0 and upper_level = 40; -- Chaintime to 3min 20sec
UPDATE exp_chain_values SET chain_time = 200000 WHERE chain_number = 1 and upper_level = 40; -- Chaintime to 3min 20sec
UPDATE exp_chain_values SET chain_time = 170000 WHERE chain_number = 2 and upper_level = 40; -- Chaintime to 2min 50sec
UPDATE exp_chain_values SET chain_time = 130000 WHERE chain_number = 3 and upper_level = 40; -- Chaintime to 2min 10sec
UPDATE exp_chain_values SET chain_time = 80000  WHERE chain_number = 4 and upper_level = 40; -- Chaintime to 1min 20sec
UPDATE exp_chain_values SET chain_time = 40000  WHERE chain_number = 5 and upper_level = 40; -- Chaintime to 40sec
UPDATE exp_chain_values SET chain_time = 40000, exp_multiplier = 1.50 WHERE chain_number = 6 and upper_level = 40; -- Chaintime to 40sec, exp % to 1.5

UPDATE exp_chain_values SET chain_time = 290000 WHERE chain_number = 0 and upper_level = 50; -- Chaintime to 4min 50sec
UPDATE exp_chain_values SET chain_time = 290000 WHERE chain_number = 1 and upper_level = 50; -- Chaintime to 4min 50sec
UPDATE exp_chain_values SET chain_time = 230000 WHERE chain_number = 2 and upper_level = 50; -- Chaintime to 3min 50sec
UPDATE exp_chain_values SET chain_time = 170000 WHERE chain_number = 3 and upper_level = 50; -- Chaintime to 2min 50sec
UPDATE exp_chain_values SET chain_time = 110000 WHERE chain_number = 4 and upper_level = 50; -- Chaintime to 1min 50sec
UPDATE exp_chain_values SET chain_time = 50000  WHERE chain_number = 5 and upper_level = 50; -- Chaintime to 50sec
UPDATE exp_chain_values SET chain_time = 50000, exp_multiplier = 1.50 WHERE chain_number = 6 and upper_level = 50; -- Chaintime to 50sec, exp % to 1.5

UPDATE exp_chain_values SET chain_time = 300000 WHERE chain_number = 0 and upper_level = 60; -- Chaintime to 5min
UPDATE exp_chain_values SET chain_time = 300000 WHERE chain_number = 1 and upper_level = 60; -- Chaintime to 5min
UPDATE exp_chain_values SET chain_time = 240000 WHERE chain_number = 2 and upper_level = 60; -- Chaintime to 4min
UPDATE exp_chain_values SET chain_time = 180000 WHERE chain_number = 3 and upper_level = 60; -- Chaintime to 3min
UPDATE exp_chain_values SET chain_time = 120000 WHERE chain_number = 4 and upper_level = 60; -- Chaintime to 2min
UPDATE exp_chain_values SET chain_time = 60000  WHERE chain_number = 5 and upper_level = 60; -- Chaintime to 1min
UPDATE exp_chain_values SET chain_time = 60000, exp_multiplier = 1.50 WHERE chain_number = 6 and upper_level = 60; -- Chaintime to 1min, exp % to 1.5

-- Else, fall through to this:
UPDATE exp_chain_values SET chain_time = 300000 WHERE chain_number = 0 and upper_level = 99; -- Chaintime to 5min
UPDATE exp_chain_values SET chain_time = 300000 WHERE chain_number = 1 and upper_level = 99; -- Chaintime to 5min
UPDATE exp_chain_values SET chain_time = 240000 WHERE chain_number = 2 and upper_level = 99; -- Chaintime to 4min
UPDATE exp_chain_values SET chain_time = 180000 WHERE chain_number = 3 and upper_level = 99; -- Chaintime to 3min
UPDATE exp_chain_values SET chain_time = 120000 WHERE chain_number = 4 and upper_level = 99; -- Chaintime to 2min
UPDATE exp_chain_values SET chain_time = 60000  WHERE chain_number = 5 and upper_level = 99; -- Chaintime to 1min
UPDATE exp_chain_values SET chain_time = 60000, exp_multiplier = 1.50 WHERE chain_number = 6 and upper_level = 99; -- Chaintime to 1min, exp % to 1.5
