
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/zone")
require("scripts/globals/msg")

-----------------------------------
-- battlefields by zone
-- captured from client 2020-10-24
-----------------------------------

--[[
    [zoneId] = {
        {bit, battlefieldIdInDatabase, requiredItemToTrade}
    },
--]]

local battlefields = {
    [xi.zone.BEARCLAW_PINNACLE] =
    {
        { 0,  640,    0},   -- Flames of the Dead (PM5-3 U3)
     -- { 1,  641,    0},   -- Follow the White Rabbit (ENM)
     -- { 2,  642,    0},   -- When Hell Freezes Over (ENM)
     -- { 3,  643,    0},   -- Brothers (ENM) -- TODO: Chthonian Ray mobskill
     -- { 4,  644,    0},   -- Holy Cow (ENM)
     -- { 5,    ?, 3454},   -- Taurassic Park (HKC30)
    },

    [xi.zone.BONEYARD_GULLY] =
    {
        { 0,  672,    0},   -- Head Wind (PM5-3 U2)
     -- { 1,  673,    0},   -- Like the Wind (ENM) -- TODO: mob constantly runs during battle
        { 2,  674,    0},   -- Sheep in Antlion's Clothing (ENM)
     -- { 3,  675,    0},   -- Shell We Dance? (ENM) -- TODO: Needs testing, cleanup, and mixin work
     -- { 4,  676,    0},   -- Totentanz (ENM)
     -- { 5,  677,    0},   -- Tango with a Tracker (Quest)
     -- { 6,  678,    0},   -- Requiem of Sin (Quest)
     -- { 7,  679, 3454},   -- Antagonistic Ambuscade (HKC30)
     -- { 8,    ?,    0},   -- *Head Wind (HTMBF)
    },

    [xi.zone.THE_SHROUDED_MAW] =
    {
        { 0,  704,    0},   -- Darkness Named (PM3-5)
     -- { 1,  705,    0},   -- Test Your Mite (ENM)
        { 2,  706,    0},   -- Waking Dreams (Quest)
     -- { 3,    ?,    0},   -- *Waking Dreams (HTMBF)
    },

    [xi.zone.MINE_SHAFT_2716] =
    {
        { 0,  736,    0},   -- A Century of Hardship (PM5-3 L3)
     -- { 1,  737,    0},   -- Return to the Depths (Quest)
     -- { 2,  738,    0},   -- Bionic Bug (ENM)
     -- { 3,  739,    0},   -- Pulling the Strings (ENM)
     -- { 4,  740,    0},   -- Automaton Assault (ENM)
     -- { 5,  741, 3455},   -- The Mobline Comedy (HKC50)
    },

    [xi.zone.SPIRE_OF_HOLLA] =
    {
        { 0,  768,    0},   -- Ancient Flames Beckon (PM1-3)
     -- { 1,  769,    0},   -- Simulant (ENM)
     -- { 2,  770, 3351},   -- Empty Hopes (KC30)
    },

    [xi.zone.SPIRE_OF_DEM] =
    {
        { 0,  800,    0},   -- Ancient Flames Beckon (PM1-3)
     -- { 1,  801,    0},   -- You Are What You Eat (ENM)
     -- { 2,  802, 3351},   -- Empty Dreams (KC30)
    },

    [xi.zone.SPIRE_OF_MEA] =
    {
        { 0,  832,    0},   -- Ancient Flames Beckon (PM1-3)
     -- { 1,  833,    0},   -- Playing Host (ENM)
     -- { 2,  834, 3351},   -- Empty Desires (KC30)
    },

    [xi.zone.SPIRE_OF_VAHZL] =
    {
        { 0,  864,    0},   -- Desires of Emptiness (PM5-2)
     -- { 1,  865,    0},   -- Pulling the Plug (ENM)
     -- { 2,  866, 3352},   -- Empty Aspirations (KC50)
    },

    [xi.zone.RIVERNE_SITE_B01] =
    {
        { 0,  896,    0},   -- Storms of Fate (Quest)
     -- { 1,  897, 2108},   -- The Wyrmking Descends (BCNM)
    },

    [xi.zone.RIVERNE_SITE_A01] =
    {
     -- { 0,  928, 1842},   -- Ouryu Cometh (BCNM)
    },

    [xi.zone.MONARCH_LINN] =
    {
        { 0,  960,    0},   -- Ancient Vows (PM2-5)
        { 1,  961,    0},   -- The Savage (PM4-2)
     -- { 2,  962,    0},   -- Fire in the Sky (ENM)
     -- { 3,  963,    0},   -- Bad Seed (ENM)
     -- { 4,  964,    0},   -- Bugard in the Clouds (ENM)
     -- { 5,  965,    0},   -- Beloved of the Atlantes (ENM)
     -- { 6,  966,    0},   -- Uninvited Guests (Quest)
     -- { 7,  967, 3455},   -- Nest of Nightmares (HKC50)
     -- { 8,    ?,    0},   -- *The Savage (HTMBF)
    },

    [xi.zone.SEALIONS_DEN] =
    {
        { 0,  992,    0},   -- One to Be Feared (PM6-4)
        { 1,  993,    0},   -- The Warrior's Path (PM7-5)
     -- { 2,    ?,    0},   -- *The Warrior's Path (HTMBF)
     -- { 3,    ?,    0},   -- *One to Be Feared (HTMBF)
    },

    [xi.zone.THE_GARDEN_OF_RUHMET] =
    {
        { 0, 1024,    0},   -- When Angels Fall (PM8-3)
    },

    [xi.zone.EMPYREAL_PARADOX] =
    {
        { 0, 1056,    0},   -- Dawn (PM8-4)
        { 1, 1057,    0},   -- Apocalypse Nigh (Quest)
     -- { 2,    ?,    0},   -- Both Paths Taken (ROVM2-9-2)
     -- { 3,    ?,    0},   -- *Dawn (HTMBF)
     -- { 4,    ?,    0},   -- The Winds of Time (ROVM3-1-26)
     -- { 5,    ?,    0},   -- Sealed Fate (Master Trial)
    },

    [xi.zone.TEMENOS] =
    {
     -- { 0, 1299,    0},   -- Northern Tower
     -- { 1, 1300,    0},   -- Eastern Tower
     -- { 2, 1298,    0},   -- Western Tower
     -- { 3, 1306,   -1},   -- Central 4th Floor (multiple items needed: 1907, 1908, 1986)
     -- { 4, 1305, 1904},   -- Central 3rd Floor
     -- { 5, 1304, 1905},   -- Central 2nd Floor
     -- { 6, 1303, 1906},   -- Central 1st Floor
     -- { 7, 1301, 2127},   -- Central Basement
     -- { 8, 1302,    0},   -- Central Basement II
     -- { 9, 1307,    0},   -- Central 4th Floor II
    },

    [xi.zone.APOLLYON] =
    {
     -- { 0, 1291,    0},   -- SW Apollyon
     -- { 1, 1290,    0},   -- NW Apollyon
     -- { 2, 1293,    0},   -- SE Apollyon
     -- { 3, 1292,    0},   -- NE Apollyon
     -- { 4, 1296,   -2},   -- Central Apollyon (multiple items needed: 1909 1910 1987 1988)
     -- { 5, 1294, 2127},   -- CS Apollyon
     -- { 6, 1295,    0},   -- CS Apollyon II
     -- { 7, 1297,    0},   -- Central Apollyon II
    },

    [xi.zone.ARRAPAGO_REEF] =
    {
     -- { 0,    ?,    0},   -- Lamia Reprisal
    },

    [xi.zone.TALACCA_COVE] =
    {
     -- { 0, 1088,    0},   -- Call to Arms (ISNM)
     -- { 1, 1089,    0},   -- Compliments to the Chef (ISNM)
     -- { 2, 1090,    0},   -- Puppetmaster Blues (Quest)
        { 3, 1091, 2332},   -- Breaking the Bonds of Fate (COR LB5)
        { 4, 1092,    0},   -- Legacy of the Lost (TOAU35)
     -- { 5,    ?,    0},   -- *Legacy of the Lost (HTMBF)
    },

    [xi.zone.HALVUNG] =
    {
     -- { 0,    ?,    0},   -- Halvung Invasion
    },

    [xi.zone.NAVUKGO_EXECUTION_CHAMBER] =
    {
     -- { 0, 1120,    0},   -- Tough Nut to Crack (ISNM)
     -- { 1, 1121,    0},   -- Happy Caster (ISNM)
        { 2, 1122,    0},   -- Omens (BLU AF2)
        { 3, 1123, 2333},   -- Achieving True Power (PUP LB5)
        { 4, 1124,    0},   -- Shield of Diplomacy (TOAU22)
    },

    [xi.zone.MAMOOK] =
    {
     -- { 0,    ?,    0},   -- Mamook Incursion
    },

    [xi.zone.JADE_SEPULCHER] =
    {
     -- { 0, 1152,    0},   -- Making a Mockery (ISNM)
     -- { 1, 1153,    0},   -- Shadows of the Mind (ISNM)
        { 2, 1154, 2331},   -- The Beast Within (BLU LB5)
     -- { 3, 1155,    0},   -- Moment of Truth (Quest)
        { 4, 1156,    0},   -- Puppet in Peril (TOAU29)
     -- { 5,    ?,    0},   -- *Puppet in Peril (HTMBF)
    },

    [xi.zone.HAZHALM_TESTING_GROUNDS] =
    {
     -- { 0, 1184,    0},   -- The Rider Cometh (Quest)
    },

    [xi.zone.LA_VAULE_S] =
    {
     -- { 0,    ?,    0},   -- Splitting Heirs (S)
     -- { 1,    ?,    0},   -- Purple, The New Black
     -- { 2,    ?,    0},   -- The Blood-bathed Crown
    },

    [xi.zone.BEADEAUX_S] =
    {
     -- { 0,    ?,    0},   -- Cracking Shells (B)
     -- { 1,    ?,    0},   -- The Buried God
    },

    [xi.zone.CASTLE_OZTROJA_S] =
    {
     -- { 0,    ?,    0},   -- Plucking Wings (W)
     -- { 1,    ?,    0},   -- A Malicious Manifest
     -- { 2,    ?,    0},   -- Manifest Destiny
     -- { 3,    ?,    0},   -- At Journey's End
    },

    [xi.zone.HORLAIS_PEAK] =
    {
        { 0,    0,    0},   -- The Rank 2 Final Mission (Mission 2-3)
        { 1,    1, 1131},   -- Tails of Woe (BS40)
        { 2,    2, 1130},   -- Dismemberment Brigade (BS60)
        { 3,    3,    0},   -- The Secret Weapon (Sandy 7-2)
     -- { 4,    4, 1177},   -- Hostile Herbivores (BS50) -- TODO: mobs need knockback on melee attacks
        { 5,    5, 1426},   -- Shattering Stars (WAR LB5)
        { 6,    6, 1429},   -- Shattering Stars (BLM LB5)
        { 7,    7, 1436},   -- Shattering Stars (RNG LB5)
        { 8,    8, 1552},   -- Carapace Combatants (BS30)
     -- { 9,    9, 1551},   -- Shooting Fish (BS20) -- TODO: mobs use ranged attacks with knockback
        {10,   10, 1552},   -- Dropping Like Flies (BS30)
     -- {11,   11, 1553},   -- Horns of War (KS99) -- TODO: Chlevnik is unscripted
        {12,   12, 1131},   -- Under Observation (BS40)
        {13,   13, 1177},   -- Eye of the Tiger (BS50) -- TODO: Crossthrash mobskill
     -- {14,   14, 1130},   -- Shots in the Dark (BS60) -- TODO: Warmachine combat behavior
        {15,   15, 1175},   -- Double Dragonian (KS30) -- TODO: Chaos Blade strengthens after 2hr
     -- {16,   16, 1178},   -- Today's Horoscope (KS30)
     -- {17,   17, 1180},   -- Contaminated Colosseum (KS30) -- TODO: Extremely Bad Breath mobskill
     -- {18,   18, 3351},   -- Kindergarten Cap (KC30)
     -- {19,   19, 3352},   -- Last Orc-Shunned Hero (KC50)
        {20,   20,    0},   -- Beyond Infinity (Quest)
     -- {21,    ?, 4062},   -- *Tails of Woe (SKC10)
     -- {22,    ?, 4063},   -- *Dismemberment Brigade (SKC20)
     -- {23,    ?,    0},   -- A Feast Most Dire (Quest)
     -- {24,    ?,    0},   -- A.M.A.N. Trove (Mars)
     -- {25,    ?,    0},   -- A.M.A.N. Trove (Venus)
     -- {26,    ?,    0},   -- Inv. from Excenmille
     -- {27,    ?,    0},   -- Inv. from Excenmille and Co.
    },

    [xi.zone.GHELSBA_OUTPOST] =
    {
        { 0,   32,    0},   -- Save the Children (Sandy 1-3)
        { 1,   33,    0},   -- The Holy Crest (Quest)
        { 2,   34, 1551},   -- Wings of Fury (BS20) -- TODO: mobskills Slipstream and Turbulence
        { 3,   35, 1552},   -- Petrifying Pair (BS30)
        { 4,   36, 1552},   -- Toadal Recall (BS30) -- TODO: shroom-in-cap mechanic
     -- { 5,   37,    0},   -- Mirror, Mirror (Quest)
    },

    [xi.zone.WAUGHROON_SHRINE] =
    {
        { 0,   64,    0},   -- The Rank 2 Final Mission (Mission 2-3)
        { 1,   65, 1131},   -- The Worm's Turn (BS40)
        { 2,   66, 1130},   -- Grimshell Shocktroopers (BS60)
        { 3,   67,    0},   -- On My Way (Basty 7-2)
        { 4,   68, 1166},   -- A Thief in Norg!? (Quest)
        { 5,   69, 1177},   -- 3, 2, 1... (BS50) -- TODO: Self Destruct does not display correct message in chat log
        { 6,   70, 1430},   -- Shattering Stars (RDM LB5)
        { 7,   71, 1431},   -- Shattering Stars (THF LB5)
        { 8,   72, 1434},   -- Shattering Stars (BST LB5)
        { 9,   73, 1552},   -- Birds of a Feather (BS30)
     -- {10,   74, 1551},   -- Crustacean Conundrum (BS20) -- TODO: You can only do 0-2 damage no matter what your attack is
        {11,   75, 1552},   -- Grove Guardians (BS30)
     -- {12,   76, 1553},   -- The Hills are Alive (KS99) -- TODO: Tartaruga Gigante is not coded
     -- {13,   77, 1131},   -- Royal Jelly (BS40) -- TODO: all combat mechanics, loot
     -- {14,   78, 1177},   -- The Final Bout (BS50) -- TODO: mobskills Big Blow and Counterstance
        {15,   79, 1130},   -- Up in Arms (BS60)
     -- {16,   80, 1175},   -- Copycat (KS30)
     -- {17,   81, 1178},   -- Operation Desert Swarm (KS30) -- TODO: Wild Rage gets stronger as they die. Build sleep resistance. Testing.
     -- {18,   82, 1180},   -- Prehistoric Pigeons (KS30) -- TODO: Build resistance to sleep quickly. When one dies, remaining ones become more powerful.
     -- {19,   83, 3351},   -- The Palborough Project (KC30)
     -- {20,   84, 3352},   -- Shell Shocked (KC50)
        {21,   85,    0},   -- Beyond Infinity (Quest)
     -- {22,    ?, 4062},   -- *The Worm's Tail (SKC10)
     -- {23,    ?, 4063},   -- *Grimshell Shocktroopers (SKC20)
     -- {24,    ?,    0},   -- A Feast Most Dire (Quest)
     -- {25,    ?,    0},   -- A.M.A.N. Trove (Mars)
     -- {26,    ?,    0},   -- A.M.A.N. Trove (Venus)
     -- {27,    ?,    0},   -- Invitation from Naji
     -- {28,    ?,    0},   -- Invitation from Naji and Co.
    },

    [xi.zone.BALGAS_DAIS] =
    {
        { 0,   96,    0},   -- The Rank 2 Final Mission (Mission 2-3)
        { 1,   97, 1131},   -- Steamed Sprouts (BS40)
        { 2,   98, 1130},   -- Divine Punishers (BS60)
        { 3,   99,    0},   -- Saintly Invitation (Windy 6-2)
        { 4,  100, 1177},   -- Treasure and Tribulations (BS50)
        { 5,  101, 1427},   -- Shattering Stars (MNK LB5)
        { 6,  102, 1428},   -- Shattering Stars (WHM LB5)
        { 7,  103, 1440},   -- Shattering Stars (SMN LB5)
        { 8,  104, 1552},   -- Creeping Doom (BS30)
        { 9,  105, 1551},   -- Charming Trio (BS20)
        {10,  106, 1552},   -- Harem Scarem (BS30)
     -- {11,  107, 1553},   -- Early Bird Catches the Wyrm (KS99)
        {12,  108, 1131},   -- Royal Succession (BS40)
        {13,  109, 1177},   -- Rapid Raptors (BS50)
        {14,  110, 1130},   -- Wild Wild Whiskers (BS60) -- TODO: should use petrifactive breath more often than other mobskill. Message before spellcasting.
     -- {15,  111, 1175},   -- Seasons Greetings (KS30)
     -- {16,  112, 1178},   -- Royale Ramble (KS30)
     -- {17,  113, 1180},   -- Moa Constrictors (KS30)
     -- {18,  114, 3351},   -- The V Formation (KC30)
     -- {19,  115, 3352},   -- Avian Apostates (KC50)
        {20,  116,    0},   -- Beyond Infinity (Quest)
     -- {21,    ?, 4062},   -- *Steamed Sprouts (SKC10)
     -- {22,    ?, 4063},   -- *Divine Punishers (SKC20)
     -- {23,    ?,    0},   -- A Feast Most Dire (Quest)
     -- {24,    ?,    0},   -- A.M.A.N. Trove (Mars)
     -- {25,    ?,    0},   -- A.M.A.N. Trove (Venus)
     -- {26,    ?,    0},   -- Inv. from Kupipi
     -- {27,    ?,    0},   -- Inv. from Kupipi and Co.
    },

    [xi.zone.THRONE_ROOM_S] =
    {
     -- { 0,  352,    0},   -- Fiat Lux (Campaign)
     -- { 1,  353,    0},   -- Darkness Descends (WOTG37)
     -- { 2,  354,    0},   -- Bonds of Mythril (Quest)
     -- { 3,    ?,    0},   -- Unafraid of the Dark (Merit Battlefield)
    },

    [xi.zone.SACRIFICIAL_CHAMBER] =
    {
        { 0,  128,    0},   -- The Temple of Uggalepih (ZM4)
        { 1,  129, 1130},   -- Jungle Boogymen (BS60)
        { 2,  130, 1130},   -- Amphibian Assault (BS60)
     -- { 3,  131,    0},   -- Project: Shantottofication (ASA13)
     -- { 4,  132, 3352},   -- Whom Wilt Thou Call (KC50)
     -- { 5,    ?, 4063},   -- *Jungle Boogymen (SKC20)
     -- { 6,    ?, 4063},   -- *Amphibian Assault (SKC20)
    },

    [xi.zone.THRONE_ROOM] =
    {
        { 0,  160,    0},   -- The Shadow Lord Battle (Mission 5-2)
        { 1,  161,    0},   -- Where Two Paths Converge (Basty 9-2)
     -- { 2,  162, 1130},   -- Kindred Spirits (BS60)
        { 3,  163, 2557},   -- Survival of the Wisest (SCH LB5)
     -- { 4,  164,    0},   -- Smash! A Malevolent Menace (MKD14)
     -- { 5,    ?, 4063},   -- *Kindred Spirits (SKC20)
     -- { 6,    ?,    0},   -- *The Shadowlord Battle (HTMBF)
     -- { 7,    ?,    0},   -- True Love
     -- { 8,    ?,    0},   -- A Fond Farewell
    },

    [xi.zone.CHAMBER_OF_ORACLES] =
    {
        { 0,  192,    0},   -- Through the Quicksand Caves (ZM6)
        { 1,  193, 1130},   -- Legion XI Comitatensis (BS60)
        { 2,  194, 1437},   -- Shattering Stars (SAM LB5)
        { 3,  195, 1438},   -- Shattering Stars (NIN LB5)
        { 4,  196, 1439},   -- Shattering Stars (DRG LB5)
     -- { 5,  197, 1175},   -- Cactuar Suave (KS30)
        { 6,  198, 1178},   -- Eye of the Storm (KS30)
     -- { 7,  199, 1180},   -- The Scarlet King (KS30)
     -- { 8,  200,    0},   -- Roar! A Cat Burglar Bares Her Fangs (MKD10)
     -- { 9,  201, 3352},   -- Dragon Scales (KC50)
     -- {10,    ?, 4063},   -- *Legion XI Comitatensis (SKC20)
    },

    [xi.zone.FULL_MOON_FOUNTAIN] =
    {
        { 0,  224,    0},   -- The Moonlit Path (Quest)
        { 1,  225,    0},   -- Moon Reading (Windy 9-2)
     -- { 2,  226,    0},   -- Waking the Beast (Quest)
     -- { 3,  227,    0},   -- Battaru Royale (ASA10)
     -- { 4,    ?,    0},   -- *The Moonlit Path (HTMBF)
     -- { 5,    ?,    0},   -- *Waking the Beast (HTMBF)
    },

    [xi.zone.STELLAR_FULCRUM] =
    {
        { 0,  256,    0},   -- Return to Delkfutt's Tower (ZM8)
     -- { 1,  257,    0},   -- The Indomitable Triumvirate (Mog Bonanza)
     -- { 2,  258,    0},   -- The Dauntless Duo (Mog Bonanza)
     -- { 3,  259,    0},   -- The Solitary Demolisher (Mog Bonanza)
     -- { 4,  260,    0},   -- Heroine's Combat (Mog Bonanza)
     -- { 5,  261,    0},   -- Mercenary Camp (Mog Bonanza)
     -- { 6,  262,    0},   -- Ode of Life Bestowing (ACP11)
     -- { 7,    ?,    0},   -- *Return to Delkfutt's Tower (HTMBF)
     -- { 8,    ?,    0},   -- True Love
     -- { 9,    ?,    0},   -- A Fond Farewell
    },

    [xi.zone.LALOFF_AMPHITHEATER] =
    {
        { 0,  288,    0},   -- Ark Angels 1 (ZM14)
        { 1,  289,    0},   -- Ark Angels 2 (ZM14)
        { 2,  290,    0},   -- Ark Angels 3 (ZM14)
        { 3,  291,    0},   -- Ark Angels 4 (ZM14)
        { 4,  292,    0},   -- Ark Angels 5 (ZM14)
        { 5,  293, 1550},   -- Divine Might (ZM14)
     -- { 6,    ?,    0},   -- *Ark Angels 1 (HTMBF)
     -- { 7,    ?,    0},   -- *Ark Angels 2 (HTMBF)
     -- { 8,    ?,    0},   -- *Ark Angels 3 (HTMBF)
     -- { 9,    ?,    0},   -- *Ark Angels 4 (HTMBF)
     -- {10,    ?,    0},   -- *Ark Angels 5 (HTMBF)
     -- {11,    ?,    0},   -- *Divine Might (HTMBF)
    },

    [xi.zone.THE_CELESTIAL_NEXUS] =
    {
        { 0,  320,    0},   -- The Celestial Nexus (ZM16)
     -- { 1,    ?,    0},   -- *The Celestial Nexus (HTMBF)
    },

    [xi.zone.WALK_OF_ECHOES] =
    {
     -- { 0,    ?,    0},   -- When Wills Collide (WOTG46)
     -- { 1,  385,    0},   -- Maiden of the Dusk (WOTG51)
     -- { 2,    ?,    0},   -- Champion of the Dawn (Quest)
     -- { 3,    ?,    0},   -- A Forbidden Reunion (Quest)
    },

    [xi.zone.CLOISTER_OF_GALES] =
    {
        { 0,  416,    0},   -- Trial by Wind (Quest)
        { 1,  417, 1174},   -- Carbuncle Debacle (Quest)
        { 2,  418, 1546},   -- Trial-size Trial by Wind (Quest)
     -- { 3,  419,    0},   -- Waking the Beast (Quest)
        { 4,  420,    0},   -- Sugar-coated Directive (ASA4)
     -- { 5,    ?,    0},   -- *Trial by Wind (HTMBF)
    },

    [xi.zone.CLOISTER_OF_STORMS] =
    {
        { 0,  448,    0},   -- Trial by Lightning (Quest)
        { 1,  449, 1172},   -- Carbuncle Debacle (Quest)
        { 2,  450, 1548},   -- Trial-size Trial by Lightning (Quest)
     -- { 3,  451,    0},   -- Waking the Beast (Quest)
        { 4,  452,    0},   -- Sugar-coated Directive (ASA4)
     -- { 5,    ?,    0},   -- *Trial by Lightning (HTMBF)
    },

    [xi.zone.CLOISTER_OF_FROST] =
    {
        { 0,  480,    0},   -- Trial by Ice (Quest)
        { 1,  481, 1171},   -- Class Reunion (Quest)
        { 2,  482, 1545},   -- Trial-size Trial by Ice (Quest)
     -- { 3,  483,    0},   -- Waking the Beast (Quest)
        { 4,  484,    0},   -- Sugar-coated Directive (ASA4)
     -- { 5,    ?,    0},   -- *Trial by Ice (HTMBF)
    },

    [xi.zone.QUBIA_ARENA] =
    {
        { 0,  512,    0},   -- The Rank 5 Mission (Mission 5-1)
     -- { 1,  513, 1175},   -- Come Into My Parlor (KS30)
     -- { 2,  514, 1178},   -- E-vase-ive Action (KS30)
     -- { 3,  515, 1180},   -- Infernal Swarm (KS30)
        { 4,  516,    0},   -- The Heir to the Light (Sandy 9-2)
        { 5,  517, 1432},   -- Shattering Stars (PLD LB5)
        { 6,  518, 1433},   -- Shattering Stars (DRK LB5)
        { 7,  519, 1435},   -- Shattering Stars (BRD LB5)
        { 8,  520, 1130},   -- Demolition Squad (BS60)
     -- { 9,  521, 1552},   -- Die by the Sword (BS30) -- TODO: mob damage type rotation mobskills furious flurry, smite of fury, whispers of ire
        {10,  522, 1552},   -- Let Sleeping Dogs Die (BS30)
        {11,  523, 1130},   -- Brothers D'Aurphe (BS60)
        {12,  524, 1131},   -- Undying Promise (BS40) -- TODO: model size increases with each reraise
        {13,  525, 1131},   -- Factory Rejects (BS40) -- TODO: dolls grow size/power based on hidden timer. (wikis disagree on TP moves? factory immune? factory model?)
        {14,  526, 1177},   -- Idol Thoughts (BS50)
        {15,  527, 1177},   -- An Awful Autopsy (BS50) -- TODO: mobskill Infernal Pestilence
     -- {16,  528, 1130},   -- Celery (BS60) -- TODO: mobs do not have their specific weaknesses. mobskill Bane.
     -- {17,  529,    0},   -- Mirror Images (Quest)
        {18,  530, 2556},   -- A Furious Finale (DNC LB5)
     -- {19,  531,    0},   -- Clash of the Comrades (Quest)
     -- {20,  532,    0},   -- Those Who Lurk in Shadows (ACP7)
        {21,  533,    0},   -- Beyond Infinity (Quest)
     -- {22,    ?, 4062},   -- *Factory Rejects (SKC10)
     -- {23,    ?, 4063},   -- *Demolition Squad (SKC20)
     -- {24,    ?, 4063},   -- *Brothers D'Aurphe (SKC20)
     -- {25,    ?,    0},   -- Mumor's Encore (Sunbreeze Festival)
    },

    [xi.zone.CLOISTER_OF_FLAMES] =
    {
        { 0,  544,    0},   -- Trial by Fire (Quest)
        { 1,  545, 1544},   -- Trial-size Trial by Fire (Quest)
     -- { 2,  546,    0},   -- Waking the Beast (Quest)
        { 3,  547,    0},   -- Sugar-coated Directive (ASA4)
     -- { 4,    ?,    0},   -- *Trial by Fire (HTMBF)
    },

    [xi.zone.CLOISTER_OF_TREMORS] =
    {
        { 0,  576,    0},   -- Trial by Earth (Quest)
        { 1,  577, 1169},   -- The Puppet Master (Quest)
        { 2,  578, 1547},   -- Trial-size Trial by Earth (Quest)
     -- { 3,  579,    0},   -- Waking the Beast (Quest)
        { 4,  580,    0},   -- Sugar-coated Directive (ASA4)
     -- { 5,    ?,    0},   -- *Trial by Earth (HTMBF)
    },

    [xi.zone.CLOISTER_OF_TIDES] =
    {
        { 0,  608,    0},   -- Trial by Water (Quest)
        { 1,  609, 1549},   -- Trial-size Trial by Water (Quest)
     -- { 2,  610,    0},   -- Waking the Beast (Quest)
        { 3,  611,    0},   -- Sugar-coated Directive (ASA4)
     -- { 4,    ?,    0},   -- *Trial by Water (HTMBF)
    },

}

-----------------------------------
-- check requirements for registrant and allies
-----------------------------------

function checkReqs(player, npc, bfid, registrant)
    local mi      = xi.mission.id
    local npcid   = npc:getID()
    local mjob    = player:getMainJob()
    local mlvl    = player:getMainLvl()
    local nat     = player:getCurrentMission(player:getNation())
    local sandy   = player:getCurrentMission(SANDORIA)
    local basty   = player:getCurrentMission(BASTOK)
    local windy   = player:getCurrentMission(WINDURST)
    local roz     = player:getCurrentMission(ZILART)
    local cop     = player:getCurrentMission(COP)
    local toau    = player:getCurrentMission(TOAU)
    local asa     = player:getCurrentMission(ASA)
    local natStat  = player:getMissionStatus(player:getNation())
    local rozStat  = player:getMissionStatus(xi.mission.log_id.ZILART)
    local copStat  = player:getCharVar("PromathiaStatus")
    local toauStat = player:getCharVar("AhtUrganStatus")
    local stc = player:hasCompletedMission(xi.mission.log_id.SANDORIA, mi.sandoria.SAVE_THE_CHILDREN)
    local dm1 = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT)
    local dm2 = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT_REPEAT)

    local function getEntranceOffset(offset)
        return zones[player:getZoneID()].npc.ENTRANCE_OFFSET + offset
    end

    -- requirements to register a battlefield
    local registerReqs =
    {
        [   0] = function() return ( (basty == mi.bastok.THE_EMISSARY_SANDORIA2 or windy == mi.windurst.THE_THREE_KINGDOMS_SANDORIA2) and natStat == 9                      ) end, -- Mission 2-3
        [   3] = function() return ( sandy == mi.sandoria.THE_SECRET_WEAPON and player:getCharVar("SecretWeaponStatus") == 2                                                ) end, -- Sandy 7-2: The Secret Weapon
        [   5] = function() return ( mjob == xi.job.WAR and mlvl >= 66                                                                                                     ) end, -- Quest: Shattering Stars (WAR LB5)
        [   6] = function() return ( mjob == xi.job.BLM and mlvl >= 66                                                                                                     ) end, -- Quest: Shattering Stars (BLM LB5)
        [   7] = function() return ( mjob == xi.job.RNG and mlvl >= 66                                                                                                     ) end, -- Quest: Shattering Stars (RNG LB5)
        [  20] = function() return ( player:hasKeyItem(xi.ki.SOUL_GEM_CLASP)                                                                                               ) end, -- Quest: Beyond Infinity
        [  32] = function() return ( sandy == mi.sandoria.SAVE_THE_CHILDREN and ((stc and natStat <= 2) or (not stc and natStat == 2))                                      ) end, -- Sandy 1-3: Save the Children
        [  33] = function() return ( player:hasKeyItem(xi.ki.DRAGON_CURSE_REMEDY)                                                                                          ) end, -- Quest: The Holy Crest
        [  64] = function() return ( (sandy == mi.sandoria.JOURNEY_TO_BASTOK2 or windy == mi.windurst.THE_THREE_KINGDOMS_BASTOK2) and natStat == 10                         ) end, -- Mission 2-3
        [  67] = function() return ( basty == mi.bastok.ON_MY_WAY and natStat == 2                                                                                          ) end, -- Basty 7-2: On My Way
        [  68] = function() return ( player:getCharVar("aThiefinNorgCS") == 6                                                                                               ) end, -- Quest: A Thief in Norg!?
        [  70] = function() return ( mjob == xi.job.RDM and mlvl >= 66                                                                                                     ) end, -- Quest: Shattering Stars (RDM LB5)
        [  71] = function() return ( mjob == xi.job.THF and mlvl >= 66                                                                                                     ) end, -- Quest: Shattering Stars (THF LB5)
        [  72] = function() return ( mjob == xi.job.BST and mlvl >= 66                                                                                                     ) end, -- Quest: Shattering Stars (BST LB5)
        [  85] = function() return ( player:hasKeyItem(xi.ki.SOUL_GEM_CLASP)                                                                                               ) end, -- Quest: Beyond Infinity
        [  96] = function() return ( player:hasKeyItem(xi.ki.DARK_KEY)                                                                                                     ) end, -- Mission 2-3
        [  99] = function() return ( windy == mi.windurst.SAINTLY_INVITATION and natStat == 1                                                                               ) end, -- Windy 6-2: A Saintly Invitation
        [ 101] = function() return ( mjob == xi.job.MNK and mlvl >= 66                                                                                                     ) end, -- Quest: Shattering Stars (MNK LB5)
        [ 102] = function() return ( mjob == xi.job.WHM and mlvl >= 66                                                                                                     ) end, -- Quest: Shattering Stars (WHM LB5)
        [ 103] = function() return ( mjob == xi.job.SMN and mlvl >= 66                                                                                                     ) end, -- Quest: Shattering Stars (SMN LB5)
        [ 116] = function() return ( player:hasKeyItem(xi.ki.SOUL_GEM_CLASP)                                                                                               ) end, -- Quest: Beyond Infinity
        [ 128] = function() return ( roz == mi.zilart.THE_TEMPLE_OF_UGGALEPIH                                                                                               ) end, -- ZM4: The Temple of Uggalepih
        [ 160] = function() return ( nat == mi.nation.SHADOW_LORD and natStat == 3                                                                                          ) end, -- Mission 5-2
        [ 161] = function() return ( basty == mi.bastok.WHERE_TWO_PATHS_CONVERGE and natStat == 1                                                                           ) end, -- Basty 9-2: Where Two Paths Converge
        [ 163] = function() return ( mjob == xi.job.SCH and mlvl >= 66                                                                                                     ) end, -- Quest: Survival of the Wisest (SCH LB5)
        [ 192] = function() return ( roz == mi.zilart.THROUGH_THE_QUICKSAND_CAVES                                                                                           ) end, -- ZM6: Through the Quicksand Caves
        [ 194] = function() return ( mjob == xi.job.SAM and mlvl >= 66                                                                                                     ) end, -- Quest: Shattering Stars (SAM LB5)
        [ 195] = function() return ( mjob == xi.job.NIN and mlvl >= 66                                                                                                     ) end, -- Quest: Shattering Stars (NIN LB5)
        [ 196] = function() return ( mjob == xi.job.DRG and mlvl >= 66                                                                                                     ) end, -- Quest: Shattering Stars (DRG LB5)
        [ 224] = function() return ( player:hasKeyItem(xi.ki.MOON_BAUBLE)                                                                                                  ) end, -- Quest: The Moonlit Path
        [ 225] = function() return ( windy == mi.windurst.MOON_READING and natStat == 2                                                                                     ) end, -- Windy 9-2: Moon Reading
        [ 256] = function() return ( roz == mi.zilart.RETURN_TO_DELKFUTTS_TOWER and rozStat == 3                                                                            ) end, -- ZM8: Return to Delkfutt's Tower
        [ 288] = function() return ( roz == mi.zilart.ARK_ANGELS and rozStat == 1 and npcid == getEntranceOffset(0) and not player:hasKeyItem(xi.ki.SHARD_OF_APATHY)       ) end, -- ZM14: Ark Angels (Hume)
        [ 289] = function() return ( roz == mi.zilart.ARK_ANGELS and rozStat == 1 and npcid == getEntranceOffset(1) and not player:hasKeyItem(xi.ki.SHARD_OF_COWARDICE)    ) end, -- ZM14: Ark Angels (Tarutaru)
        [ 290] = function() return ( roz == mi.zilart.ARK_ANGELS and rozStat == 1 and npcid == getEntranceOffset(2) and not player:hasKeyItem(xi.ki.SHARD_OF_ENVY)         ) end, -- ZM14: Ark Angels (Mithra)
        [ 291] = function() return ( roz == mi.zilart.ARK_ANGELS and rozStat == 1 and npcid == getEntranceOffset(3) and not player:hasKeyItem(xi.ki.SHARD_OF_ARROGANCE)    ) end, -- ZM14: Ark Angels (Elvaan)
        [ 292] = function() return ( roz == mi.zilart.ARK_ANGELS and rozStat == 1 and npcid == getEntranceOffset(4) and not player:hasKeyItem(xi.ki.SHARD_OF_RAGE)         ) end, -- ZM14: Ark Angels (Galka)
        [ 293] = function() return ( dm1 == QUEST_ACCEPTED or dm2 == QUEST_ACCEPTED                                                                                         ) end, -- ZM14 Divine Might
        [ 320] = function() return ( roz == mi.zilart.THE_CELESTIAL_NEXUS                                                                                                   ) end, -- ZM16: The Celestial Nexus
        [ 416] = function() return ( player:hasKeyItem(xi.ki.TUNING_FORK_OF_WIND)                                                                                          ) end, -- Quest: Trial by Wind
        [ 417] = function() return ( player:getCharVar("CarbuncleDebacleProgress") == 6                                                                                     ) end, -- Quest: Carbuncle Debacle
        [ 418] = function() return ( mjob == xi.job.SMN and mlvl >= 20                                                                                                     ) end, -- Quest: Trial-size Trial by Wind
        [ 420] = function() return ( asa == mi.asa.SUGAR_COATED_DIRECTIVE and player:hasKeyItem(xi.ki.DOMINAS_EMERALD_SEAL)                                                ) end, -- ASA4: Sugar-coated Directive
        [ 448] = function() return ( player:hasKeyItem(xi.ki.TUNING_FORK_OF_LIGHTNING)                                                                                     ) end, -- Quest: Trial by Lightning
        [ 449] = function() return ( player:getCharVar("CarbuncleDebacleProgress") == 3                                                                                     ) end, -- Quest: Carbuncle Debacle
        [ 450] = function() return ( mjob == xi.job.SMN and mlvl >= 20                                                                                                     ) end, -- Quest: Trial-size Trial by Lightning
        [ 452] = function() return ( asa == mi.asa.SUGAR_COATED_DIRECTIVE and player:hasKeyItem(xi.ki.DOMINAS_VIOLET_SEAL)                                                 ) end, -- ASA4: Sugar-coated Directive
        [ 480] = function() return ( player:hasKeyItem(xi.ki.TUNING_FORK_OF_ICE)                                                                                           ) end, -- Quest: Trial by Ice
        [ 481] = function() return ( player:getCharVar("ClassReunionProgress") == 5                                                                                         ) end, -- Quest: Class Reunion
        [ 482] = function() return ( mjob == xi.job.SMN and mlvl >= 20                                                                                                     ) end, -- Quest: Trial-size Trial by Ice
        [ 484] = function() return ( asa == mi.asa.SUGAR_COATED_DIRECTIVE and player:hasKeyItem(xi.ki.DOMINAS_AZURE_SEAL)                                                  ) end, -- ASA4: Sugar-coated Directive
        [ 512] = function() return ( nat == mi.nation.ARCHLICH and natStat == 11                                                                                            ) end, -- Mission 5-1
        [ 516] = function() return ( sandy == mi.sandoria.THE_HEIR_TO_THE_LIGHT and natStat == 3                                                                            ) end, -- Sandy 9-2: The Heir to the Light
        [ 517] = function() return ( mjob == xi.job.PLD and mlvl >= 66                                                                                                     ) end, -- Quest: Shattering Stars (PLD LB5)
        [ 518] = function() return ( mjob == xi.job.DRK and mlvl >= 66                                                                                                     ) end, -- Quest: Shattering Stars (DRK LB5)
        [ 519] = function() return ( mjob == xi.job.BRD and mlvl >= 66                                                                                                     ) end, -- Quest: Shattering Stars (BRD LB5)
        [ 530] = function() return ( mjob == xi.job.DNC and mlvl >= 66                                                                                                     ) end, -- Quest: A Furious Finale (DNC LB5)
        [ 533] = function() return ( player:hasKeyItem(xi.ki.SOUL_GEM_CLASP)                                                                                               ) end, -- Quest: Beyond Infinity
        [ 544] = function() return ( player:hasKeyItem(xi.ki.TUNING_FORK_OF_FIRE)                                                                                          ) end, -- Quest: Trial by Fire
        [ 545] = function() return ( mjob == xi.job.SMN and mlvl >= 20                                                                                                     ) end, -- Quest: Trial-size Trial by Fire
        [ 547] = function() return ( asa == mi.asa.SUGAR_COATED_DIRECTIVE and player:hasKeyItem(xi.ki.DOMINAS_SCARLET_SEAL)                                                ) end, -- ASA4: Sugar-coated Directive
        [ 576] = function() return ( player:hasKeyItem(xi.ki.TUNING_FORK_OF_EARTH)                                                                                         ) end, -- Quest: Trial by Earth
        [ 577] = function() return ( player:getCharVar("ThePuppetMasterProgress") == 2                                                                                      ) end, -- Quest: The Puppet Master
        [ 578] = function() return ( mjob == xi.job.SMN and mlvl >= 20                                                                                                     ) end, -- Quest: Trial-size Trial by Earth
        [ 580] = function() return ( asa == mi.asa.SUGAR_COATED_DIRECTIVE and player:hasKeyItem(xi.ki.DOMINAS_AMBER_SEAL)                                                  ) end, -- ASA4: Sugar-coated Directive
        [ 608] = function() return ( player:hasKeyItem(xi.ki.TUNING_FORK_OF_WATER)                                                                                         ) end, -- Quest: Trial by Water
        [ 609] = function() return ( mjob == xi.job.SMN and mlvl >= 20                                                                                                     ) end, -- Quest: Trial-size Trial by Water
        [ 611] = function() return ( asa == mi.asa.SUGAR_COATED_DIRECTIVE and player:hasKeyItem(xi.ki.DOMINAS_CERULEAN_SEAL)                                               ) end, -- ASA4: Sugar-coated Directive
        [ 640] = function() return ( cop == mi.cop.THREE_PATHS and player:getCharVar("COP_Ulmia_s_Path") == 6                                                               ) end, -- PM5-3 U3: Flames for the Dead
        [ 641] = function() return ( player:hasKeyItem(xi.ki.ZEPHYR_FAN)                                                                                                   ) end, -- ENM: Follow the White Rabbit
        [ 642] = function() return ( player:hasKeyItem(xi.ki.ZEPHYR_FAN)                                                                                                   ) end, -- ENM: When Hell Freezes Over
        [ 643] = function() return ( player:hasKeyItem(xi.ki.ZEPHYR_FAN)                                                                                                   ) end, -- ENM: Brothers
        [ 644] = function() return ( player:hasKeyItem(xi.ki.ZEPHYR_FAN)                                                                                                   ) end, -- ENM: Holy Cow
        [ 672] = function() return ( cop == mi.cop.THREE_PATHS and player:getCharVar("COP_Ulmia_s_Path") == 5                                                               ) end, -- PM5-3 U2: Head Wind
        [ 673] = function() return ( player:hasKeyItem(xi.ki.MIASMA_FILTER)                                                                                                ) end, -- ENM: Like the Wind
        [ 674] = function() return ( player:hasKeyItem(xi.ki.MIASMA_FILTER)                                                                                                ) end, -- ENM: Sheep in Antlion's Clothing
        [ 675] = function() return ( player:hasKeyItem(xi.ki.MIASMA_FILTER)                                                                                                ) end, -- ENM: Shell We Dance?
        [ 676] = function() return ( player:hasKeyItem(xi.ki.MIASMA_FILTER)                                                                                                ) end, -- ENM: Totentanz
        [ 677] = function() return ( player:hasKeyItem(xi.ki.LETTER_FROM_SHIKAREE_X)                                                                                       ) end, -- Quest: Tango with a Tracker
        [ 678] = function() return ( player:hasKeyItem(xi.ki.LETTER_FROM_SHIKAREE_Y)                                                                                       ) end, -- Quest: Requiem of Sin
        [ 704] = function() return ( cop == mi.cop.DARKNESS_NAMED and copStat == 2                                                                                          ) end, -- PM3-5: Darkness Named
        [ 705] = function() return ( player:hasKeyItem(xi.ki.ASTRAL_COVENANT)                                                                                              ) end, -- ENM: Test Your Mite
        [ 706] = function() return ( player:hasKeyItem(xi.ki.VIAL_OF_DREAM_INCENSE)                                                                                        ) end, -- Quest: Waking Dreams
        [ 736] = function() return ( cop == mi.cop.THREE_PATHS and player:getCharVar("COP_Louverance_s_Path") == 5                                                          ) end, -- PM5-3 L3: A Century of Hardship
        [ 738] = function() return ( player:hasKeyItem(xi.ki.SHAFT_2716_OPERATING_LEVER)                                                                                   ) end, -- ENM: Bionic Bug
        [ 739] = function() return ( player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL)                                                                                    ) end, -- ENM: Pulling Your Strings
        [ 740] = function() return ( player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL)                                                                                    ) end, -- ENM: Automaton Assault
        [ 768] = function() return ( (cop == mi.cop.BELOW_THE_ARKS and copStat==1) or (cop == mi.cop.THE_MOTHERCRYSTALS and not player:hasKeyItem(xi.ki.LIGHT_OF_HOLLA))   ) end, -- PM1-3: The Mothercrystals
        [ 769] = function() return ( player:hasKeyItem(xi.ki.CENSER_OF_ABANDONMENT)                                                                                        ) end, -- ENM: Simulant
        [ 800] = function() return ( (cop == mi.cop.BELOW_THE_ARKS and copStat==1) or (cop == mi.cop.THE_MOTHERCRYSTALS and not player:hasKeyItem(xi.ki.LIGHT_OF_DEM))     ) end, -- PM1-3: The Mothercrystals
        [ 801] = function() return ( player:hasKeyItem(xi.ki.CENSER_OF_ANTIPATHY)                                                                                          ) end, -- ENM: You Are What You Eat
        [ 832] = function() return ( (cop == mi.cop.BELOW_THE_ARKS and copStat==1) or (cop == mi.cop.THE_MOTHERCRYSTALS and not player:hasKeyItem(xi.ki.LIGHT_OF_MEA))     ) end, -- PM1-3: The Mothercrystals
        [ 833] = function() return ( player:hasKeyItem(xi.ki.CENSER_OF_ANIMUS)                                                                                             ) end, -- ENM: Playing Host
        [ 864] = function() return ( cop == mi.cop.DESIRES_OF_EMPTINESS and copStat == 8                                                                                    ) end, -- PM5-2: Desires of Emptiness
        [ 865] = function() return ( player:hasKeyItem(xi.ki.CENSER_OF_ACRIMONY)                                                                                           ) end, -- ENM: Pulling the Plug
        [ 896] = function() return ( player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) == QUEST_ACCEPTED and player:getCharVar('StormsOfFate') == 2           ) end, -- Quest: Storms of Fate
        [ 960] = function() return ( cop == mi.cop.ANCIENT_VOWS and copStat == 2                                                                                            ) end, -- PM2-5: Ancient Vows
        [ 961] = function() return ( cop == mi.cop.THE_SAVAGE and copStat == 1                                                                                              ) end, -- PM4-2: The Savage
        [ 962] = function() return ( player:hasKeyItem(xi.ki.MONARCH_BEARD)                                                                                                ) end, -- ENM: Fire in the Sky
        [ 963] = function() return ( player:hasKeyItem(xi.ki.MONARCH_BEARD)                                                                                                ) end, -- ENM: Bad Seed
        [ 964] = function() return ( player:hasKeyItem(xi.ki.MONARCH_BEARD)                                                                                                ) end, -- ENM: Bugard in the Clouds
        [ 965] = function() return ( player:hasKeyItem(xi.ki.MONARCH_BEARD)                                                                                                ) end, -- ENM: Beloved of Atlantes
        [ 992] = function() return ( cop == mi.cop.ONE_TO_BE_FEARED and copStat == 2                                                                                        ) end, -- PM6-4: One to be Feared
        [ 993] = function() return ( cop == mi.cop.THE_WARRIOR_S_PATH                                                                                                       ) end, -- PM7-5: The Warrior's Path
        [1024] = function() return ( cop == mi.cop.WHEN_ANGELS_FALL and copStat == 4                                                                                        ) end, -- PM8-3: When Angels Fall
        [1056] = function() return ( cop == mi.cop.DAWN and copStat == 2                                                                                                    ) end, -- PM8-4: Dawn
        [1057] = function() return ( player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) == QUEST_ACCEPTED and player:getCharVar('ApocalypseNigh') == 4        ) end, -- Apocalypse Nigh
        [1090] = function() return ( player:hasKeyItem(xi.ki.TOGGLE_SWITCH)                                                                                                ) end, -- Quest: Puppetmaster Blues
        [1091] = function() return ( mjob == xi.job.COR and mlvl >= 66                                                                                                     ) end, -- Quest: Breaking the Bonds of Fate (COR LB5)
        [1092] = function() return ( toau == mi.toau.LEGACY_OF_THE_LOST                                                                                                     ) end, -- TOAU35: Legacy of the Lost
        [1122] = function() return ( player:getQuestStatus(xi.quest.log_id.AHT_URHGAN,xi.quest.id.ahtUrhgan.OMENS) == QUEST_ACCEPTED and player:getCharVar('OmensProgress') == 1           ) end, -- Quest: Omens (BLU AF Quest 2)
        [1123] = function() return ( mjob == xi.job.PUP and mlvl >= 66                                                                                                     ) end, -- Quest: Achieving True Power (PUP LB5)
        [1124] = function() return ( toau == mi.toau.SHIELD_OF_DIPLOMACY and toauStat == 2                                                                                  ) end, -- TOAU22: Shield of Diplomacy
        [1154] = function() return ( mjob == xi.job.BLU and mlvl >= 66                                                                                                     ) end, -- Quest: The Beast Within (BLU LB5)
        [1156] = function() return ( toau == mi.toau.PUPPET_IN_PERIL and toauStat == 1                                                                                      ) end, -- TOAU29: Puppet in Peril
        [1290] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.RED_CARD) and npcid == getEntranceOffset(0)                        ) end, -- NW Apollyon
        [1291] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.RED_CARD) and npcid == getEntranceOffset(0)                        ) end, -- SW Apollyon
        [1292] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.BLACK_CARD) and npcid == getEntranceOffset(1)                      ) end, -- NE Apollyon
        [1293] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.BLACK_CARD) and npcid == getEntranceOffset(1)                      ) end, -- SE Apollyon
        [1294] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and ((player:hasKeyItem(xi.ki.RED_CARD) and npcid == getEntranceOffset(0))
                                                                            or (player:hasKeyItem(xi.ki.BLACK_CARD) and npcid == getEntranceOffset(1)))                    ) end, -- CS Apollyon
        [1296] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and ((player:hasKeyItem(xi.ki.RED_CARD) and npcid == getEntranceOffset(0))
                                                                            or (player:hasKeyItem(xi.ki.BLACK_CARD) and npcid == getEntranceOffset(1)))                    ) end, -- Central Apollyon
        [1298] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.WHITE_CARD)                                                        ) end, -- Temenos Western Tower
        [1299] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.WHITE_CARD)                                                        ) end, -- Temenos Northern Tower
        [1300] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.WHITE_CARD)                                                        ) end, -- Temenos Eastern Tower
        [1301] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.WHITE_CARD)                                                        ) end, -- Central Temenos Basement
        [1303] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.WHITE_CARD)                                                        ) end, -- Central Temenos 1st Floor
        [1304] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.WHITE_CARD)                                                        ) end, -- Central Temenos 2nd Floor
        [1305] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.WHITE_CARD)                                                        ) end, -- Central Temenos 3rd Floor
        [1306] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.WHITE_CARD)                                                        ) end, -- Central Temenos 4th Floor
    }

    -- requirements to enter a battlefield already registered by a party member
    local enterReqs =
    {
        [ 641] = function() return ( player:hasKeyItem(xi.ki.ZEPHYR_FAN)                                                                                   ) end, -- ENM: Follow the White Rabbit
        [ 642] = function() return ( player:hasKeyItem(xi.ki.ZEPHYR_FAN)                                                                                   ) end, -- ENM: When Hell Freezes Over
        [ 643] = function() return ( player:hasKeyItem(xi.ki.ZEPHYR_FAN)                                                                                   ) end, -- ENM: Brothers
        [ 644] = function() return ( player:hasKeyItem(xi.ki.ZEPHYR_FAN)                                                                                   ) end, -- ENM: Holy Cow
        [ 673] = function() return ( player:hasKeyItem(xi.ki.MIASMA_FILTER)                                                                                ) end, -- ENM: Like the Wind
        [ 674] = function() return ( player:hasKeyItem(xi.ki.MIASMA_FILTER)                                                                                ) end, -- ENM: Sheep in Antlion's Clothing
        [ 675] = function() return ( player:hasKeyItem(xi.ki.MIASMA_FILTER)                                                                                ) end, -- ENM: Shell We Dance?
        [ 676] = function() return ( player:hasKeyItem(xi.ki.MIASMA_FILTER)                                                                                ) end, -- ENM: Totentanz
        [ 705] = function() return ( player:hasKeyItem(xi.ki.ASTRAL_COVENANT)                                                                              ) end, -- ENM: Test Your Mite
        [ 738] = function() return ( player:hasKeyItem(xi.ki.SHAFT_2716_OPERATING_LEVER)                                                                   ) end, -- ENM: Bionic Bug
        [ 739] = function() return ( player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL)                                                                    ) end, -- ENM: Pulling Your Strings
        [ 740] = function() return ( player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL)                                                                    ) end, -- ENM: Automaton Assault
        [ 769] = function() return ( player:hasKeyItem(xi.ki.CENSER_OF_ABANDONMENT)                                                                        ) end, -- ENM: Simulant
        [ 801] = function() return ( player:hasKeyItem(xi.ki.CENSER_OF_ANTIPATHY)                                                                          ) end, -- ENM: You Are What You Eat
        [ 833] = function() return ( player:hasKeyItem(xi.ki.CENSER_OF_ANIMUS)                                                                             ) end, -- ENM: Playing Host
        [ 865] = function() return ( player:hasKeyItem(xi.ki.CENSER_OF_ACRIMONY)                                                                           ) end, -- ENM: Pulling the Plug
        [ 897] = function() return ( player:hasKeyItem(xi.ki.WHISPER_OF_THE_WYRMKING)                                                                      ) end, -- Quest: The Wyrmking Descends
        [ 962] = function() return ( player:hasKeyItem(xi.ki.MONARCH_BEARD)                                                                                ) end, -- ENM: Fire in the Sky
        [ 963] = function() return ( player:hasKeyItem(xi.ki.MONARCH_BEARD)                                                                                ) end, -- ENM: Bad Seed
        [ 964] = function() return ( player:hasKeyItem(xi.ki.MONARCH_BEARD)                                                                                ) end, -- ENM: Bugard in the Clouds
        [ 965] = function() return ( player:hasKeyItem(xi.ki.MONARCH_BEARD)                                                                                ) end, -- ENM: Beloved of Atlantes
        [ 928] = function() return ( player:hasCompletedMission(xi.mission.log_id.COP, mi.cop.ANCIENT_VOWS) or (cop == mi.cop.ANCIENT_VOWS and copStat >= 2)                  ) end, -- Quest: Ouryu Cometh
        [1057] = function() return ( player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) or
                                   ( player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) == QUEST_ACCEPTED and
                                     player:getCharVar('ApocalypseNigh') == 4)                                                                              ) end, -- Quest: Apocalypse Nigh
        [1290] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.RED_CARD) and npcid == getEntranceOffset(0)        ) end, -- NW Apollyon
        [1291] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.RED_CARD) and npcid == getEntranceOffset(0)        ) end, -- SW Apollyon
        [1292] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.BLACK_CARD) and npcid == getEntranceOffset(1)      ) end, -- NE Apollyon
        [1293] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.BLACK_CARD) and npcid == getEntranceOffset(1)      ) end, -- SE Apollyon
        [1294] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and ((player:hasKeyItem(xi.ki.RED_CARD) and npcid == getEntranceOffset(0))
                                                                            or (player:hasKeyItem(xi.ki.BLACK_CARD) and npcid == getEntranceOffset(1)))    ) end, -- CS Apollyon
        [1296] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and ((player:hasKeyItem(xi.ki.RED_CARD) and npcid == getEntranceOffset(0))
                                                                            or (player:hasKeyItem(xi.ki.BLACK_CARD) and npcid == getEntranceOffset(1)))    ) end, -- Central Apollyon
        [1298] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.WHITE_CARD)                                        ) end, -- Temenos Western Tower
        [1299] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.WHITE_CARD)                                        ) end, -- Temenos Northern Tower
        [1300] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.WHITE_CARD)                                        ) end, -- Temenos Eastern Tower
        [1301] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.WHITE_CARD)                                        ) end, -- Central Temenos Basement
        [1303] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.WHITE_CARD)                                        ) end, -- Central Temenos 1st Floor
        [1304] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.WHITE_CARD)                                        ) end, -- Central Temenos 2nd Floor
        [1305] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.WHITE_CARD)                                        ) end, -- Central Temenos 3rd Floor
        [1306] = function() return ( player:hasKeyItem(xi.ki.COSMOCLEANSE) and player:hasKeyItem(xi.ki.WHITE_CARD)                                        ) end, -- Central Temenos 4th Floor
    }
    -- determine whether player meets battlefield requirements
    local req = (registrant == true) and registerReqs[bfid] or enterReqs[bfid]
    if not req then
        return true
    elseif req() then
        return true
    else
        return false
    end
end

-----------------------------------
-- check ability to skip a cutscene
-----------------------------------

function checkSkip(player, bfid)
    local mi        = xi.mission.id
    local nat       = player:getCurrentMission(player:getNation())
    local sandy     = player:getCurrentMission(SANDORIA)
    local basty     = player:getCurrentMission(BASTOK)
    local windy     = player:getCurrentMission(WINDURST)
    local roz       = player:getCurrentMission(ZILART)
    local cop       = player:getCurrentMission(COP)
    local toau      = player:getCurrentMission(TOAU)
    local asa       = player:getCurrentMission(ASA)
    local natStat   = player:getMissionStatus(player:getNation())
    local rozStat   = player:getMissionStatus(xi.mission.log_id.ZILART)
    local copStat   = player:getCharVar("PromathiaStatus")
    local toauStat  = player:getCharVar("AhtUrganStatus")
    local sofStat   = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE)
    local mission2_3a =
        player:hasCompletedMission(xi.mission.log_id.BASTOK, mi.bastok.THE_EMISSARY_SANDORIA2) or
        player:hasCompletedMission(xi.mission.log_id.WINDURST, mi.windurst.THE_THREE_KINGDOMS_SANDORIA2) or
        natStat > 9 and
        (
            basty == mi.bastok.THE_EMISSARY_SANDORIA2 or
            windy == mi.windurst.THE_THREE_KINGDOMS_SANDORIA2
        )
    local mission2_3b =
        player:hasCompletedMission(xi.mission.log_id.SANDORIA, mi.sandoria.JOURNEY_TO_BASTOK2) or
        player:hasCompletedMission(xi.mission.log_id.WINDURST, mi.windurst.THE_THREE_KINGDOMS_BASTOK2) or
        natStat > 10 and
        (
            sandy == mi.sandoria.JOURNEY_TO_BASTOK2 or
            windy == mi.windurst.THE_THREE_KINGDOMS_BASTOK2
        )
    local mission2_3c =
        player:hasCompletedMission(xi.mission.log_id.SANDORIA, mi.sandoria.JOURNEY_TO_WINDURST2) or
        player:hasCompletedMission(xi.mission.log_id.BASTOK, mi.bastok.THE_EMISSARY_WINDURST2) or
        natStat > 8 and
        (
            sandy == mi.sandoria.JOURNEY_TO_WINDURST2 or
            basty == mi.bastok.THE_EMISSARY_WINDURST2
        )

    -- requirements to skip a battlefield
    local skipReqs =
    {
        [   0] = function() return ( mission2_3a                                                                                                                                                     ) end, -- Mission 2-3
        [   3] = function() return ( player:hasCompletedMission(xi.mission.log_id.SANDORIA, mi.sandoria.THE_SECRET_WEAPON) or (sandy == mi.sandoria.THE_SECRET_WEAPON and player:getCharVar("SecretWeaponStatus") > 2) ) end, -- Sandy 7-2: The Secret Weapon
        [  32] = function() return ( player:hasCompletedMission(xi.mission.log_id.SANDORIA, mi.sandoria.SAVE_THE_CHILDREN) or (sandy == mi.sandoria.SAVE_THE_CHILDREN and natStat > 2)                                 ) end, -- Sandy 1-3: Save the Children
        [  33] = function() return ( player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST)                                                                       ) end, -- Quest: The Holy Crest
        [  64] = function() return ( mission2_3b                                                                                                                                                     ) end, -- Mission 2-3
        [  67] = function() return ( player:hasCompletedMission(xi.mission.log_id.BASTOK, mi.bastok.ON_MY_WAY) or (basty == mi.bastok.ON_MY_WAY and natStat > 2)                                                       ) end, -- Basty 7-2: On My Way
        [  96] = function() return ( mission2_3c                                                                                                                                                     ) end, -- Mission 2-3
        [  99] = function() return ( player:hasCompletedMission(xi.mission.log_id.WINDURST, mi.windurst.SAINTLY_INVITATION) or (windy == mi.windurst.SAINTLY_INVITATION and natStat > 1)                               ) end, -- Windy 6-2: A Saintly Invitation
        [ 160] = function() return ( player:hasCompletedMission(player:getNation(), mi.nation.SHADOW_LORD) or (nat == mi.nation.SHADOW_LORD and natStat > 3)                                         ) end, -- Mission 5-2
        [ 161] = function() return ( player:hasCompletedMission(xi.mission.log_id.BASTOK, mi.bastok.WHERE_TWO_PATHS_CONVERGE) or (basty == mi.bastok.WHERE_TWO_PATHS_CONVERGE and natStat > 4)                         ) end, -- Basty 9-2: Where Two Paths Converge
        [ 192] = function() return ( player:hasCompletedMission(xi.mission.log_id.ZILART, mi.zilart.THROUGH_THE_QUICKSAND_CAVES)                                                                                       ) end, -- ZM6: Through the Quicksand Caves
        [ 224] = function() return ( player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_MOONLIT_PATH) or player:hasKeyItem(xi.ki.WHISPER_OF_THE_MOON)                    ) end, -- Quest: The Moonlit Path
        [ 225] = function() return ( player:hasCompletedMission(xi.mission.log_id.WINDURST, mi.windurst.MOON_READING) or (windy == mi.windurst.MOON_READING and natStat > 4)                                           ) end, -- Windy 9-2: Moon Reading
        [ 256] = function() return ( player:hasCompletedMission(xi.mission.log_id.ZILART, mi.zilart.RETURN_TO_DELKFUTTS_TOWER)                                                                                         ) end, -- ZM8: Return to Delkfutt's Tower
        [ 288] = function() return ( player:hasCompletedMission(xi.mission.log_id.ZILART, mi.zilart.ARK_ANGELS)                                                                                                        ) end, -- ZM14: Ark Angels (Hume)
        [ 289] = function() return ( player:hasCompletedMission(xi.mission.log_id.ZILART, mi.zilart.ARK_ANGELS)                                                                                                        ) end, -- ZM14: Ark Angels (Tarutaru)
        [ 290] = function() return ( player:hasCompletedMission(xi.mission.log_id.ZILART, mi.zilart.ARK_ANGELS)                                                                                                        ) end, -- ZM14: Ark Angels (Mithra)
        [ 291] = function() return ( player:hasCompletedMission(xi.mission.log_id.ZILART, mi.zilart.ARK_ANGELS)                                                                                                        ) end, -- ZM14: Ark Angels (Elvaan)
        [ 292] = function() return ( player:hasCompletedMission(xi.mission.log_id.ZILART, mi.zilart.ARK_ANGELS)                                                                                                        ) end, -- ZM14: Ark Angels (Galka)
        [ 320] = function() return ( player:hasCompletedMission(xi.mission.log_id.ZILART, mi.zilart.THE_CELESTIAL_NEXUS)                                                                                               ) end, -- ZM16: The Celestial Nexus
        [ 416] = function() return ( player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WIND) or player:hasKeyItem(xi.ki.WHISPER_OF_GALES)                          ) end, -- Quest: Trial by Wind
        [ 448] = function() return ( player:hasCompletedQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.TRIAL_BY_LIGHTNING) or player:hasKeyItem(xi.ki.WHISPER_OF_STORMS)               ) end, -- Quest: Trial by Lightning
        [ 480] = function() return ( player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TRIAL_BY_ICE) or player:hasKeyItem(xi.ki.WHISPER_OF_FROST)                           ) end, -- Quest: Trial by Ice
        [ 512] = function() return ( player:hasCompletedMission(player:getNation(), mi.nation.ARCHLICH) or (nat == mi.nation.ARCHLICH and natStat > 11)                                              ) end, -- Mission 5-1
        [ 516] = function() return ( player:hasCompletedMission(xi.mission.log_id.SANDORIA, mi.sandoria.THE_HEIR_TO_THE_LIGHT) or (sandy == mi.sandoria.THE_HEIR_TO_THE_LIGHT and natStat > 4)                         ) end, -- Sandy 9-2: The Heir to the Light
        [ 544] = function() return ( player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_FIRE) or player:hasKeyItem(xi.ki.WHISPER_OF_FLAMES)                         ) end, -- Quest: Trial by Fire
        [ 576] = function() return ( player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRIAL_BY_EARTH) or player:hasKeyItem(xi.ki.WHISPER_OF_TREMORS)                           ) end, -- Quest: Trial by Earth
        [ 608] = function() return ( player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WATER) or player:hasKeyItem(xi.ki.WHISPER_OF_TIDES)                         ) end, -- Quest: Trial by Water
        [ 640] = function() return ( player:hasCompletedMission(xi.mission.log_id.COP, mi.cop.THREE_PATHS) or (cop == mi.cop.THREE_PATHS and player:getCharVar("COP_Ulmia_s_Path") > 6)                                ) end, -- PM5-3 U3: Flames for the Dead
        [ 672] = function() return ( player:hasCompletedMission(xi.mission.log_id.COP, mi.cop.THREE_PATHS) or (cop == mi.cop.THREE_PATHS and player:getCharVar("COP_Ulmia_s_Path") > 5)                                ) end, -- PM5-3 U2: Head Wind
        [ 704] = function() return ( player:hasCompletedMission(xi.mission.log_id.COP, mi.cop.DARKNESS_NAMED) or (cop == mi.cop.DARKNESS_NAMED and copStat > 2)                                                        ) end, -- PM3-5: Darkness Named
        [ 706] = function() return ( player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WAKING_DREAMS) or player:hasKeyItem(xi.ki.WHISPER_OF_DREAMS)                         ) end, -- Quest: Waking Dreams
        [ 736] = function() return ( player:hasCompletedMission(xi.mission.log_id.COP, mi.cop.THREE_PATHS) or (cop == mi.cop.THREE_PATHS and player:getCharVar("COP_Louverance_s_Path") > 5)                           ) end, -- PM5-3 L3: A Century of Hardship
        [ 768] = function() return ( player:hasCompletedMission(xi.mission.log_id.COP, mi.cop.THE_MOTHERCRYSTALS) or player:hasKeyItem(xi.ki.LIGHT_OF_HOLLA)                                                          ) end, -- PM1-3: The Mothercrystals
        [ 800] = function() return ( player:hasCompletedMission(xi.mission.log_id.COP, mi.cop.THE_MOTHERCRYSTALS) or player:hasKeyItem(xi.ki.LIGHT_OF_DEM)                                                            ) end, -- PM1-3: The Mothercrystals
        [ 832] = function() return ( player:hasCompletedMission(xi.mission.log_id.COP, mi.cop.THE_MOTHERCRYSTALS) or player:hasKeyItem(xi.ki.LIGHT_OF_MEA)                                                            ) end, -- PM1-3: The Mothercrystals
        [ 864] = function() return ( player:hasCompletedMission(xi.mission.log_id.COP, mi.cop.DESIRES_OF_EMPTINESS) or (cop == mi.cop.DESIRES_OF_EMPTINESS and copStat > 8)                                            ) end, -- PM5-2: Desires of Emptiness
        [ 896] = function() return ( sofStat == QUEST_COMPLETED or (sofStat == QUEST_ACCEPTED and player:getCharVar("StormsOfFate") > 2)                                                             ) end, -- Quest: Storms of Fate
        [ 960] = function() return ( player:hasCompletedMission(xi.mission.log_id.COP, mi.cop.ANCIENT_VOWS)                                                                                                            ) end, -- PM2-5: Ancient Vows
        [ 961] = function() return ( player:hasCompletedMission(xi.mission.log_id.COP, mi.cop.THE_SAVAGE) or (cop == mi.cop.THE_SAVAGE and copStat > 1)                                                                ) end, -- PM4-2: The Savage
        [ 992] = function() return ( player:hasCompletedMission(xi.mission.log_id.COP, mi.cop.ONE_TO_BE_FEARED)                                                                                                        ) end, -- PM6-4: One to be Feared
        [ 993] = function() return ( player:hasCompletedMission(xi.mission.log_id.COP, mi.cop.THE_WARRIOR_S_PATH)                                                                                                      ) end, -- PM7-5: The Warrior's Path
        [1024] = function() return ( player:hasCompletedMission(xi.mission.log_id.COP, mi.cop.WHEN_ANGELS_FALL) or (cop == mi.cop.WHEN_ANGELS_FALL and copStat > 4)                                                    ) end, -- PM8-3: When Angels Fall
        [1056] = function() return ( player:hasCompletedMission(xi.mission.log_id.COP, mi.cop.DAWN) or (cop == mi.cop.DAWN and copStat > 2)                                                                            ) end, -- PM8-4: Dawn
        [1057] = function() return ( player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH)                                                                            ) end, -- Apocalypse Nigh
    }

    -- determine whether player meets cutscene skip requirements
    local req = skipReqs[bfid]
    if not req then
        return false
    elseif req() then
        return true
    end
    return false
end

-----------------------------------
-- which battlefields are valid for registrant?
-----------------------------------

function findBattlefields(player, npc, itemId)
    local mask = 0
    local zbfs = battlefields[player:getZoneID()]
    if zbfs == nil then
        return 0
    end
    for k, v in pairs(zbfs) do
        if v[3] == itemId and checkReqs(player, npc, v[2], true) and not player:battlefieldAtCapacity(v[2]) then
            mask = bit.bor(mask, math.pow(2, v[1]))
        end
    end
    return mask
end

-----------------------------------
-- get battlefield id for a given zone and bit
-----------------------------------

function getBattlefieldIdByBit(player, bit)
    local zbfs = battlefields[player:getZoneID()]
    if not zbfs then
        return 0
    end
    for k, v in pairs(zbfs) do
        if v[1] == bit then
            return v[2]
        end
    end
    return 0
end

-----------------------------------
-- get battlefield bit for a given zone and id
-----------------------------------

function getBattlefieldMaskById(player, bfid)
    local zbfs = battlefields[player:getZoneID()]
    if zbfs then
        for k, v in pairs(zbfs) do
            if v[2] == bfid then
                return math.pow(2, v[1])
            end
        end
    end
    return 0
end

-----------------------------------
-- get battlefield bit for a given zone and id
-----------------------------------

function getItemById(player, bfid)
    local zbfs = battlefields[player:getZoneID()]
    if zbfs then
        for k, v in pairs(zbfs) do
            if v[2] == bfid then
                return v[3]
            end
        end
    end
    return 0
end

-----------------------------------
-- onTrade Action
-----------------------------------

function TradeBCNM(player, npc, trade, onUpdate)
    -- validate trade
    local itemId
    if not trade then
        return false
    elseif trade:getItemCount() == 3 and trade:hasItemQty(1907, 1) and trade:hasItemQty(1908, 1) and trade:hasItemQty(1986, 1) then
        itemId = -1
    elseif trade:getItemCount() == 4 and trade:hasItemQty(1909, 1) and trade:hasItemQty(1910, 1) and trade:hasItemQty(1987, 1) and trade:hasItemQty(1988, 1) then
        itemId = -2
    else
        itemId = trade:getItemId(0)
        if itemId == nil or itemId < 1 or itemId > 65535 or trade:getItemCount() ~= 1 or trade:getSlotQty(0) ~= 1 then
            return false
        elseif player:hasWornItem(itemId) then
            player:messageBasic(xi.msg.basic.ITEM_UNABLE_TO_USE_2, 0, 0) -- Unable to use item.
            return false
        end
    end

    -- validate battlefield status
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) and not onUpdate then
        player:messageBasic(xi.msg.basic.WAIT_LONGER, 0, 0) -- You must wait longer to perform that action.
        return false
    end

    -- open menu of valid battlefields
    local validBattlefields = findBattlefields(player, npc, itemId)
    if validBattlefields ~= 0 then
        if not onUpdate then
            player:startEvent(32000, 0, 0, 0, validBattlefields, 0, 0, 0, 0)
        end
        return true
    end

    return false
end

-----------------------------------
-- onTrigger Action
-----------------------------------

function EventTriggerBCNM(player, npc)
    -- player is in battlefield and clicks to leave
    if player:getBattlefield() then
        player:startEvent(32003)
        return true

    -- player wants to register a new battlefield
    elseif not player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        local mask = findBattlefields(player, npc, 0)

        -- GMs get access to all BCNMs
        if player:getGMLevel() > 0 then
            mask = 268435455
        end

        -- mask = 268435455 -- uncomment to open menu with all possible battlefields
        if mask ~= 0 then
            player:startEvent(32000, 0, 0, 0, mask, 0, 0, 0, 0)
            return true
        end

    -- player is allied with a registrant and wants to enter their instance
    else
        local stat = player:getStatusEffect(xi.effect.BATTLEFIELD)
        local bfid = stat:getPower()
        local mask = getBattlefieldMaskById(player, bfid)
        if mask ~= 0 and checkReqs(player, npc, bfid, false) then
            player:startEvent(32000, 0, 0, 0, mask, 0, 0, 0, 0)
            return true
        end

    end

    return false
end

-----------------------------------
-- onEventUpdate
-----------------------------------

function EventUpdateBCNM(player, csid, option, extras)
    -- player:PrintToPlayer(string.format("EventUpdateBCNM csid=%i option=%i extras=%i", csid, option, extras))

    -- requesting a battlefield
    if csid == 32000 then
        if option == 0 then
            -- todo: check if battlefields full, check party member requiremenst
            return 0
        elseif option == 255 then
            -- todo: check if battlefields full, check party member requirements
            return 0
        end
        local area = player:getLocalVar("[battlefield]area")
        area = area + 1
        local battlefieldIndex = bit.rshift(option, 4)
        local battlefieldId = getBattlefieldIdByBit(player, battlefieldIndex)
        local effect = player:getStatusEffect(xi.effect.BATTLEFIELD)
        local id = battlefieldId or player:getBattlefieldID()
        local skip = checkSkip(player, id)

        local clearTime = 1
        local name = "Meme"
        local partySize = 1
        switch (battlefieldId): caseof
        {
            [1290] = function() area = 2 end, -- NW_Apollyon
            [1291] = function() area = 1 end, -- SW_Apollyon
            [1292] = function() area = 4 end, -- NE_Apollyon
            [1293] = function() area = 3 end, -- SE_Apollyon
            [1294] = function() area = 6 end, -- CS_Apollyon
            [1296] = function() area = 5 end, -- Central_Apollyon
            [1298] = function() area = 3 end, -- Temenos_Western_Tower
            [1299] = function() area = 1 end, -- Temenos_Northern_Tower
            [1300] = function() area = 2 end, -- Temenos_Eastern_Tower
            [1301] = function() area = 8 end, -- Central_Temenos_Basement
            [1303] = function() area = 7 end, -- Central_Temenos_1st_Floor
            [1304] = function() area = 6 end, -- Central_Temenos_2nd_Floor
            [1305] = function() area = 5 end, -- Central_Temenos_3rd_Floor
            [1306] = function() area = 4 end, -- Central_Temenos_4th_Floor
        }
        local result = xi.battlefield.returnCode.REQS_NOT_MET
        result = player:registerBattlefield(id, area)
        local status = xi.battlefield.status.OPEN
        if result ~= xi.battlefield.returnCode.CUTSCENE then
            if result == xi.battlefield.returnCode.INCREMENT_REQUEST then
                if area < 3 then
                    player:setLocalVar("[battlefield]area", area)
                else
                    result = xi.battlefield.returnCode.WAIT
                    player:updateEvent(result)
                end
            end
            return false
        else
            if not player:getBattlefield() then
                player:enterBattlefield()
            end
            local initiatorId = 0
            local initiatorName = ""

            local battlefield = player:getBattlefield()
            if battlefield then
                battlefield:setLocalVar("[cs]bit", battlefieldIndex)
                name, clearTime, partySize = battlefield:getRecord()
                initiatorId, initiatorName = battlefield:getInitiator()
            end

            -- register party members
            if initiatorId == player:getID() then
                local effect = player:getStatusEffect(xi.effect.BATTLEFIELD)
                local zone = player:getZoneID()
                local item = getItemById(player, effect:getPower())

                if item ~= 0 then
                    -- remove limbus chips
                    if zone == 37 or zone == 38 then
                        player:tradeComplete()

                    -- set other traded item to worn
                    elseif player:hasItem(item) and player:getName() == initiatorName then
                        player:createWornItem(item)
                    end
                end

                local alliance = player:getAlliance()
                for _, member in pairs(alliance) do
                    if member:getZoneID() == zone and not member:hasStatusEffect(xi.effect.BATTLEFIELD) and not member:getBattlefield() then
                        member:addStatusEffect(effect)
                        member:registerBattlefield(id, area, player:getID())
                    end
                end
            end
        end
        player:updateEvent(result, battlefieldIndex, 0, clearTime, partySize, skip)
        player:updateEventString(name)
        return status < xi.battlefield.status.LOCKED and result < xi.battlefield.returnCode.LOCKED

    -- leaving a battlefield
    elseif csid == 32003 and option == 2 then
        player:updateEvent(3)
        return true
    elseif csid == 32003 and option == 3 then
        player:updateEvent(0)
        return true
    end

    return false
end

-----------------------------------
-- onEventFinish Action
-----------------------------------

function EventFinishBCNM(player, csid, option)
    -- player:PrintToPlayer(string.format("EventFinishBCNM csid=%i option=%i", csid, option))
    player:setLocalVar("[battlefield]area", 0)
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        if csid == 32003 and option == 4 then
            if player:getBattlefield() then
                player:leaveBattlefield(1)
            end
        end
        return true
    end
    return false
end
