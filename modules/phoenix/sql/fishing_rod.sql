-- Temporary module to apply adjusted max rank value of fishing rods

UPDATE fishing_rod SET max_rank = 12 where name = 'Clothespole';
UPDATE fishing_rod SET max_rank = 13 where name = 'Single Hook Fishing Rod';
UPDATE fishing_rod SET max_rank = 15 where name = 'Hume Fishing Rod';
UPDATE fishing_rod SET max_rank = 7 where name = 'Bamboo Fishing Rod';
UPDATE fishing_rod SET max_rank = 8 where name = 'Fastwater Fishing Rod';
