-- Remet toutes les zones sur le processus xi_map par defaut.
UPDATE zone_settings SET zoneport = 54230;
SELECT zoneport, COUNT(*) AS zones FROM zone_settings GROUP BY zoneport;
