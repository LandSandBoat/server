-----------------------------------
--                            Dynamis-Windurst
--    Primary Source of Information: https://enedin.be/dyna/html/zone/win.htm
-----------------------------------
local zoneID = xi.zone.DYNAMIS_WINDURST
xi = xi or { }
xi.dynamis = xi.dynamis or { }

-- Main spawn table for all 150 statues
xi.dynamis.spawnTable = xi.dynamis.spawnTable or { }
xi.dynamis.spawnTable[zoneID] =
{
    -- ID = { # to spawn }
    -- MP = green HP = blue
    -- Y/A = Serjeant Tombstone
    [17543169] = { 2 }, -- (1-Y/A) | PLD, DRK
    [17543172] = { 2 }, -- (2-Y/A) | WHM, BLM
    [17543175] = { 2 }, -- (3-Y/A) | RDM, BRD
    [17543182] = { 1 }, -- (4-Y/A) | RNG
    [17543181] = { 0 }, -- (5-Y/A) |
    [17543178] = { 2 }, -- (6-Y/M) | SAM, NIN
    [17543184] = { 2 }, -- (7-Y/A) | MNK, MNK
    [17543187] = { 3 }, -- (8-Y/M) | DRG, DRG, WAR
    [17543193] = { 4 }, -- (9-Y/A) | NIN, NIN, THF, THF
    [17543198] = { 0 }, -- (10-Y/A) |
    [17543199] = { 4 }, -- (11-Y/A) | WAR, WAR, BST, BST
    [17543206] = { 2 }, -- (12-Y/M) | PLD, PLD
    [17543215] = { 2 }, -- (13-Y/A) | WHM, WHM
    [17543212] = { 2 }, -- (14-Y/A) | DRK, SAM
    [17543209] = { 2 }, -- (15-Y/A) | DRK, SAM
    [17543218] = { 3 }, -- (16-Y/A) | BLM, SMN, SMN
    [17543224] = { 2 }, -- (17-Y/M) | RDM, THF
    [17543227] = { 2 }, -- (18-Y/A) | WAR, SAM
    [17543230] = { 2 }, -- (19-Y/M) | NIN, NIN
    [17543233] = { 3 }, -- (20-Y/A) | BRD, MNK, THF
    [17543256] = { 2 }, -- (21-Y/A) | PLD, WHM
    [17543259] = { 1 }, -- (22-Y/A) | DRK
    [17543261] = { 1 }, -- (23-Y/A) | BLM
    [17543263] = { 3 }, -- (24-Y/M) | THF, THF, RNG
    [17543237] = { 3 }, -- (25-Y/A) | BST, DRG, DRG
    [17543244] = { 2 }, -- (26-Y/A) | BLM, BLM
    [17543247] = { 4 }, -- (27-Y/A) | RNG, RNG, WAR, WAR
    [17543252] = { 3 }, -- (28-Y/A) | DRK, BRD, RNG
    [17543267] = { 4 }, -- (29-Y/M) | WAR, MNK, THF, SAM
    [17543272] = { 4 }, -- (30-Y/M) | RDM, PLD, DRK, NIN
    [17543277] = { 3 }, -- (31-Y/A) | THF, THF, SMN
    [17543287] = { 3 }, -- (32-Y/A) | DRG, DRG, DRG
    [17543282] = { 3 }, -- (33-Y/M) | RDM, RDM, BST
    [17543294] = { 2 }, -- (34-Y/A) | BST, BST
    [17543299] = { 0 }, -- (35-Y/M) |
    [17543300] = { 1 }, -- (36-Y/A) | WHM
    [17543302] = { 1 }, -- (37-Y/A) | BLM
    [17543304] = { 1 }, -- (38-Y/A) | BRD
    [17543306] = { 1 }, -- (39-Y/A) | THF
    [17543308] = { 0 }, -- (40-Y/M) |
    [17543320] = { 3 }, -- (41-Y/A) | WAR, WHM, SAM
    [17543324] = { 2 }, -- (42-Y/M) | NIN, NIN
    [17543309] = { 2 }, -- (43-Y/A) | WHM, SMN
    [17543313] = { 1 }, -- (44-Y/A) | BLM
    [17543315] = { 4 }, -- (45-Y/M) | PLD, PLD, MNK, MNK
    [17543337] = { 1 }, -- (46-Y/A) | Wuu Qoho the Razorclaw
    [17543334] = { 2 }, -- (47-Y/A) | SAM, WAR
    [17543327] = { 2 }, -- (48-Y/A) | WAR, DRG
    [17543331] = { 0 }, -- (49-Y/A) |
    [17543332] = { 0 }, -- (50-Y/A) |
    [17543339] = { 0 }, -- (51-Y/M) |
    [17543333] = { 0 }, -- (52-Y/A) |
    [17543340] = { 3 }, -- (53-Y/A) | THF, RDM, RDM
    [17543347] = { 2 }, -- (54-Y/A) | WHM, BRD
    [17543344] = { 2 }, -- (55-Y/A) | DRK, DRK
    [17543350] = { 4 }, -- (56-Y/M) | BLM, BLM, PLD, NIN
    [17543355] = { 1 }, -- (57-Y/M) | SMN
    [17543515] = { 0 }, -- (58-Y/A) |
    [17543521] = { 0 }, -- (59-Y/A) |
    [17543522] = { 1 }, -- (60-Y/M) | BST
    [17543525] = { 0 }, -- (61-Y/A) |
    [17543516] = { 0 }, -- (62-Y/A) |
    [17543517] = { 1 }, -- (63-Y/A) | DRG
    [17543520] = { 0 }, -- (64-Y/A) |
    [17543464] = { 5 }, -- (65-Y/A) | WAR, MNK, WHM, BLM, THF
    [17543445] = { 3 }, -- (66-Y/A) | BRD, DRK, SMN
    [17543450] = { 1 }, -- (67-Y/A) | WHM
    [17543452] = { 1 }, -- (68-Y/A) | WHM
    [17543425] = { 2 }, -- (69-Y/A) | WAR, WAR
    [17543428] = { 0 }, -- (70-Y/A) |
    [17543429] = { 0 }, -- (71-Y/A) |
    [17543430] = { 3 }, -- (72-Y/M) | WAR, MNK, BST
    [17543435] = { 1 }, -- (73-Y/A) | NIN
    [17543437] = { 3 }, -- (74-Y/M) | THF, SAM, DRG
    [17543442] = { 1 }, -- (75-Y/A) | RNG
    [17543444] = { 0 }, -- (76-Y/A) |
    [17543460] = { 3 }, -- (77-Y/M) | RDM, RDM, BRD
    [17543454] = { 2 }, -- (78-Y/A) | PLD, BLM
    [17543457] = { 2 }, -- (79-Y/A) | DRK, WHM
    [17543479] = { 3 }, -- (80-Y/M) | THF, PLD, BRD
    [17543483] = { 1 }, -- (81-Y/A) | RDM
    [17543485] = { 1 }, -- (82-Y/A) | BLM
    [17543487] = { 1 }, -- (83-Y/M) | SMN
    [17543416] = { 2 }, -- (84-Y/A) | BLM, BLM
    [17543419] = { 2 }, -- (85-Y/A) | DRK, DRK
    [17543423] = { 1 }, -- (86-Y/M) | PLD
    [17543412] = { 3 }, -- (87-Y/A) | WHM, RDM, Xoo Kaza the Solemn
    [17543422] = { 0 }, -- (88-Y/M) |
    [17543409] = { 0 }, -- (89-Y/A) |
    [17543410] = { 1 }, -- (90-Y/A) | RDM
    [17543406] = { 0 }, -- (91-Y/A) |
    [17543407] = { 1 }, -- (92-Y/A) | RDM
    [17543366] = { 3 }, -- (93-Y/A) | SMN, SMN, Haa Pevi the Stentorian
    [17543373] = { 3 }, -- (94-Y/M) | SMN, WHM, SMN
    [17543379] = { 2 }, -- (95-Y/M) | SMN, SMN
    [17543384] = { 0 }, -- (96-Y/M) |
    [17543385] = { 1 }, -- (97-Y/A) | RDM
    [17543387] = { 1 }, -- (98-Y/A) | DRK
    [17543389] = { 1 }, -- (99-Y/A) | BST
    [17543392] = { 2 }, -- (100-Y/M) | PLD, BRD
    [17543402] = { 3 }, -- (101-Y/A) | RNG, RNG, MNK
    [17543399] = { 2 }, -- (102-Y/A) | WAR, NIN
    [17543395] = { 2 }, -- (103-Y/A) | DRG, NIN
    [17543362] = { 1 }, -- (104-Y/A) | BLM
    [17543360] = { 1 }, -- (105-Y/A) | RNG
    [17543358] = { 1 }, -- (106-Y/A) | RNG
    [17543364] = { 1 }, -- (107-Y/A) | BLM
    [17543491] = { 1 }, -- (108-Y/A) | WAR
    [17543490] = { 0 }, -- (109-Y/A) |
    [17543493] = { 0 }, -- (110-Y/M) |
    [17543494] = { 1 }, -- (111-Y/M) | WAR
    [17543497] = { 1 }, -- (112-Y/A) | WAR
    [17543496] = { 0 }, -- (113-Y/A) |
    [17543509] = { 2 }, -- (114-Y/A) | THF, THF
    [17543512] = { 2 }, -- (115-Y/A) | NIN, NIN
    [17543505] = { 3 }, -- (116-Y/A) | BRD, DRK, Loo Hepe the Eyepiercer
    [17543499] = { 2 }, -- (117-Y/M) | RDM, BLM
    [17543502] = { 2 }, -- (118-Y/M) | RDM, BLM
    [17543474] = { 3 }, -- (119-Y/A) | SAM, BST, RNG
    [17543470] = { 3 }, -- (120-Y/A) | MNK, NIN, BLM
    [17543526] = { 4 }, -- (121-Y/A) | RNG, RNG, Maa Febi the Steadfast, Muu Febi the Steadfast
    [17543535] = { 3 }, -- (122-Y/A) | BLM, SAM, BST
    [17543531] = { 3 }, -- (123-Y/A) | BLM, MNK, WAR
    [17543540] = { 0 }, -- (124-Y/A) |
    [17543541] = { 0 }, -- (125-Y/A) |
    [17543578] = { 3 }, -- (126-Y/M) | PLD, DRK, NIN
    [17543582] = { 4 }, -- (127-Y/M) | BST, RNG, RDM, THF
    [17543588] = { 2 }, -- (128-Y/A) | SMN, MNK
    [17543592] = { 2 }, -- (129-Y/A) | NIN, MNK
    [17543564] = { 3 }, -- (130-Y/A) | SAM, MNK, BST
    [17543569] = { 3 }, -- (131-Y/M) | WHM, BRD, RNG
    [17543573] = { 3 }, -- (132-Y/A) | BLM, RDM, SMN
    [17543557] = { 5 }, -- (133-Y/M) | RDM, DRK, DRG, RNG, BLM
    [17543545] = { 3 }, -- (134-Y/A) | MNK, DRK, BRD
    [17543553] = { 2 }, -- (135-Y/A) | PLD, DRG
    [17543542] = { 2 }, -- (136-Y/M) | WHM, THF
    [17543549] = { 3 }, -- (137-Y/M) | NIN, RDM, WAR
    [17543595] = { 3 }, -- (138-Y/M) | SAM, WAR, BLM
    [17543599] = { 3 }, -- (139-Y/M) | DRG, THF, RNG
    [17543604] = { 4 }, -- (140-Y/A) | WAR, BRD, THF, NIN
    [17543609] = { 4 }, -- (141-Y/A) | SAM, WHM, PLD, NIN
    [17543614] = { 5 }, -- (142-Y/A) | BLM, RDM, DRG, BST, DRK
    [17543622] = { 5 }, -- (143-Y/A) | MNK, BST, NIN, WHM, BRD
    [17543646] = { 5 }, -- (144-Y/A) | WAR, THF, SAM, RNG, SMN
    [17543641] = { 4 }, -- (145-Y/A) | MNK, PLD, DRK, BRD
    [17543635] = { 3 }, -- (146-Y/A) | WHM, SMN, BST
    [17543629] = { 4 }, -- (147-Y/A) | WAR, BLM, SAM, DRG
    [17543653] = { 5 }, -- (148-Y/A) | PLD, DRK, BRD, RDM, NIN
    [17543665] = { 5 }, -- (149-Y/A) | THF, SAM, SMN, BST, DRG
    [17543659] = { 5 }, -- (150-Y/A) | MNK, PLD, WAR, BLM, RNG
}

xi.dynamis.eyeColor = xi.dynamis.eyeColor or {}
xi.dynamis.eyeColor[zoneID] =
{
    [17543178] = xi.dynamis.eye.BLUE , -- (6-Y/M) | SAM, NIN
    [17543187] = xi.dynamis.eye.GREEN, -- (8-Y/M) | DRG, DRG, WAR
    [17543206] = xi.dynamis.eye.BLUE , -- (12-Y/M) | PLD, PLD
    [17543224] = xi.dynamis.eye.GREEN, -- (17-Y/M) | RDM, THF
    [17543230] = xi.dynamis.eye.BLUE , -- (19-Y/M) | NIN, NIN
    [17543263] = xi.dynamis.eye.BLUE , -- (24-Y/M) | THF, THF, RNG
    [17543237] = xi.dynamis.eye.GREEN, -- (25-Y/A) | BST, DRG, DRG
    [17543267] = xi.dynamis.eye.BLUE , -- (29-Y/M) | WAR, MNK, THF, SAM
    [17543272] = xi.dynamis.eye.GREEN, -- (30-Y/M) | RDM, PLD, DRK, NIN
    [17543282] = xi.dynamis.eye.GREEN, -- (33-Y/M) | RDM, RDM, BST
    [17543299] = xi.dynamis.eye.BLUE , -- (35-Y/M) |
    [17543308] = xi.dynamis.eye.GREEN, -- (40-Y/M) |
    [17543324] = xi.dynamis.eye.BLUE , -- (42-Y/M) | NIN, NIN
    [17543315] = xi.dynamis.eye.GREEN, -- (45-Y/M) | PLD, PLD, MNK, MNK
    [17543339] = xi.dynamis.eye.BLUE , -- (51-Y/M) |
    [17543350] = xi.dynamis.eye.BLUE , -- (56-Y/M) | BLM, BLM, PLD, NIN
    [17543355] = xi.dynamis.eye.GREEN, -- (57-Y/M) | SMN
    [17543522] = xi.dynamis.eye.GREEN, -- (60-Y/M) | BST
    [17543430] = xi.dynamis.eye.GREEN, -- (72-Y/M) | WAR, MNK, BST
    [17543437] = xi.dynamis.eye.BLUE , -- (74-Y/M) | THF, SAM, DRG
    [17543460] = xi.dynamis.eye.GREEN, -- (77-Y/M) | RDM, RDM, BRD
    [17543479] = xi.dynamis.eye.GREEN, -- (80-Y/M) | THF, PLD, BRD
    [17543487] = xi.dynamis.eye.BLUE , -- (83-Y/M) | SMN
    [17543423] = xi.dynamis.eye.GREEN, -- (86-Y/M) | PLD
    [17543422] = xi.dynamis.eye.BLUE , -- (88-Y/M) |
    [17543373] = xi.dynamis.eye.BLUE , -- (94-Y/M) | SMN, WHM, SMN
    [17543379] = xi.dynamis.eye.BLUE , -- (95-Y/M) | SMN, SMN
    [17543384] = xi.dynamis.eye.GREEN, -- (96-Y/M) |
    [17543392] = xi.dynamis.eye.BLUE , -- (100-Y/M) | PLD, BRD
    [17543493] = xi.dynamis.eye.BLUE , -- (110-Y/M) |
    [17543494] = xi.dynamis.eye.GREEN, -- (111-Y/M) | WAR
    [17543499] = xi.dynamis.eye.BLUE , -- (117-Y/M) | RDM, BLM
    [17543502] = xi.dynamis.eye.GREEN, -- (118-Y/M) | RDM, BLM
    [17543578] = xi.dynamis.eye.BLUE , -- (126-Y/M) | PLD, DRK, NIN
    [17543582] = xi.dynamis.eye.GREEN, -- (127-Y/M) | BST, RNG, RDM, THF
    [17543569] = xi.dynamis.eye.GREEN, -- (131-Y/M) | WHM, BRD, RNG
    [17543557] = xi.dynamis.eye.BLUE , -- (133-Y/M) | RDM, DRK, DRG, RNG, BLM
    [17543542] = xi.dynamis.eye.BLUE , -- (136-Y/M) | WHM, THF
    [17543549] = xi.dynamis.eye.GREEN, -- (137-Y/M) | NIN, RDM, WAR
    [17543595] = xi.dynamis.eye.BLUE , -- (138-Y/M) | SAM, WAR, BLM
    [17543599] = xi.dynamis.eye.GREEN, -- (139-Y/M) | DRG, THF, RNG
}

-- Wave spawn table for large waves
xi.dynamis.wave = xi.dynamis.wave or { }
xi.dynamis.wave[zoneID] =
{
    [1] = -- Spawns at start of the instance
    {
        17543169, -- (001-Y/A)  Avatar Icon
        17543172, -- (002-Y/A)  Avatar Icon
        17543175, -- (003-Y/A)  Avatar Icon
        17543182, -- (004-Y/A)  Avatar Icon
        17543181, -- (005-Y/A)  Avatar Icon
        17543178, -- (006-Y/M)  Manifest Icon
        17543184, -- (007-Y/A)  Avatar Icon
        17543187, -- (008-Y/M)  Manifest Icon
        17543193, -- (009-Y/A)  Avatar Icon
        17543198, -- (010-Y/A)  Avatar Icon
        17543199, -- (011-Y/A)  Avatar Icon
        17543206, -- (012-Y/M)  Manifest Icon
        17543215, -- (013-Y/A)  Avatar Icon
        17543212, -- (014-Y/A)  Avatar Icon
        17543209, -- (015-Y/A)  Avatar Icon
        17543218, -- (016-Y/A)  Avatar Icon
        17543224, -- (017-Y/M)  Manifest Icon
        17543227, -- (018-Y/A)  Avatar Icon
        17543230, -- (019-Y/M)  Manifest Icon
        17543233, -- (020-Y/A)  Avatar Icon
        17543256, -- (021-Y/A)  Avatar Icon
        17543263, -- (024-Y/M)  Manifest Icon
        17543244, -- (026-Y/A)  Avatar Icon
        17543247, -- (027-Y/A)  Avatar Icon
        17543252, -- (028-Y/A)  Avatar Icon
        17543267, -- (029-Y/M)  Manifest Icon
        17543272, -- (030-Y/M)  Manifest Icon
        17543277, -- (031-Y/A)  Avatar Icon
        17543287, -- (032-Y/A)  Avatar Icon
        17543294, -- (034-Y/A)  Avatar Icon
        17543299, -- (035-Y/M)  Manifest Icon
        17543320, -- (041-Y/A)  Avatar Icon
        17543309, -- (043-Y/A)  Avatar Icon
        17543313, -- (044-Y/A)  Avatar Icon
        17543315, -- (045-Y/M)  Manifest Icon
        17543337, -- (046-Y/A)  Avatar Idol
        17543339, -- (051-Y/M)  Manifest Icon
        17543333, -- (052-Y/A)  Avatar Icon
        17543340, -- (053-Y/A)  Avatar Icon
        17543350, -- (056-Y/M)  Manifest Icon
        17543355, -- (057-Y/M)  Manifest Icon
        17543515, -- (058-Y/A)  Avatar Icon
        17543516, -- (062-Y/A)  Avatar Icon
        17543517, -- (063-Y/A)  Avatar Icon
        17543520, -- (064-Y/A)  Avatar Icon
        17543464, -- (065-Y/A)  Avatar Icon
        17543445, -- (066-Y/M)  Avatar Icon
        17543425, -- (069-Y/A)  Avatar Icon
        17543430, -- (072-Y/M)  Manifest Icon
        17543437, -- (074-Y/M)  Manifest Icon
        17543460, -- (077-Y/M)  Manifest Icon
        17543479, -- (080-Y/M)  Manifest Icon
        17543416, -- (084-Y/A)  Avatar Idol
        17543412, -- (087-Y/A)  Avatar Icon | https://youtu.be/j0En3a5KKIc?t=485
        17543422, -- (088-Y/M)  Manifest Icon
        17543409, -- (089-Y/A)  Avatar Icon
        17543406, -- (091-Y/A)  Avatar Icon
        17543366, -- (093-Y/A)  Avatar Idol
        17543373, -- (094-Y/M)  Manifest Icon
        17543379, -- (095-Y/M)  Manifest Icon
        17543384, -- (096-Y/M)  Manifest Icon
        17543385, -- (097-Y/A)  Avatar Icon
        17543402, -- (101-Y/M)  Avatar Icon
        17543362, -- (104-Y/A)  Avatar Icon
        17543360, -- (105-Y/A)  Avatar Icon
        17543358, -- (106-Y/A)  Avatar Icon
        17543364, -- (107-Y/A)  Avatar Icon
    },
    [2] = -- Spawns statues when boss dies
    {
        17543578, -- (126-Y/M)  Manifest Icon
        17543582, -- (127-Y/M)  Manifest Icon
        17543588, -- (128-Y/A)  Avatar Icon
        17543592, -- (129-Y/A)  Avatar Icon
        17543564, -- (130-Y/A)  Avatar Icon
        17543569, -- (131-Y/M)  Manifest Icon
        17543573, -- (132-Y/A)  Avatar Icon
        17543557, -- (133-Y/M)  Manifest Icon
        17543545, -- (134-Y/A)  Avatar Icon
        17543553, -- (135-Y/A)  Avatar Icon
        17543542, -- (136-Y/M)  Manifest Icon
        17543549, -- (137-Y/M)  Manifest Icon
        17543595, -- (138-Y/M)  Manifest Icon
        17543599, -- (139-Y/M)  Manifest Icon
        17543604, -- (140-Y/M)  Avatar Icon
        17543609, -- (141-Y/M)  Avatar Icon
        17543614, -- (142-Y/M)  Avatar Icon
        17543622, -- (143-Y/M)  Avatar Icon
        17543646, -- (144-Y/M)  Avatar Icon
        17543641, -- (145-Y/M)  Avatar Icon
        17543635, -- (146-Y/A)  Avatar Icon
        17543629, -- (147-Y/M)  Avatar Icon
        17543653, -- (148-Y/A)  Avatar Icon
        17543665, -- (149-Y/M)  Avatar Icon
        17543659, -- (150-Y/M)  Avatar Icon
    },
}

xi.windurst = xi.windurst or { }
xi.windurst.mobs =
{
    -- Statues
    MANIFEST_ICON_8 = 17543187,
    AVATAR_ICON_18 = 17543227,
    AVATAR_ICON_31 = 17543277,
    AVATAR_ICON_41 = 17543320,
    AVATAR_ICON_58 = 17543515,
    MANIFEST_ICON_66 = 17543445,
    MANIFEST_ICON_101 = 17543402,
    -- Boss
    TZEE_XICU_IDOL = 17543526,
    --NMs
    WUU_QOHO_THE_RAZORCLAW = 17543338,
    LOO_HEPE_THE_EYEPIERCER = 17543506,
    XOO_KAZA_THE_SOLEMN = 17543413,
    HAA_PEVI_THE_STENTORIAN = 17543367,
}

-- Vars for death wave actions
xi.dynamis.deathVarByMob = xi.dynamis.deathVarByMob or {}
xi.dynamis.deathVarByMob[zoneID] =
{
    [xi.windurst.mobs.TZEE_XICU_IDOL]           = '[DYNA]MegaBossKilled',
    [xi.windurst.mobs.WUU_QOHO_THE_RAZORCLAW]   = '[DYNA]WuuKilled',
    [xi.windurst.mobs.LOO_HEPE_THE_EYEPIERCER]  = '[DYNA]LooKilled',
    [xi.windurst.mobs.XOO_KAZA_THE_SOLEMN]      = '[DYNA]XooKilled',
    [xi.windurst.mobs.HAA_PEVI_THE_STENTORIAN]  = '[DYNA]HaaKilled',
    [xi.windurst.mobs.MANIFEST_ICON_101]        = '[DYNA]101Killed',
}

xi.dynamis.spawnCheck = xi.dynamis.spawnCheck or {}
xi.dynamis.spawnCheck[zoneID] =
{
    {
        -- Spawn the Mega Boss if all 3 NMs died
        requiredVars    = { '[DYNA]LooKilled' },
        spawn           = { xi.windurst.mobs.TZEE_XICU_IDOL },
        spawnedVar      = '[DYNA]MegaBossSpawned',
    },
    {
        -- Spawn mobs when the Mega Boss is killed
        requiredVars    = { '[DYNA]MegaBossKilled' },
        spawn           = xi.dynamis.wave[zoneID][2],
        spawnedVar      = '[DYNA]Wave2Spawned',
    },
    {
        -- Wuu Qoho the Razorclaw spawns 2 Statues at Heavens Tower
        requiredVars    = { '[DYNA]WuuKilled' },
        spawn           = { 17543490, 17543491 },
        spawnedVar      = '[DYNA]Wave3Spawned',
    },
    {
        -- Xoo Kaza the Solemn NM spawns 2 Statues at Heavens Tower
        requiredVars    = { '[DYNA]XooKilled' },
        spawn           = { 17543493, 17543494 },
        spawnedVar      = '[DYNA]Wave4Spawned',
    },
    {
        -- Haa Pevi the Stentorian NM spawns 2 Statues at Heavens Tower
        requiredVars    = { '[DYNA]HaaKilled' },
        spawn           = { 17543496, 17543497 },
        spawnedVar      = '[DYNA]Wave5Spawned',
    },
    {
        -- Spawn main Heavens Tower statues + the RDM NM on 3 NM deaths
        requiredVars    = { '[DYNA]WuuKilled', '[DYNA]XooKilled', '[DYNA]HaaKilled' },
        spawn           = { 17543509, 17543512, 17543505 },
        spawnedVar      = '[DYNA]Wave6Spawned',
    },
    {
        -- Spawns 102/103 when 101 dies
        requiredVars    = { '[DYNA]101Killed' },
        spawn           = { 17543395, 17543399 },
        spawnedVar      = '[DYNA]Wave7Spawned',
    },
}

--Specific Statues
xi.dynamis.aggro = xi.dynamis.aggro or { }
xi.dynamis.aggro[zoneID] =
{
    nonAggressive =
    {
        [17543263] = { 17543237 }, -- 24 spawns 25
        [17543320] = { 17543324 }, -- 41 spawns 42
        [17543406] = { 17543407 }, -- 91 spawns 92
        [17543409] = { 17543410 }, -- 89 spawns 90
        [17543479] = { 17543483, 17543485, 17543487 }, -- 80 spawns 81, 82, 83
        [17543430] = { 17543435 }, -- 72 spawns 73
        [17543437] = { 17543442, 17543444 }, -- 74 spawns 75, 76
        [17543460] = { 17543454, 17543457 }, -- 77 spawns 78, 79
        [17543499] = { 17543470, 17543474 }, -- 117spawns 119, 120
        [17543340] = { 17543344, 17543347 }, -- 53 spawns 54, 55
        [17543299] = { 17543300, 17543302, 17543308, 17543306, 17543304 }, -- 35 spawns 36, 37, 38, 39 and 40
    },
    aggressive =
    {
        [17543256] = { 17543259, 17543261 }, -- 21 spawns 22, 23
        [17543287] = { 17543282 }, -- 32 spawns 33
        [17543337] = { 17543327, 17543331, 17543332, 17543334 }, -- 46 spawns 47, 48, 49, 50
        [17543515] = { 17543521, 17543522, 17543525 }, -- 58 spawns 59, 60, 61
        [17543445] = { 17543450, 17543452 }, -- 66 spawns 67, 68
        [17543425] = { 17543428, 17543429 }, -- 69 spawns 70, 71
        [17543416] = { 17543419, 17543423 }, -- 84 spawns 85, 86
        [17543385] = { 17543387 }, -- 97 spawns 98
        [17543387] = { 17543389 }, -- 98 spawns 99
        [17543389] = { 17543392 }, -- 99 spawns 100
        [17543505] = { 17543499, 17543502 }, -- 116 spawns 117, 118
        [17543526] = { 17543535, 17543531, 17543540, 17543541 }, -- 121 spawns 122, 123, 124, 125
        [17543366] = { 17543373, 17543379 }, -- 93 spawns 94, 95
    },
}

xi.dynamis.lineSpawns = xi.dynamis.lineSpawns or { }
xi.dynamis.lineSpawns[zoneID] =
{
    -- Statue ID = { behind = { first mob distance, second mob distance } }, { side = { left distance, right distance } }, or { { xOffset, yOffset, zOffset }, ... }
    -- Mobs with DB spawn position 1.000, 1.000, 1.000 default to spawning on top of the statue.
    -- lineSpawns below is only for explicit positioning exceptions.
    [17543564] = { behind = { 3, 6, 9 } }, -- (130) Mobs spawn in a line behind the statue
    [17543569] = { behind = { 3, 6, 9 } }, -- (131) Mobs spawn in a line behind the statue
    [17543573] = { behind = { 3, 6, 9 } }, -- (132) Mobs spawn in a line behind the statue
    [17543247] = { behind = { 4, 8, -4, -8 } }, -- (27) Mobs spawn front and back
    [17543187] = { behindLine = { behind = { 2, 2, 4 }, side = { -1.5, 1.5, 0 } } }, -- (8) Triangle behind the statue: bottom left, bottom right, top
}

-- Pathing table
xi.dynamis.paths = xi.dynamis.paths or { }
xi.dynamis.paths[zoneID] =
{
    [17543187] = { {  -96,  -2, -123    }, {  -60,  -2, -113  }                     }, -- Entrance Bridge W
    [17543198] = { {  -48,  -2, -104    }, {  -29,  -2,  -70  }                     }, -- Entrance Bridge E
    [17543215] = { {    0,  -9,  -20    }, {   -0,  -4,  -51  }                     }, -- AH W Ramp
    [17543224] = { {   38,  -2,  -60    }, {   38,  -2,  -67  }                     }, -- AH #1
    [17543227] = { {   46,  -1,  -70    }, {   46,  -2,  -59  }                     }, -- AH #2
    [17543230] = { {   54,  -2,  -60    }, {   54,  -2,  -67  }                     }, -- AH #3
    [17543333] = { {   99,  -8,  179    }, {  102,  -8,  176  }, { 108, -11,  171 } }, -- E House Ramp
    [17543435] = { {  -84,  -9,  111    }, {  -85,  -6,  121  }                     }, -- Island to HT
    [17543516] = { {  -88,  -2,   48    }, {  -88,  -5,   82  }                     }, -- SW Bridge #1
    [17543517] = { {  -88,  -2,   48    }, {  -88,  -5,   82  }                     }, -- SW Bridge #2
    [17543520] = { {  -88,  -2,   48    }, {  -88,  -5,   82  }                     }, -- SW Bridge #3
    [17543409] = { {  -57, -13,  226    }, {  -61, -13,  209  }                     }, -- NW Bridge S
    [17543406] = { {  -52, -13,  234    }, {  -36, -13,  244  }                     }, -- NW Bridge N
    [17543364] = { {   48,  -8,  213    }, {   48,  -8,  216  }                     }, -- Bridge to HotH #4
    [17543358] = { {   54,  -8,  220    }, {   51,  -8,  220  }                     }, -- Bridge to HotH #1
    [17543362] = { {   48,  -8,  226    }, {   48,  -8,  223  }                     }, -- Bridge to HotH #3
    [17543360] = { {   42,  -8,  219    }, {   45,  -8,  219  }                     }, -- Bridge to HotH #2
    [17543247] = { {  52, -7.5,  -53    }, {   40, -7.5, -53  }                     }, -- Top of AH
    [17543564] = { { -25.5, -2.5, -64   }, { -34.5, -2.5, -80.4 }                   },
    [17543569] = { { -42.2, -2.5, -93.5 }, { -35.5, -2.5, -82 }                     },
    [17543573] = { {   -53, -2.5, -111  }, { -43.5, -2.5, -95.4 }                   },
}

xi.dynamis.timeExtension = xi.dynamis.timeExtension or { }
xi.dynamis.timeExtension[zoneID] =
{
    [xi.windurst.mobs.MANIFEST_ICON_8]   =  20, --Avatar Icon
    [xi.windurst.mobs.AVATAR_ICON_18]    =  20, --Avatar Icon
    [xi.windurst.mobs.AVATAR_ICON_31]    =  10, --Avatar Icon
    [xi.windurst.mobs.AVATAR_ICON_41]    =  20, --Avatar Icon
    [xi.windurst.mobs.AVATAR_ICON_58]    =  10, --Avatar Icon
    [xi.windurst.mobs.MANIFEST_ICON_66]  =  20, --Avatar Icon
    [xi.windurst.mobs.MANIFEST_ICON_101] =  20, --Avatar Icon
    [xi.windurst.mobs.TZEE_XICU_IDOL]    =  30, --Tzee_Xicu_Idol
}
