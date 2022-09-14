-- Horizon Mob Spawn Point Tables
-- Requires the mob_spawn_points table to already exist

-- ZONE 220 - Ship Bound for Selbina

REPLACE INTO `mob_spawn_points` (`mobid`, `spawnset`, `mobname`, `polutils_name`, `groupid`, `pos_x`, `pos_y`, `pos_z`, `pos_rot`) VALUES
    (17678337, 0 , 'Sea_Pugil',                'Sea Pugil',                1,   1,         1,         1,         0  ),
    (17678338, 0 , 'Ocean_Crab',               'Ocean Crab',               2,   1,         1,         1,         0  ),
    (17678339, 0 , 'Ocean_Pugil',              'Ocean Pugil',              3,   1,         1,         1,         0  ),
    (17678340, 0 , 'Pirate_Pugil',             'Pirate Pugil',             4,   1,         1,         1,         0  ),
    (17678341, 0 , 'Sea_Monk',                 'Sea Monk',                 5,   1,         1,         1,         0  ),
    (17678342, 0 , 'Sea_Crab',                 'Sea Crab',                 6,   4.56,      -7.16,     17.43,     227),
    (17678343, 0 , 'Sea_Crab',                 'Sea Crab',                 6,   1.698,     -7.268,    21.497,    139),
    (17678344, 0 , 'Sea_Pugil',                'Sea Pugil',                7,   1.698,     -7.268,    21.497,    139),
    (17678345, 0 , 'Sea_Pugil',                'Sea Pugil',                7,   -7.699,    -7.663,    7.549,     0  ),
    (17678346, 0 , 'Sea_Monk',                 'Sea Monk',                 8,   4.56,      -7.16,     17.43,     0  ),
    (17678347, 0 , 'Phantom',                  'Phantom',                  9,   0,         -7.163,    15.823,    0  ),
    (17678348, 0 , 'Thunder_Elemental',        'Thunder Elemental',        10,  -4.56,     -7.663,    3.749,     0  ),
    (17678349, 0 , 'Water_Elemental',          'Water Elemental',          11,  4.629,     -7.663,    13.749,    0  ),
    (17678350, 0 , 'Sea_Horror',               'Sea Horror',               12,  3.56,      -7.16,     11.43,     100),
    (17678351, 0 , 'Enagakure',                'Enagakure',                13,  1,         -7,        13,        60 );
