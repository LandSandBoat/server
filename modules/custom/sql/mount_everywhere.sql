-- Allow mounting in all zones
UPDATE zone_settings SET misc = misc | 4;
