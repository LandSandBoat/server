-----------------------------------
--                            Dynamis-San d'Oria
--    Primary Source of Information: https://enedin.be/dyna/html/zone/san.htm
-- Secondary Source of Information: http://www.dynamisbums.com/strategy/san.html
-----------------------------------
local zoneID = xi.zone.DYNAMIS_SAN_DORIA
xi = xi or { }
xi.dynamis = xi.dynamis or { }

-- Main spawn table for all 150 statues
xi.dynamis.spawnTable = xi.dynamis.spawnTable or { }
xi.dynamis.spawnTable[zoneID] =
{
    -- ID = { # to spawn }
    -- O/S = Serjeant Tombstone
    -- O/W = Warchief Tombstone
    [17534977] = { 2 }, -- (1-O/S) | WAR, WAR
    [17534980] = { 1 }, -- (2-O/S) | MNK
    [17534984] = { 1 }, -- (3-O/S) | MNK
    [17534992] = { 1 }, -- (4-O/S) | RDM
    [17534988] = { 1 }, -- (5-O/S) | RDM
    [17534996] = { 3 }, -- (6-O/S) | MNK, MNK, MNK
    [17535000] = { 0 }, -- (7-O/S) |
    [17535001] = { 2 }, -- (8-O/S) | PLD, DRK
    [17535004] = { 2 }, -- (9-O/S) | WAR, WAR
    [17535007] = { 2 }, -- (10-O/S) | RDM, RDM
    [17535010] = { 2 }, -- (11-O/S) | DRG, DRG
    [17535015] = { 2 }, -- (12-O/S) | WHM, WHM
    [17535018] = { 2 }, -- (13-O/S) | THF, THF
    [17535040] = { 2 }, -- (14-O/S) | NIN, NIN
    [17535037] = { 2 }, -- (15-O/S) | SAM, SAM
    [17535036] = { 0 }, -- (16-O/S) |
    [17535030] = { 3 }, -- (17-O/S) | MNK, BLM, BLM
    [17535034] = { 0 }, -- (18-O/S) |
    [17535021] = { 3 }, -- (19-O/S) | BST, BLM, BLM
    [17535035] = { 0 }, -- (20-O/S) |
    [17535026] = { 3 }, -- (21-O/S) | PLD, RNG, RNG
    [17535045] = { 1 }, -- (22-O/S) | THF
    [17535047] = { 2 }, -- (23-O/S) | WHM, BLM
    [17535043] = { 1 }, -- (24-O/S) | THF
    [17535050] = { 2 }, -- (25-O/S) | THF, BRD
    [17535053] = { 2 }, -- (26-O/S) | THF, BRD
    [17535056] = { 2 }, -- (27-O/S) | THF, BRD
    [17535075] = { 0 }, -- (28-O/S) |
    [17535068] = { 2 }, -- (29-O/S) | RNG, RNG
    [17535071] = { 2 }, -- (30-O/S) | WHM, WHM
    [17535074] = { 0 }, -- (31-O/S) |
    [17535063] = { 3 }, -- (32-O/S) | DRK, DRK
    [17535076] = { 0 }, -- (33-O/S) |
    [17535077] = { 0 }, -- (34-O/S) |
    [17535128] = { 0 }, -- (35-O/S) |
    [17535059] = { 3 }, -- (36-O/S) | THF, THF, BRD
    [17535107] = { 2 }, -- (37-O/S) | SAM, SAM
    [17535110] = { 2 }, -- (38-O/S) | BST, BST
    [17535166] = { 2 }, -- (39-O/S) | RNG, RNG
    [17535169] = { 2 }, -- (40-O/S) | NIN, NIN
    [17535151] = { 2 }, -- (41-O/S) | SMN, SMN
    [17535156] = { 2 }, -- (42-O/S) | SMN, SMN
    [17535161] = { 2 }, -- (43-O/S) | SMN, SMN
    [17535115] = { 2 }, -- (44-O/S) | SMN, SMN
    [17535175] = { 2 }, -- (45-O/S) | RNG, RNG
    [17535172] = { 2 }, -- (46-O/S) | NIN, NIN
    [17535120] = { 2 }, -- (47-O/S) | BST, BST
    [17535125] = { 2 }, -- (48-O/S) | SAM, SAM
    [17535097] = { 2 }, -- (49-O/S) | MNK, WAR
    [17535105] = { 1 }, -- (50-O/S) | WHM
    [17535090] = { 3 }, -- (51-O/S) | PLD, WAR, WAR
    [17535100] = { 2 }, -- (52-O/S) | RNG, RNG
    [17535094] = { 2 }, -- (53-O/S) | MNK, WAR
    [17535103] = { 1 }, -- (54-O/S) | WHM
    [17535081] = { 1 }, -- (55-O/S) | WHM
    [17535078] = { 2 }, -- (56-O/S) | THF, THF
    [17535083] = { 1 }, -- (57-O/S) | WHM
    [17535085] = { 2 }, -- (58-O/S) | PLD, PLD
    [17535088] = { 0 }, -- (59-O/S) |
    [17535089] = { 0 }, -- (60-O/S) |
    [17535203] = { 3 }, -- (61-O/S) | MNK, MNK, BRD
    [17535129] = { 0 }, -- (62-O/S) |
    [17535190] = { 2 }, -- (63-O/S) | DRK, DRK
    [17535193] = { 2 }, -- (64-O/S) | DRG, DRG
    [17535198] = { 2 }, -- (65-O/S) | BST, BST
    [17535235] = { 0 }, -- (66-O/S) |
    [17535234] = { 0 }, -- (67-O/S) |
    [17535233] = { 0 }, -- (68-O/S) |
    [17535227] = { 2 }, -- (69-O/S) | RDM, RDM
    [17535222] = { 3 }, -- (70-O/S) | MNK, MNK
    [17535230] = { 2 }, -- (71-O/S) | BLM, BLM
    [17535236] = { 0 }, -- (72-O/S) |
    [17535210] = { 2 }, -- (73-O/S) | SAM, SAM
    [17535219] = { 2 }, -- (74-O/S) | SAM, NIN
    [17535207] = { 2 }, -- (75-O/S) | NIN, NIN
    [17535213] = { 5 }, -- (76-O/S) | WHM, WHM, RNG, RNG, RNG
    [17535237] = { 2 }, -- (77-O/S) | DRK, DRK
    [17535240] = { 2 }, -- (78-O/S) | BLM, BLM
    [17535243] = { 2 }, -- (79-O/S) | WHM, WHM
    [17535246] = { 2 }, -- (80-O/S) | RDM, RDM
    [17535249] = { 2 }, -- (81-O/S) | BST, BST
    [17535259] = { 1 }, -- (82-O/S) | BST
    [17535254] = { 2 }, -- (83-O/S) | BST, BST
    [17535267] = { 0 }, -- (84-O/S) |
    [17535262] = { 2 }, -- (85-O/S) | BST, BST
    [17535268] = { 0 }, -- (86-O/S) |
    [17535269] = { 4 }, -- (87-O/S) | RDM, RDM, BLM, BLM
    [17535274] = { 2 }, -- (88-O/S) | PLD, PLD
    [17535277] = { 3 }, -- (89-O/S) | RNG, RNG, RNG
    [17535289] = { 2 }, -- (90-O/S) | DRK, DRK
    [17535292] = { 3 }, -- (91-O/S) | RDM, WAR, WAR
    [17535296] = { 2 }, -- (92-O/S) | BRD, BRD
    [17535344] = { 1 }, -- (93-O/S) |
    [17535346] = { 2 }, -- (94-O/S) | NIN, NIN
    [17535349] = { 2 }, -- (95-O/S) | NIN, NIN
    [17535336] = { 2 }, -- (96-O/S) | DRG, DRG
    [17535333] = { 2 }, -- (97-O/S) | RNG, RNG
    [17535328] = { 2 }, -- (98-O/S) | DRG, DRG
    [17535316] = { 0 }, -- (99-O/S) |
    [17535317] = { 1 }, -- (100-O/S) | BRD
    [17535319] = { 1 }, -- (101-O/S) | BRD
    [17535299] = { 4 }, -- (102-O/S) | DRG, DRG, WAR, WAR
    [17535321] = { 0 }, -- (103-O/S) |
    [17535341] = { 2 }, -- (104-O/S) | PLD, PLD
    [17535306] = { 4 }, -- (105-O/S) | DRK, DRK, RDM, RDM
    [17535311] = { 4 }, -- (106-O/S) | WAR, WAR, PLD, PLD
    [17535322] = { 2 }, -- (107-O/S) | NIN, NIN
    [17535325] = { 2 }, -- (108-O/S) | SAM, SAM
    [17535130] = { 2 }, -- (109-O/S) | Overlord's Tombstone
    [17535140] = { 3 }, -- (110-O/S) | SMN, SMN, SMN
    [17535133] = { 3 }, -- (111-O/S) | DRG, DRG, DRG
    [17535148] = { 0 }, -- (112-O/S) |
    [17535150] = { 0 }, -- (113-O/S) |
    [17535147] = { 0 }, -- (114-O/S) |
    [17535149] = { 0 }, -- (115-O/S) |
    [17535451] = { 5 }, -- (116-O/S) | DRK, DRK, DRK, BLM, BLM
    [17535457] = { 3 }, -- (117-O/S) | BST, BST, BST
    [17535470] = { 6 }, -- (118-O/S) | SAM, SAM, RDM, RDM, BRD, BRD
    [17535464] = { 5 }, -- (119-O/S) | PLD, PLD, PLD, THF, THF
    [17535477] = { 3 }, -- (120-O/S) | DRG, DRG, DRG
    [17535440] = { 4 }, -- (121-O/S) | WAR, WAR, WHM, WHM
    [17535445] = { 5 }, -- (122-O/S) | MNK, MNK, MNK, WHM, WHM
    [17535420] = { 4 }, -- (123-O/S) | SMN, SMN, BRD, BRD
    [17535415] = { 2 }, -- (124-O/S) | SMN, SMN
    [17535408] = { 3 }, -- (125-O/S) | DRG, DRG, DRG
    [17535403] = { 4 }, -- (126-O/S) | NIN, NIN, NIN, NIN
    [17535399] = { 3 }, -- (127-O/S) | SAM, SAM, SAM
    [17535395] = { 3 }, -- (128-O/S) | RNG, RNG, RNG
    [17535391] = { 3 }, -- (129-O/S) | BRD, BRD, BRD
    [17535427] = { 5 }, -- (130-O/S) | THF, THF, THF, BRD, BRD
    [17535433] = { 6 }, -- (131-O/S) | SAM, SAM, RDM, RDM, BLM, BLM
    [17535372] = { 3 }, -- (132-O/S) | THF, THF, THF
    [17535384] = { 3 }, -- (133-O/S) | BST, BST, BST
    [17535380] = { 3 }, -- (134-O/S) | DRK, DRK, DRK
    [17535376] = { 3 }, -- (135-O/S) | PLD, PLD, PLD
    [17535368] = { 3 }, -- (136-O/S) | RDM, RDM, RDM
    [17535360] = { 3 }, -- (137-O/S) | WHM, WHM, WHM
    [17535356] = { 3 }, -- (138-O/S) | MNK, MNK, MNK
    [17535352] = { 3 }, -- (139-O/S) | WAR, WAR, WAR
    [17535364] = { 3 }, -- (140-O/S) | BLM, BLM, BLM
    [17534986] = { 1 }, -- (141-O/S) | SAM
    [17534982] = { 1 }, -- (142-O/S) | SAM
    [17534994] = { 1 }, -- (143-O/S) | MNK
    [17534990] = { 1 }, -- (144-O/S) | MNK
    [17535285] = { 3 }, -- (145-O/S) | DRK, DRK, DRK
    [17535281] = { 3 }, -- (146-O/S) | PLD, PLD, PLD
    [17535183] = { 2 }, -- (147-O/S) | SMN, SMN
    [17535188] = { 0 }, -- (148-O/S) |
    [17535178] = { 2 }, -- (149-O/S) | SMN, SMN
    [17535189] = { 0 }, -- (150-O/S) |
}

xi.dynamis.eyeColor = xi.dynamis.eyeColor or {}
xi.dynamis.eyeColor[zoneID] =
{
    [17534996] = xi.dynamis.eye.GREEN , -- (6-O/S) | MNK, MNK, MNK
    [17535007] = xi.dynamis.eye.GREEN , -- (10-O/S) | RDM, RDM
    [17535015] = xi.dynamis.eye.BLUE  , -- (12-O/S) | WHM, WHM
    [17535040] = xi.dynamis.eye.GREEN , -- (14-O/S) | NIN, NIN
    [17535037] = xi.dynamis.eye.BLUE  , -- (15-O/S) | SAM, SAM
    [17535063] = xi.dynamis.eye.GREEN , -- (32-O/S) | DRK, DRK
    [17535077] = xi.dynamis.eye.BLUE  , -- (34-O/S) |
    [17535128] = xi.dynamis.eye.GREEN , -- (35-O/S) |
    [17535110] = xi.dynamis.eye.GREEN , -- (38-O/S) | BST, BST
    [17535151] = xi.dynamis.eye.BLUE ,  -- (41-O/S) | SMN, SMN
    [17535115] = xi.dynamis.eye.BLUE  , -- (44-O/S) | SMN, SMN
    [17535120] = xi.dynamis.eye.GREEN , -- (47-O/S) | BST, BST
    [17535100] = xi.dynamis.eye.BLUE  , -- (52-O/S) | RNG, RNG
    [17535088] = xi.dynamis.eye.BLUE  , -- (59-O/S) |
    [17535089] = xi.dynamis.eye.GREEN , -- (60-O/S) |
    [17535129] = xi.dynamis.eye.GREEN , -- (62-O/S) |
    [17535222] = xi.dynamis.eye.GREEN , -- (70-O/S) | MNK, MNK
    [17535236] = xi.dynamis.eye.BLUE  , -- (72-O/S) |
    [17535210] = xi.dynamis.eye.BLUE  , -- (73-O/S) | SAM, SAM
    [17535213] = xi.dynamis.eye.GREEN , -- (76-O/S) | WHM, WHM, RNG, RNG, RNG
    [17535240] = xi.dynamis.eye.BLUE  , -- (78-O/S) | BLM, BLM
    [17535243] = xi.dynamis.eye.GREEN , -- (79-O/S) | WHM, WHM
    [17535249] = xi.dynamis.eye.BLUE  , -- (81-O/S) | BST, BST
    [17535254] = xi.dynamis.eye.BLUE  , -- (83-O/S) | BST, BST
    [17535267] = xi.dynamis.eye.GREEN , -- (84-O/S) |
    [17535262] = xi.dynamis.eye.BLUE  , -- (85-O/S) | BST, BST
    [17535268] = xi.dynamis.eye.GREEN , -- (86-O/S) |
    [17535292] = xi.dynamis.eye.BLUE  , -- (91-O/S) | RDM, WAR, WAR
    [17535296] = xi.dynamis.eye.GREEN , -- (92-O/S) | BRD, BRD
    [17535333] = xi.dynamis.eye.BLUE  , -- (97-O/S) | RNG, RNG
    [17535321] = xi.dynamis.eye.BLUE  , -- (103-O/S) |
    [17535341] = xi.dynamis.eye.BLUE  , -- (104-O/S) | PLD, PLD
    [17535322] = xi.dynamis.eye.BLUE  , -- (107-O/S) | NIN, NIN
    [17535325] = xi.dynamis.eye.GREEN , -- (108-O/S) | SAM, SAM
    [17535140] = xi.dynamis.eye.GREEN , -- (110-O/S) | SMN, SMN, SMN
    [17535133] = xi.dynamis.eye.GREEN , -- (111-O/S) | DRG, DRG, DRG
    [17535150] = xi.dynamis.eye.BLUE  , -- (113-O/S) |
    [17535149] = xi.dynamis.eye.BLUE  , -- (115-O/S) |
}

-- Wave spawn table for large waves
xi.dynamis.wave = xi.dynamis.wave or { }
xi.dynamis.wave[zoneID] =
{
    [1] = -- Spawns at start of the instance
    {
        17534977, -- (001-O/S)  Serjeant Tombstone
        17534980, -- (002-O/S)  Serjeant Tombstone
        17534984, -- (003-O/S)  Serjeant Tombstone
        17534992, -- (004-O/S)  Serjeant Tombstone
        17534988, -- (005-O/S)  Serjeant Tombstone
        17534996, -- (006-O/W)  Warchief Tombstone
        17535000, -- (007-O/S)  Serjeant Tombstone
        17535004, -- (009-O/S)  Serjeant Tombstone
        17535007, -- (010-O/W)  Warchief Tombstone
        17535010, -- (011-O/S)  Serjeant Tombstone
        17535015, -- (012-O/W)  Warchief Tombstone
        17535018, -- (013-O/S)  Serjeant Tombstone
        17535040, -- (014-O/W)  Warchief Tombstone
        17535037, -- (015-O/W)  Warchief Tombstone
        17535036, -- (016-O/S)  Serjeant Tombstone
        17535030, -- (017-O/S)  Serjeant Tombstone
        17535034, -- (018-O/S)  Serjeant Tombstone
        17535035, -- (020-O/S)  Serjeant Tombstone
        17535045, -- (022-O/S)  Serjeant Tombstone
        17535047, -- (023-O/S)  Serjeant Tombstone
        17535043, -- (024-O/S)  Serjeant Tombstone
        17535050, -- (025-O/S)  Serjeant Tombstone
        17535053, -- (026-O/S)  Serjeant Tombstone
        17535056, -- (027-O/S)  Serjeant Tombstone
        17535075, -- (028-O/S)  Serjeant Tombstone
        17535068, -- (029-O/S)  Serjeant Tombstone
        17535071, -- (030-O/S)  Serjeant Tombstone
        17535074, -- (031-O/S)  Serjeant Tombstone
        17535063, -- (032-O/W)  Warchief Tombstone
        17535076, -- (033-O/S)  Serjeant Tombstone
        17535077, -- (034-O/W)  Warchief Tombstone
        17535128, -- (035-O/W)  Warchief Tombstone
        17535107, -- (037-O/S)  Serjeant Tombstone
        17535110, -- (038-O/W)  Warchief Tombstone
        17535166, -- (039-O/S)  Serjeant Tombstone
        17535169, -- (040-O/S)  Serjeant Tombstone
        17535151, -- (041-O/S)  Serjeant Tombstone
        17535156, -- (042-O/S)  Serjeant Tombstone
        17535161, -- (043-O/S)  Serjeant Tombstone
        17535115, -- (044-O/W)  Warchief Tombstone
        17535175, -- (045-O/S)  Serjeant Tombstone
        17535172, -- (046-O/S)  Serjeant Tombstone
        17535120, -- (047-O/W)  Warchief Tombstone
        17535125, -- (048-O/S)  Serjeant Tombstone
        17535097, -- (049-O/S)  Serjeant Tombstone
        17535105, -- (050-O/S)  Serjeant Tombstone
        17535090, -- (051-O/S)  Serjeant Tombstone
        17535100, -- (052-O/W)  Warchief Tombstone
        17535094, -- (053-O/S)  Serjeant Tombstone
        17535103, -- (054-O/S)  Serjeant Tombstone
        17535081, -- (055-O/S)  Serjeant Tombstone
        17535078, -- (056-O/S)  Serjeant Tombstone
        17535083, -- (057-O/S)  Serjeant Tombstone
        17535085, -- (058-O/S)  Serjeant Tombstone
        17535088, -- (059-O/W)  Warchief Tombstone
        17535089, -- (060-O/W)  Warchief Tombstone
        17535129, -- (062-O/W)  Warchief Tombstone
        17535190, -- (063-O/S)  Serjeant Tombstone
        17535193, -- (064-O/S)  Serjeant Tombstone
        17535198, -- (065-O/S)  Serjeant Tombstone
        17535235, -- (066-O/S)  Serjeant Tombstone
        17535234, -- (067-O/S)  Serjeant Tombstone
        17535233, -- (068-O/S)  Serjeant Tombstone
        17535227, -- (069-O/S)  Serjeant Tombstone
        17535222, -- (070-O/W)  Warchief Tombstone
        17535230, -- (071-O/S)  Serjeant Tombstone
        17535236, -- (072-O/W)  Warchief Tombstone
        17535210, -- (073-O/S)  Serjeant Tombstone
        17535219, -- (074-O/W)  Warchief Tombstone
        17535207, -- (075-O/S)  Serjeant Tombstone
        17535213, -- (076-O/W)  Warchief Tombstone
        17535237, -- (077-O/S)  Serjeant Tombstone
        17535240, -- (078-O/W)  Warchief Tombstone
        17535243, -- (079-O/W)  Warchief Tombstone
        17535246, -- (080-O/S)  Serjeant Tombstone
        17535249, -- (081-O/W)  Warchief Tombstone
        17535259, -- (082-O/S)  Serjeant Tombstone
        17535254, -- (083-O/W)  Warchief Tombstone
        17535267, -- (084-O/W)  Warchief Tombstone
        17535262, -- (085-O/W)  Warchief Tombstone
        17535268, -- (086-O/W)  Warchief Tombstone
        17535269, -- (087-O/S)  Serjeant Tombstone
        17535274, -- (088-O/S)  Serjeant Tombstone
        17535277, -- (089-O/S)  Serjeant Tombstone
        17535289, -- (090-O/S)  Serjeant Tombstone
        17535292, -- (091-O/W)  Warchief Tombstone
        17535296, -- (092-O/W)  Warchief Tombstone
        17535344, -- (093-O/S)  Serjeant Tombstone
        17535336, -- (096-O/S)  Serjeant Tombstone
        17535333, -- (097-O/W)  Warchief Tombstone
        17535328, -- (098-O/S)  Serjeant Tombstone
        17535316, -- (099-O/S)  Serjeant Tombstone
        17535299, -- (102-O/S)  Serjeant Tombstone
        17535321, -- (103-O/W)  Warchief Tombstone
        17535341, -- (104-O/W)  Warchief Tombstone
        17535306, -- (105-O/S)  Serjeant Tombstone
        17535311, -- (106-O/S)  Serjeant Tombstone
        17535322, -- (107-O/W)  Warchief Tombstone
        17535325, -- (108-O/W)  Warchief Tombstone
    },
    [2] = -- Wave 2 spawns when Overlord's Tombstone (Mega Boss) is defeated
    {
        17535451, -- (116-O/S)  Serjeant Tombstone
        17535457, -- (117-O/S)  Serjeant Tombstone
        17535470, -- (118-O/S)  Serjeant Tombstone
        17535464, -- (119-O/S)  Serjeant Tombstone
        17535477, -- (120-O/S)  Serjeant Tombstone
        17535440, -- (121-O/S)  Serjeant Tombstone
        17535445, -- (122-O/S)  Serjeant Tombstone
        17535420, -- (123-O/S)  Serjeant Tombstone
        17535415, -- (124-O/S)  Serjeant Tombstone
        17535408, -- (125-O/S)  Serjeant Tombstone
        17535403, -- (126-O/S)  Serjeant Tombstone
        17535399, -- (127-O/S)  Serjeant Tombstone
        17535395, -- (128-O/S)  Serjeant Tombstone
        17535391, -- (129-O/S)  Serjeant Tombstone
        17535427, -- (130-O/S)  Serjeant Tombstone
        17535433, -- (131-O/S)  Serjeant Tombstone
        17535372, -- (132-O/S)  Serjeant Tombstone
        17535384, -- (133-O/S)  Serjeant Tombstone
        17535380, -- (134-O/S)  Serjeant Tombstone
        17535376, -- (135-O/S)  Serjeant Tombstone
        17535368, -- (136-O/S)  Serjeant Tombstone
        17535360, -- (137-O/S)  Serjeant Tombstone
        17535356, -- (138-O/S)  Serjeant Tombstone
        17535352, -- (139-O/S)  Serjeant Tombstone
        17535364, -- (140-O/S)  Serjeant Tombstone
    },
}

xi.sandy = xi.sandy or { }
xi.sandy.mobs =
{
    -- NM
    WYRMGNASHER_BJAKDEK     = 17535064,
    REAPERTONGUE_GADGQUOK   = 17535223,
    VOIDSTREAKER_BUTCHNOTCH = 17535345,
    -- Boss
    OVERLORDS_TOMBSTONE     = 17535130,
    -- Statues
    SERJEANT_TOMBSTONE_7    = 17535000,
    SERJEANT_TOMBSTONE_9    = 17535004,
    SERJEANT_TOMBSTONE_26   = 17535053,
    SERJEANT_TOMBSTONE_41   = 17535151,
    SERJEANT_TOMBSTONE_64   = 17535193,
    SERJEANT_TOMBSTONE_74   = 17535219,
}

-- Vars for death wave actions
xi.dynamis.deathVarByMob = xi.dynamis.deathVarByMob or { }
xi.dynamis.deathVarByMob[zoneID] =
{
    [xi.sandy.mobs.OVERLORDS_TOMBSTONE]     = '[DYNA]MegaBossKilled',
    [xi.sandy.mobs.VOIDSTREAKER_BUTCHNOTCH] = '[DYNA]VoidstreakerKilled',
    [xi.sandy.mobs.REAPERTONGUE_GADGQUOK]   = '[DYNA]ReapertongueKilled',
    [xi.sandy.mobs.WYRMGNASHER_BJAKDEK]     = '[DYNA]WyrmgnasherKilled',
}

xi.dynamis.spawnCheck    = xi.dynamis.spawnCheck or { }
xi.dynamis.spawnCheck[zoneID] =
{
    {
        -- Spawn the 3 statues if WYRMGNASHER_BJAKDEK dies
        -- 32, 143, 144
        requiredVars    = { '[DYNA]WyrmgnasherKilled' },
        spawn           = { 17535203, 17534994, 17534990 },
        spawnedVar      = '[DYNA]WyrmgnasherWaveSpawned',
    },
    {
        -- Spawn the 32 statues if REAPERTONGUE_GADGQUOK dies
        -- 36, 141, 142
        requiredVars    = { '[DYNA]ReapertongueKilled' },
        spawn           = { 17534986, 17534982, 17535059 },
        spawnedVar      = '[DYNA]ReapertongueWaveSpawned',
    },
    {
        -- Spawn the Mega Boss when WYRMGNASHER_BJAKDEK and REAPERTONGUE_GADGQUOK are killed
        requiredVars    = { '[DYNA]ReapertongueKilled', '[DYNA]WyrmgnasherKilled' },
        spawn           = { xi.sandy.mobs.OVERLORDS_TOMBSTONE },
        spawnedVar      = '[DYNA]MegaBossSpawned',
    },
    {
        -- Spawn mobs when the VOIDSTREAKER_BUTCHNOTCH is killed
        requiredVars    = { '[DYNA]VoidstreakerKilled' },
        spawn           = { 17535285, 17535281, 17535183, 17535178 },
        spawnedVar      = '[DYNA]VoidstreakerWaveSpawned',
    },
    {
        -- Spawn mobs when the Mega Boss is killed
        requiredVars    = { '[DYNA]MegaBossKilled' },
        spawn           = xi.dynamis.wave[zoneID][2],
        spawnedVar      = '[DYNA]BossWaveSpawned',
    },
}

--Specific Statues
xi.dynamis.aggro = xi.dynamis.aggro or { }
xi.dynamis.aggro[zoneID] =
{
    nonAggressive =
    {
        [17535000] = { 17535001 }, -- (007-O/S) spawns (8-O/S)
        [17535034] = { 17535021 }, -- (018-O/S) spawns (19-O/S)
        [17535035] = { 17535026 }, -- (020-O/S) spawns (21-O/S)
        [xi.sandy.mobs.OVERLORDS_TOMBSTONE] = { 17535147, 17535148 } -- Boss spawns 2 statues that do not aggro
    },
    aggressive =
    {
        [17535183] = { 17535188 },           -- (147-O/S) spawns (148-O/S) West Tent spawns one middle statue
        [17535178] = { 17535189 },           -- (149-O/S) spawns (150-O/S)East Tent spawns one middle statue
        [17535316] = { 17535317, 17535319 }, -- (099-O/S) spawns (100-O/S) and (101-O/S) Manor courtyard +2 stats
        [17535344] = { 17535346, 17535349 }, -- (093-O/S) spawns (94-O/S) and (95-O/S)
        [17535147] = { 17535149 },           -- (114-O/S) spawns (115-O/S) Boss spawns one middle statue
        [17535148] = { 17535150 },           -- (112-O/S) spawns (113-O/S) Boss spawns one middle statue
        [xi.sandy.mobs.OVERLORDS_TOMBSTONE] = { 17535140, 17535133 }, -- Boss spawns 2 statues on aggro
    },
}

xi.dynamis.lineSpawns = xi.dynamis.lineSpawns or { }
xi.dynamis.lineSpawns[zoneID] =
{
    -- Statue ID = { behind = { first mob distance, second mob distance } }, { side = { left distance, right distance } }, or { { xOffset, yOffset, zOffset }, ... }
    -- Mobs with DB spawn position 1.000, 1.000, 1.000 default to spawning on top of the statue.
    -- lineSpawns below is only for explicit positioning exceptions.
    [17535151] = { behind = { 4, 8 } }, -- (041-O/S) Mobs spawn in a line behind the statue
    [17535156] = { behind = { 4, 8 } }, -- (042-O/S) Mobs spawn in a line behind the statue
    [17535161] = { behind = { 4, 8 } }, -- (043-O/S) Mobs spawn in a line behind the statue
    [17535166] = { behind = { 4, 8 } }, -- (039-O/S) Mobs spawn in a line behind the statue
    [17535169] = { behind = { 4, 8 } }, -- (040-O/S) Mobs spawn in a line behind the statue
    [17535172] = { behind = { 4, 8 } }, -- (046-O/S) Mobs spawn in a line behind the statue
    [17535175] = { behind = { 4, 8 } }, -- (045-O/S) Mobs spawn in a line behind the statue
    [17535237] = { side = { -2, 2 } }, -- (77-O/S) Mobs spawn to the left and right of the statue
    [17535240] = { side = { -2, 2 } }, -- (78-O/S) Mobs spawn to the left and right of the statue
    [17535243] = { side = { -2, 2 } }, -- (79-O/S) Mobs spawn to the left and right of the statue
}

-- Pathing table
xi.dynamis.paths = xi.dynamis.paths or { }
xi.dynamis.paths[zoneID] =
{
    [17534980] = { {  121,    0,  96 }, {  127,    0, 102 } },
    [17534984] = { {  128,    0,  89 }, {  134,    0,  95 } },
    [17535018] = { {   98,    4,  16 }, {   98,    4,  56 } },
    [17535040] = { {  104,    4,  14 }, {  116,    2,  14 } },
    [17535037] = { {  118,    2,  14 }, {  133,    0,  14 } },
    [17535036] = { {  146,    0,  30 }, {  135,    0,  18 } },
    [17535030] = { {  148,    0,  49 }, {  148,    0,  33 } },
    [17535034] = { {  130,    0,  68 }, {  152,    0,  45 } },
    [17535047] = { {   93,    4,  14 }, {   81,    2,   2 } },
    [17535050] = { {   76,    2,  -4 }, {   88,    2, -16 } },
    [17535053] = { {   68,    2, -12 }, {   80,    2, -24 } },
    [17535056] = { {   60,    2, -20 }, {   72,    2, -32 } },
    [17535075] = { {   91,    2, -19 }, {   98,    2, -26 } },
    [17535068] = { {   89,    2, -33 }, {   83,    2, -27 } },
    [17535071] = { {   75,    2, -35 }, {   81,    2, -41 } },
    [17535107] = { {   40,    2, -17 }, {   40,    2, -37 } },
    [17535110] = { {   34,    2, -18 }, {   14,    2, -18 } },
    [17535166] = { {   20,    2,   5 }, {   20,    2, -13 } },
    [17535169] = { {   20,    0,  24 }, {   20,    2,   8 } },
    [17535151] = { {    0,    0,  25 }, {    0,    1,   5 } },
    [17535156] = { {    5,    0,  10 }, {    5,    2, -10 } }, -- Victory Square Main Path E
    [17535161] = { {   -5,    0,  10 }, {   -5,    2, -10 } }, -- Victory Square Main Path W
    [17535115] = { {    0,    2, -21 }, {    0,    2,  -4 } },
    [17535175] = { {  -24,    2,  15 }, {  -24,    2,   0 } },
    [17535172] = { {  -20,    2,   5 }, {  -20,    2, -13 } },
    [17535120] = { {  -34,    2, -18 }, {  -14,    2, -18 } },
    [17535125] = { {  -40,    2, -17 }, {  -40,    2, -38 } },
    [17535081] = { {    2,    2, -74 }, {  -12,    2, -74 } },
    [17535078] = { {   -8,    2, -80 }, {  -23,    2, -80 } },
    [17535083] = { {    5,    2, -74 }, {   18,    2, -74 } },
    [17535190] = { {  -72,    2, -32 }, {  -60,    2, -20 } },
    [17535193] = { {  -80,    2, -24 }, {  -68,    2, -12 } },
    [17535198] = { {  -88,    2, -16 }, {  -76,    2,  -4 } },
    [17535235] = { {  -75,    2, -35 }, {  -83,    2, -43 } },
    [17535234] = { {  -83,    2, -27 }, {  -91,    2, -35 } },
    [17535233] = { {  -91,    2, -19 }, {  -99,    2, -27 } },
    [17535219] = { {  -96,   -2,  16 }, {  -84,    2,   4 } },
    [17535237] = { { -100,   -2,  18 }, { -124,   -2,  18 } },
    [17535240] = { { -125,   -2,  18 }, { -136,   -2,  18 } },
    [17535243] = { { -140,   -2,  18 }, { -163,   -1,  18 } },
    [17535274] = { { -194,   -2,  61 }, { -194,   -2,  78 } },
    [17535289] = { { -194,   -2,  80 }, { -212,   -2,  98 } },
    [17535292] = { { -231,   -2,  98 }, { -213,   -2,  98 } },
    [17535296] = { { -240,   -4,  98 }, { -260,   -4,  98 } },
    [17535336] = { { -169,   -2,  60 }, { -156,   -2,  60 } },
    [17535328] = { { -144,   -2,  60 }, { -154,   -2,  60 } },
    [17535316] = { { -132,   -4,  72 }, { -132,   -4,  63 } },
    [17535321] = { { -106,   -6,  88 }, { -128,   -6,  88 } },
    [17535306] = { {  -94,   -6,  74 }, { -104,   -6,  84 } },
    [17535311] = { {  -90,   -6,  57 }, {  -93,   -6,  71 } },
    [17535322] = { {  -90,   -4,  46 }, {  -90,   -4,  56 } },
    [17535325] = { { -101,   -2,  34 }, {  -91,    4,  44 } },
    [17534986] = { {  132,   -1, 103 }, {  128,   -1, 107 } },
    [17534982] = { {  135,   -1, 100 }, {  139,   -1,  96 } },
    [17534994] = { {  110,    0,  80 }, {  104,    0,  87 } },
    [17534990] = { {  118,    0,  71 }, {  112,    0,  78 } },
    [17535285] = { { -212,   -2,  96 }, { -229,   -2,  98 } },
    [17535281] = { { -200,   -2,  87 }, { -193,   -2,  69 } },
    [17535259] = { { -185, -1.5,  42 }, { -170,   -1,  28 } },
}

xi.dynamis.timeExtension = xi.dynamis.timeExtension or { }
xi.dynamis.timeExtension[zoneID] =
{
    [xi.sandy.mobs.SERJEANT_TOMBSTONE_7]    = 15, -- (007-O/S)
    [xi.sandy.mobs.SERJEANT_TOMBSTONE_9]    = 15, -- (009-O/S)
    [xi.sandy.mobs.SERJEANT_TOMBSTONE_26]   = 25, -- (026-O/S)
    [xi.sandy.mobs.SERJEANT_TOMBSTONE_41]   = 30, -- (041-O/S)
    [xi.sandy.mobs.SERJEANT_TOMBSTONE_64]   = 25, -- (064-O/S)
    [xi.sandy.mobs.SERJEANT_TOMBSTONE_74]   = 10, -- (074-O/S)
    [xi.sandy.mobs.VOIDSTREAKER_BUTCHNOTCH] = 10,
}
