-----------------------------------
-- BCNM Functions
-----------------------------------
require('scripts/globals/battlefield')
require('scripts/globals/missions')
require('scripts/globals/quests')
-----------------------------------
xi = xi or {}
xi.bcnm = xi.bcnm or {}

-- battlefields by zone
-- captured from client 2020-10-24
local battlefields =
{
--[[
    [zoneId] =
    {
        { bit, battlefieldIdInDatabase, requiredItemToTrade }
    },
--]]
    [xi.zone.BEARCLAW_PINNACLE] =
    {
        { 0,  640,    0 },   -- Flames of the Dead (PM5-3 U3)
    --  { 1,  641,    0 },   -- Follow the White Rabbit (ENM)
    --  { 2,  642,    0 },   -- When Hell Freezes Over (ENM)
    --  { 3,  643,    0 },   -- Brothers (ENM) -- TODO: Chthonian Ray mobskill
        { 4,  644,    0 },   -- Holy Cow (ENM)
    --  { 5,    ?, 3454 },   -- Taurassic Park (HKC30)
    },

    [xi.zone.BONEYARD_GULLY] =
    {
        { 0,  672,    0 },   -- Head Wind (PM5-3 U2)
    --  { 1,  673,    0 },   -- Like the Wind (ENM) -- TODO: mob constantly runs during battle
        { 2,  674,    0 },   -- Sheep in Antlion's Clothing (ENM)
    --  { 3,  675,    0 },   -- Shell We Dance? (ENM) -- TODO: Needs testing, cleanup, and mixin work
    --  { 4,  676,    0 },   -- Totentanz (ENM)
    --  { 5,  677,    0 },   -- Tango with a Tracker (Quest)
    --  { 6,  678,    0 },   -- Requiem of Sin (Quest)
    --  { 7,  679, 3454 },   -- Antagonistic Ambuscade (HKC30)
    --  { 8,    ?,    0 },   -- *Head Wind (HTMBF)
    },

    [xi.zone.THE_SHROUDED_MAW] =
    {
        { 0,  704,    0 },   -- Darkness Named (PM3-5)
    --  { 1,  705,    0 },   -- Test Your Mite (ENM)
        { 2,  706,    0 },   -- Waking Dreams (Quest)
    --  { 3,    ?,    0 },   -- *Waking Dreams (HTMBF)
    },

    [xi.zone.MINE_SHAFT_2716] =
    {
        { 0,  736,    0 },   -- A Century of Hardship (PM5-3 L3)
    --  { 1,  737,    0 },   -- Return to the Depths (Quest)
    --  { 2,  738,    0 },   -- Bionic Bug (ENM)
    --  { 3,  739,    0 },   -- Pulling the Strings (ENM)
    --  { 4,  740,    0 },   -- Automaton Assault (ENM)
    --  { 5,  741, 3455 },   -- The Mobline Comedy (HKC50)
    },

    [xi.zone.SPIRE_OF_HOLLA] =
    {
        { 0,  768,    0 },   -- Ancient Flames Beckon (PM1-3)
    --  { 1,  769,    0 },   -- Simulant (ENM)
    --  { 2,  770, 3351 },   -- Empty Hopes (KC30)
    },

    [xi.zone.SPIRE_OF_DEM] =
    {
        { 0,  800,    0 },   -- Ancient Flames Beckon (PM1-3)
    --  { 1,  801,    0 },   -- You Are What You Eat (ENM)
    --  { 2,  802, 3351 },   -- Empty Dreams (KC30)
    },

    [xi.zone.SPIRE_OF_MEA] =
    {
        { 0,  832,    0 },   -- Ancient Flames Beckon (PM1-3)
    --  { 1,  833,    0 },   -- Playing Host (ENM)
    --  { 2,  834, 3351 },   -- Empty Desires (KC30)
    },

    [xi.zone.SPIRE_OF_VAHZL] =
    {
        { 0,  864,    0 },   -- Desires of Emptiness (PM5-2)
    --  { 1,  865,    0 },   -- Pulling the Plug (ENM)
    --  { 2,  866, 3352 },   -- Empty Aspirations (KC50)
    },

    [xi.zone.RIVERNE_SITE_B01] =
    {
        { 0,  896,    0 },   -- Storms of Fate (Quest)
    --  { 1,  897, 2108 },   -- The Wyrmking Descends (BCNM)
    },

    [xi.zone.RIVERNE_SITE_A01] =
    {
    --  { 0,  928, 1842 },   -- Ouryu Cometh (BCNM)
    },

    [xi.zone.MONARCH_LINN] =
    {
        { 0,  960,    0 },   -- Ancient Vows (PM2-5)
        { 1,  961,    0 },   -- The Savage (PM4-2)
    --  { 2,  962,    0 },   -- Fire in the Sky (ENM)
    --  { 3,  963,    0 },   -- Bad Seed (ENM)
    --  { 4,  964,    0 },   -- Bugard in the Clouds (ENM)
    --  { 5,  965,    0 },   -- Beloved of the Atlantes (ENM)
    --  { 6,  966,    0 },   -- Uninvited Guests (Quest)
    --  { 7,  967, 3455 },   -- Nest of Nightmares (HKC50)
    --  { 8,    ?,    0 },   -- *The Savage (HTMBF)
    },

    [xi.zone.SEALIONS_DEN] =
    {
        { 0,  992,    0 },   -- One to Be Feared (PM6-4)
        { 1,  993,    0 },   -- The Warrior's Path (PM7-5)
    --  { 2,    ?,    0 },   -- *The Warrior's Path (HTMBF)
    --  { 3,    ?,    0 },   -- *One to Be Feared (HTMBF)
    },

    [xi.zone.THE_GARDEN_OF_RUHMET] =
    {
        { 0, 1024,    0 },   -- When Angels Fall (PM8-3)
    },

    [xi.zone.EMPYREAL_PARADOX] =
    {
        { 0, 1056,    0 },   -- Dawn (PM8-4)
        { 1, 1057,    0 },   -- Apocalypse Nigh (Quest)
    --  { 2,    ?,    0 },   -- Both Paths Taken (ROVM2-9-2)
    --  { 3,    ?,    0 },   -- *Dawn (HTMBF)
    --  { 4,    ?,    0 },   -- The Winds of Time (ROVM3-1-26)
    --  { 5,    ?,    0 },   -- Sealed Fate (Master Trial)
    },

    [xi.zone.TEMENOS] =
    {
    --  { 0, 1299,    0 },   -- Northern Tower
    --  { 1, 1300,    0 },   -- Eastern Tower
    --  { 2, 1298,    0 },   -- Western Tower
    --  { 3, 1306,   -1 },   -- Central 4th Floor (multiple items needed: 1907, 1908, 1986)
    --  { 4, 1305, 1904 },   -- Central 3rd Floor
    --  { 5, 1304, 1905 },   -- Central 2nd Floor
    --  { 6, 1303, 1906 },   -- Central 1st Floor
    --  { 7, 1301, 2127 },   -- Central Basement
    --  { 8, 1302,    0 },   -- Central Basement II
    --  { 9, 1307,    0 },   -- Central 4th Floor II
    },

    [xi.zone.ARRAPAGO_REEF] =
    {
    --  { 0,    ?,    0 },   -- Lamia Reprisal
    },

    [xi.zone.TALACCA_COVE] =
    {
    --  { 0, 1088,    0 },   -- Call to Arms (ISNM)
    --  { 1, 1089,    0 },   -- Compliments to the Chef (ISNM)
    --  { 2, 1090,    0 },   -- Puppetmaster Blues (Quest)
        { 3, 1091, 2332 },   -- Breaking the Bonds of Fate (COR LB5)
        { 4, 1092,    0 },   -- Legacy of the Lost (TOAU35)
    --  { 5,    ?,    0 },   -- *Legacy of the Lost (HTMBF)
    },

    [xi.zone.HALVUNG] =
    {
    --  { 0,    ?,    0 },   -- Halvung Invasion
    },

    [xi.zone.NAVUKGO_EXECUTION_CHAMBER] =
    {
    --  { 0, 1120,    0 },   -- Tough Nut to Crack (ISNM)
    --  { 1, 1121,    0 },   -- Happy Caster (ISNM)
        { 2, 1122,    0 },   -- Omens (BLU AF2)
        { 3, 1123, 2333 },   -- Achieving True Power (PUP LB5)
        { 4, 1124,    0 },   -- Shield of Diplomacy (TOAU22)
    },

    [xi.zone.MAMOOK] =
    {
    --  { 0,    ?,    0 },   -- Mamook Incursion
    },

    [xi.zone.JADE_SEPULCHER] =
    {
    --  { 0, 1152,    0 },   -- Making a Mockery (ISNM)
    --  { 1, 1153,    0 },   -- Shadows of the Mind (ISNM)
        { 2, 1154, 2331 },   -- The Beast Within (BLU LB5)
    --  { 3, 1155,    0 },   -- Moment of Truth (Quest)
        { 4, 1156,    0 },   -- Puppet in Peril (TOAU29)
    --  { 5,    ?,    0 },   -- *Puppet in Peril (HTMBF)
    },

    [xi.zone.HAZHALM_TESTING_GROUNDS] =
    {
    --  { 0, 1184,    0 },   -- The Rider Cometh (Quest)
    },

    [xi.zone.LA_VAULE_S] =
    {
    --  { 0,    ?,    0 },   -- Splitting Heirs (S)
        { 1, 2721,    0 },   -- Purple, The New Black
    --  { 2,    ?,    0 },   -- The Blood-bathed Crown
    },

    [xi.zone.BEADEAUX_S] =
    {
    --  { 0,    ?,    0 },   -- Cracking Shells (B)
    --  { 1,    ?,    0 },   -- The Buried God
    },

    [xi.zone.CASTLE_OZTROJA_S] =
    {
    --  { 0,    ?,    0 },   -- Plucking Wings (W)
    --  { 1,    ?,    0 },   -- A Malicious Manifest
    --  { 2,    ?,    0 },   -- Manifest Destiny
    --  { 3,    ?,    0 },   -- At Journey's End
    },

    [xi.zone.HORLAIS_PEAK] =
    {
        {  0,    0,    0 },   -- The Rank 2 Final Mission (Mission 2-3)
        {  1,    1, 1131 },   -- Tails of Woe (BS40)
        {  2,    2, 1130 },   -- Dismemberment Brigade (BS60)
        {  3,    3,    0 },   -- The Secret Weapon (San d'Oria 7-2)
        {  4,    4, 1177 },   -- Hostile Herbivores (BS50)
        {  5,    5, 1426 },   -- Shattering Stars (WAR LB5)
        {  6,    6, 1429 },   -- Shattering Stars (BLM LB5)
        {  7,    7, 1436 },   -- Shattering Stars (RNG LB5)
        {  8,    8, 1552 },   -- Carapace Combatants (BS30)
    --  {  9,    9, 1551 },   -- Shooting Fish (BS20) -- TODO: mobs use ranged attacks with knockback
        { 10,   10, 1552 },   -- Dropping Like Flies (BS30)
    --  { 11,   11, 1553 },   -- Horns of War (KS99) -- TODO: Chlevnik is unscripted
        { 12,   12, 1131 },   -- Under Observation (BS40)
        { 13,   13, 1177 },   -- Eye of the Tiger (BS50) -- TODO: Crossthrash mobskill
    --  { 14,   14, 1130 },   -- Shots in the Dark (BS60) -- TODO: Warmachine combat behavior
        { 15,   15, 1175 },   -- Double Dragonian (KS30) -- TODO: Chaos Blade strengthens after 2hr
    --  { 16,   16, 1178 },   -- Today's Horoscope (KS30)
        { 17,   17, 1180 },   -- Contaminated Colosseum (KS30)
    --  { 18,   18, 3351 },   -- Kindergarten Cap (KC30)
    --  { 19,   19, 3352 },   -- Last Orc-Shunned Hero (KC50)
        { 20,   20,    0 },   -- Beyond Infinity (Quest)
    --  { 21,    ?, 4062 },   -- *Tails of Woe (SKC10)
    --  { 22,    ?, 4063 },   -- *Dismemberment Brigade (SKC20)
    --  { 23,    ?,    0 },   -- A Feast Most Dire (Quest)
    --  { 24,    ?,    0 },   -- A.M.A.N. Trove (Mars)
    --  { 25,    ?,    0 },   -- A.M.A.N. Trove (Venus)
    --  { 26,    ?,    0 },   -- Inv. from Excenmille
    --  { 27,    ?,    0 },   -- Inv. from Excenmille and Co.
    },

    [xi.zone.GHELSBA_OUTPOST] =
    {
        { 0,   32,    0 },   -- Save the Children (San d'Oria 1-3)
        { 1,   33,    0 },   -- The Holy Crest (Quest)
        { 2,   34, 1551 },   -- Wings of Fury (BS20) -- TODO: mobskills Slipstream and Turbulence
        { 3,   35, 1552 },   -- Petrifying Pair (BS30)
        { 4,   36, 1552 },   -- Toadal Recall (BS30) -- TODO: shroom-in-cap mechanic
    --  { 5,   37,    0 },   -- Mirror, Mirror (Quest)
    },

    [xi.zone.WAUGHROON_SHRINE] =
    {
        {  0,   64,    0 },   -- The Rank 2 Final Mission (Mission 2-3)
        {  1,   65, 1131 },   -- The Worm's Turn (BS40)
        {  2,   66, 1130 },   -- Grimshell Shocktroopers (BS60)
        {  3,   67,    0 },   -- On My Way (Bastok 7-2)
        {  4,   68, 1166 },   -- A Thief in Norg!? (Quest)
        {  5,   69, 1177 },   -- 3, 2, 1... (BS50) -- TODO: Self Destruct does not display correct message in chat log
        {  6,   70, 1430 },   -- Shattering Stars (RDM LB5)
        {  7,   71, 1431 },   -- Shattering Stars (THF LB5)
        {  8,   72, 1434 },   -- Shattering Stars (BST LB5)
        {  9,   73, 1552 },   -- Birds of a Feather (BS30)
    --  { 10,   74, 1551 },   -- Crustacean Conundrum (BS20) -- TODO: You can only do 0-2 damage no matter what your attack is
        { 11,   75, 1552 },   -- Grove Guardians (BS30)
    --  { 12,   76, 1553 },   -- The Hills are Alive (KS99) -- TODO: Tartaruga Gigante is not coded
        { 13,   77, 1131 },   -- Royal Jelly (BS40)
    --  { 14,   78, 1177 },   -- The Final Bout (BS50) -- TODO: mobskills Big Blow and Counterstance
        { 15,   79, 1130 },   -- Up in Arms (BS60)
    --  { 16,   80, 1175 },   -- Copycat (KS30)
    --  { 17,   81, 1178 },   -- Operation Desert Swarm (KS30) -- TODO: Wild Rage gets stronger as they die. Build sleep resistance. Testing.
    --  { 18,   82, 1180 },   -- Prehistoric Pigeons (KS30) -- TODO: Build resistance to sleep quickly. When one dies, remaining ones become more powerful.
    --  { 19,   83, 3351 },   -- The Palborough Project (KC30)
    --  { 20,   84, 3352 },   -- Shell Shocked (KC50)
        { 21,   85,    0 },   -- Beyond Infinity (Quest)
    --  { 22,    ?, 4062 },   -- *The Worm's Tail (SKC10)
    --  { 23,    ?, 4063 },   -- *Grimshell Shocktroopers (SKC20)
    --  { 24,    ?,    0 },   -- A Feast Most Dire (Quest)
    --  { 25,    ?,    0 },   -- A.M.A.N. Trove (Mars)
    --  { 26,    ?,    0 },   -- A.M.A.N. Trove (Venus)
    --  { 27,    ?,    0 },   -- Invitation from Naji
    --  { 28,    ?,    0 },   -- Invitation from Naji and Co.
    },

    [xi.zone.BALGAS_DAIS] =
    {
        {  0,   96,    0 },   -- The Rank 2 Final Mission (Mission 2-3)
        {  1,   97, 1131 },   -- Steamed Sprouts (BS40)
        {  2,   98, 1130 },   -- Divine Punishers (BS60)
        {  3,   99,    0 },   -- Saintly Invitation (Windurst 6-2)
        {  4,  100, 1177 },   -- Treasure and Tribulations (BS50)
        {  5,  101, 1427 },   -- Shattering Stars (MNK LB5)
        {  6,  102, 1428 },   -- Shattering Stars (WHM LB5)
        {  7,  103, 1440 },   -- Shattering Stars (SMN LB5)
        {  8,  104, 1552 },   -- Creeping Doom (BS30)
        {  9,  105, 1551 },   -- Charming Trio (BS20)
        { 10,  106, 1552 },   -- Harem Scarem (BS30)
    --  { 11,  107, 1553 },   -- Early Bird Catches the Wyrm (KS99)
        { 12,  108, 1131 },   -- Royal Succession (BS40)
        { 13,  109, 1177 },   -- Rapid Raptors (BS50)
        { 14,  110, 1130 },   -- Wild Wild Whiskers (BS60) -- TODO: should use petrifactive breath more often than other mobskill. Message before spellcasting.
    --  { 15,  111, 1175 },   -- Seasons Greetings (KS30)
    --  { 16,  112, 1178 },   -- Royale Ramble (KS30)
    --  { 17,  113, 1180 },   -- Moa Constrictors (KS30)
    --  { 18,  114, 3351 },   -- The V Formation (KC30)
    --  { 19,  115, 3352 },   -- Avian Apostates (KC50)
        { 20,  116,    0 },   -- Beyond Infinity (Quest)
    --  { 21,    ?, 4062 },   -- *Steamed Sprouts (SKC10)
    --  { 22,    ?, 4063 },   -- *Divine Punishers (SKC20)
    --  { 23,    ?,    0 },   -- A Feast Most Dire (Quest)
    --  { 24,    ?,    0 },   -- A.M.A.N. Trove (Mars)
    --  { 25,    ?,    0 },   -- A.M.A.N. Trove (Venus)
    --  { 26,    ?,    0 },   -- Inv. from Kupipi
    --  { 27,    ?,    0 },   -- Inv. from Kupipi and Co.
    },

    [xi.zone.THRONE_ROOM_S] =
    {
    --  { 0,  352,    0 },   -- Fiat Lux (Campaign)
    --  { 1,  353,    0 },   -- Darkness Descends (WOTG37)
    --  { 2,  354,    0 },   -- Bonds of Mythril (Quest)
    --  { 3,    ?,    0 },   -- Unafraid of the Dark (Merit Battlefield)
    },

    [xi.zone.SACRIFICIAL_CHAMBER] =
    {
        { 0,  128,    0 },   -- The Temple of Uggalepih (ZM4)
        { 1,  129, 1130 },   -- Jungle Boogymen (BS60)
        { 2,  130, 1130 },   -- Amphibian Assault (BS60)
    --  { 3,  131,    0 },   -- Project: Shantottofication (ASA13)
    --  { 4,  132, 3352 },   -- Whom Wilt Thou Call (KC50)
    --  { 5,    ?, 4063 },   -- *Jungle Boogymen (SKC20)
    --  { 6,    ?, 4063 },   -- *Amphibian Assault (SKC20)
    },

    [xi.zone.THRONE_ROOM] =
    {
        { 0,  160,    0 },   -- The Shadow Lord Battle (Mission 5-2)
        { 1,  161,    0 },   -- Where Two Paths Converge (Bastok 9-2)
    --  { 2,  162, 1130 },   -- Kindred Spirits (BS60)
        { 3,  163, 2557 },   -- Survival of the Wisest (SCH LB5)
    --  { 4,  164,    0 },   -- Smash! A Malevolent Menace (MKD14)
    --  { 5,    ?, 4063 },   -- *Kindred Spirits (SKC20)
    --  { 6,    ?,    0 },   -- *The Shadowlord Battle (HTMBF)
    --  { 7,    ?,    0 },   -- True Love
    --  { 8,    ?,    0 },   -- A Fond Farewell
    },

    [xi.zone.CHAMBER_OF_ORACLES] =
    {
        {  0,  192,    0 },   -- Through the Quicksand Caves (ZM6)
        {  1,  193, 1130 },   -- Legion XI Comitatensis (BS60)
        {  2,  194, 1437 },   -- Shattering Stars (SAM LB5)
        {  3,  195, 1438 },   -- Shattering Stars (NIN LB5)
        {  4,  196, 1439 },   -- Shattering Stars (DRG LB5)
    --  {  5,  197, 1175 },   -- Cactuar Suave (KS30)
        {  6,  198, 1178 },   -- Eye of the Storm (KS30)
    --  {  7,  199, 1180 },   -- The Scarlet King (KS30)
    --  {  8,  200,    0 },   -- Roar! A Cat Burglar Bares Her Fangs (MKD10)
    --  {  9,  201, 3352 },   -- Dragon Scales (KC50)
    --  { 10,    ?, 4063 },   -- *Legion XI Comitatensis (SKC20)
    },

    [xi.zone.FULL_MOON_FOUNTAIN] =
    {
        { 0,  224,    0 },   -- The Moonlit Path (Quest)
        { 1,  225,    0 },   -- Moon Reading (Windurst 9-2)
    --  { 2,  226,    0 },   -- Waking the Beast (Quest)
    --  { 3,  227,    0 },   -- Battaru Royale (ASA10)
    --  { 4,    ?,    0 },   -- *The Moonlit Path (HTMBF)
    --  { 5,    ?,    0 },   -- *Waking the Beast (HTMBF)
    },

    [xi.zone.STELLAR_FULCRUM] =
    {
        { 0,  256,    0 },   -- Return to Delkfutt's Tower (ZM8)
    --  { 1,  257,    0 },   -- The Indomitable Triumvirate (Mog Bonanza)
    --  { 2,  258,    0 },   -- The Dauntless Duo (Mog Bonanza)
    --  { 3,  259,    0 },   -- The Solitary Demolisher (Mog Bonanza)
    --  { 4,  260,    0 },   -- Heroine's Combat (Mog Bonanza)
    --  { 5,  261,    0 },   -- Mercenary Camp (Mog Bonanza)
    --  { 6,  262,    0 },   -- Ode of Life Bestowing (ACP11)
    --  { 7,    ?,    0 },   -- *Return to Delkfutt's Tower (HTMBF)
    --  { 8,    ?,    0 },   -- True Love
    --  { 9,    ?,    0 },   -- A Fond Farewell
    },

    [xi.zone.LALOFF_AMPHITHEATER] =
    {
        {  0,  288,    0 },   -- Ark Angels 1 (ZM14)
        {  1,  289,    0 },   -- Ark Angels 2 (ZM14)
        {  2,  290,    0 },   -- Ark Angels 3 (ZM14)
        {  3,  291,    0 },   -- Ark Angels 4 (ZM14)
        {  4,  292,    0 },   -- Ark Angels 5 (ZM14)
        {  5,  293, 1550 },   -- Divine Might (ZM14)
    --  {  6,    ?,    0 },   -- *Ark Angels 1 (HTMBF)
    --  {  7,    ?,    0 },   -- *Ark Angels 2 (HTMBF)
    --  {  8,    ?,    0 },   -- *Ark Angels 3 (HTMBF)
    --  {  9,    ?,    0 },   -- *Ark Angels 4 (HTMBF)
    --  { 10,    ?,    0 },   -- *Ark Angels 5 (HTMBF)
    --  { 11,    ?,    0 },   -- *Divine Might (HTMBF)
    },

    [xi.zone.THE_CELESTIAL_NEXUS] =
    {
        { 0,  320,    0 },   -- The Celestial Nexus (ZM16)
    --  { 1,    ?,    0 },   -- *The Celestial Nexus (HTMBF)
    },

    [xi.zone.WALK_OF_ECHOES] =
    {
    --  { 0,    ?,    0 },   -- When Wills Collide (WOTG46)
    --  { 1,  385,    0 },   -- Maiden of the Dusk (WOTG51)
    --  { 2,    ?,    0 },   -- Champion of the Dawn (Quest)
    --  { 3,    ?,    0 },   -- A Forbidden Reunion (Quest)
    },

    [xi.zone.CLOISTER_OF_GALES] =
    {
        { 0,  416,    0 },   -- Trial by Wind (Quest)
        { 1,  417, 1174 },   -- Carbuncle Debacle (Quest)
        { 2,  418, 1546 },   -- Trial-size Trial by Wind (Quest)
    --  { 3,  419,    0 },   -- Waking the Beast (Quest)
        { 4,  420,    0 },   -- Sugar-coated Directive (ASA4)
    --  { 5,    ?,    0 },   -- *Trial by Wind (HTMBF)
    },

    [xi.zone.CLOISTER_OF_STORMS] =
    {
        { 0,  448,    0 },   -- Trial by Lightning (Quest)
        { 1,  449, 1172 },   -- Carbuncle Debacle (Quest)
        { 2,  450, 1548 },   -- Trial-size Trial by Lightning (Quest)
    --  { 3,  451,    0 },   -- Waking the Beast (Quest)
        { 4,  452,    0 },   -- Sugar-coated Directive (ASA4)
    --  { 5,    ?,    0 },   -- *Trial by Lightning (HTMBF)
    },

    [xi.zone.CLOISTER_OF_FROST] =
    {
        { 0,  480,    0 },   -- Trial by Ice (Quest)
        { 1,  481, 1171 },   -- Class Reunion (Quest)
        { 2,  482, 1545 },   -- Trial-size Trial by Ice (Quest)
    --  { 3,  483,    0 },   -- Waking the Beast (Quest)
        { 4,  484,    0 },   -- Sugar-coated Directive (ASA4)
    --  { 5,    ?,    0 },   -- *Trial by Ice (HTMBF)
    },

    [xi.zone.QUBIA_ARENA] =
    {
        {  0,  512,    0 },   -- The Rank 5 Mission (Mission 5-1)
    --  {  1,  513, 1175 },   -- Come Into My Parlor (KS30)
    --  {  2,  514, 1178 },   -- E-vase-ive Action (KS30)
    --  {  3,  515, 1180 },   -- Infernal Swarm (KS30)
        {  4,  516,    0 },   -- The Heir to the Light (San d'Oria 9-2)
        {  5,  517, 1432 },   -- Shattering Stars (PLD LB5)
        {  6,  518, 1433 },   -- Shattering Stars (DRK LB5)
        {  7,  519, 1435 },   -- Shattering Stars (BRD LB5)
        {  8,  520, 1130 },   -- Demolition Squad (BS60)
    --  {  9,  521, 1552 },   -- Die by the Sword (BS30) -- TODO: mob damage type rotation mobskills furious flurry, smite of fury, whispers of ire
        { 10,  522, 1552 },   -- Let Sleeping Dogs Die (BS30)
        { 11,  523, 1130 },   -- Brothers D'Aurphe (BS60)
        { 12,  524, 1131 },   -- Undying Promise (BS40) -- TODO: model size increases with each reraise
        { 13,  525, 1131 },   -- Factory Rejects (BS40) -- TODO: dolls grow size/power based on hidden timer. (wikis disagree on TP moves? factory immune? factory model?)
        { 14,  526, 1177 },   -- Idol Thoughts (BS50)
        { 15,  527, 1177 },   -- An Awful Autopsy (BS50) -- TODO: mobskill Infernal Pestilence
    --  { 16,  528, 1130 },   -- Celery (BS60) -- TODO: mobs do not have their specific weaknesses. mobskill Bane.
    --  { 17,  529,    0 },   -- Mirror Images (Quest)
        { 18,  530, 2556 },   -- A Furious Finale (DNC LB5)
    --  { 19,  531,    0 },   -- Clash of the Comrades (Quest)
    --  { 20,  532,    0 },   -- Those Who Lurk in Shadows (ACP7)
        { 21,  533,    0 },   -- Beyond Infinity (Quest)
    --  { 22,    ?, 4062 },   -- *Factory Rejects (SKC10)
    --  { 23,    ?, 4063 },   -- *Demolition Squad (SKC20)
    --  { 24,    ?, 4063 },   -- *Brothers D'Aurphe (SKC20)
    --  { 25,    ?,    0 },   -- Mumor's Encore (Sunbreeze Festival)
    },

    [xi.zone.CLOISTER_OF_FLAMES] =
    {
        { 0,  544,    0 },   -- Trial by Fire (Quest)
        { 1,  545, 1544 },   -- Trial-size Trial by Fire (Quest)
    --  { 2,  546,    0 },   -- Waking the Beast (Quest)
        { 3,  547,    0 },   -- Sugar-coated Directive (ASA4)
    --  { 4,    ?,    0 },   -- *Trial by Fire (HTMBF)
    },

    [xi.zone.CLOISTER_OF_TREMORS] =
    {
        { 0,  576,    0 },   -- Trial by Earth (Quest)
        { 1,  577, 1169 },   -- The Puppet Master (Quest)
        { 2,  578, 1547 },   -- Trial-size Trial by Earth (Quest)
    --  { 3,  579,    0 },   -- Waking the Beast (Quest)
        { 4,  580,    0 },   -- Sugar-coated Directive (ASA4)
    --  { 5,    ?,    0 },   -- *Trial by Earth (HTMBF)
    },

    [xi.zone.CLOISTER_OF_TIDES] =
    {
        { 0,  608,    0 },   -- Trial by Water (Quest)
        { 1,  609, 1549 },   -- Trial-size Trial by Water (Quest)
    --  { 2,  610,    0 },   -- Waking the Beast (Quest)
        { 3,  611,    0 },   -- Sugar-coated Directive (ASA4)
    --  { 4,    ?,    0 },   -- *Trial by Water (HTMBF)
    },

}

-----------------------------------
-- Check requirements for registrant and allies
-----------------------------------
local function checkReqs(player, npc, bfid, registrant)
    local battlefield = xi.battlefield.contents[bfid]
    if battlefield then
        return battlefield:checkRequirements(player, npc, registrant)
    end

    local npcId     = npc:getID()
    local mainJob   = player:getMainJob()
    local mainLevel = player:getMainLvl()

    local sandoriaMission  = player:getCurrentMission(xi.mission.log_id.SANDORIA)
    local bastokMission    = player:getCurrentMission(xi.mission.log_id.BASTOK)
    local windurstMission  = player:getCurrentMission(xi.mission.log_id.WINDURST)
    local zilartMission    = player:getCurrentMission(xi.mission.log_id.ZILART)
    local promathiaMission = player:getCurrentMission(xi.mission.log_id.COP)
    local toauMission      = player:getCurrentMission(xi.mission.log_id.TOAU)
--  local acpMission       = player:getCurrentMission(xi.mission.log_id.ACP) NOTE: UNUSED Until BCNMID 532 is Re-enabled
    local asaMission       = player:getCurrentMission(xi.mission.log_id.ASA)

    local nationStatus    = player:getMissionStatus(player:getNation())
    local zilartStatus    = player:getMissionStatus(xi.mission.log_id.ZILART)
    local promathiaStatus = player:getCharVar('PromathiaStatus')
    local toauStatus      = player:getMissionStatus(xi.mission.log_id.TOAU)

    local function getEntranceOffset(offset)
        return zones[player:getZoneID()].npc.ENTRANCE_OFFSET + offset
    end

    -- Requirements to register a battlefield
    local registerReqs =
    {
        [0] = function() -- Mission 2-3
            return nationStatus == 9 and
                (
                    bastokMission == xi.mission.id.bastok.THE_EMISSARY_SANDORIA2 or
                    windurstMission == xi.mission.id.windurst.THE_THREE_KINGDOMS_SANDORIA2
                )
        end,

        [3] = function() -- San d'Oria 7-2: The Secret Weapon
            return sandoriaMission == xi.mission.id.sandoria.THE_SECRET_WEAPON and
                nationStatus == 2
        end,

        [5] = function() -- Quest: Shattering Stars (WAR LB5)
            return mainJob == xi.job.WAR and mainLevel >= 66
        end,

        [6] = function() -- Quest: Shattering Stars (BLM LB5)
            return mainJob == xi.job.BLM and mainLevel >= 66
        end,

        [7] = function() -- Quest: Shattering Stars (RNG LB5)
            return mainJob == xi.job.RNG and mainLevel >= 66
        end,

        [20] = function() -- Quest: Beyond Infinity
            return player:hasKeyItem(xi.ki.SOUL_GEM_CLASP)
        end,

        [32] = function() -- San d'Oria 1-3: Save the Children
            local hasCompletedSaveTheChildren = player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SAVE_THE_CHILDREN)

            return sandoriaMission == xi.mission.id.sandoria.SAVE_THE_CHILDREN and
                (
                    (hasCompletedSaveTheChildren and nationStatus <= 2) or
                    (not hasCompletedSaveTheChildren and nationStatus == 2)
                )
        end,

        [33] = function() -- Quest: The Holy Crest
            return player:hasKeyItem(xi.ki.DRAGON_CURSE_REMEDY)
        end,

        [64] = function() -- Mission 2-3
            return nationStatus == 10 and
                (
                    sandoriaMission == xi.mission.id.sandoria.JOURNEY_TO_BASTOK2 or
                    windurstMission == xi.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK2
                )
        end,

        [67] = function() -- Bastok 7-2: On My Way
            return bastokMission == xi.mission.id.bastok.ON_MY_WAY and nationStatus == 2
        end,

        [68] = function() -- Quest: A Thief in Norg!?
            return player:getCharVar('Quest[5][142]Prog') == 6
        end,

        [70] = function() -- Quest: Shattering Stars (RDM LB5)
            return mainJob == xi.job.RDM and mainLevel >= 66
        end,

        [71] = function() -- Quest: Shattering Stars (THF LB5)
            return mainJob == xi.job.THF and mainLevel >= 66
        end,

        [72] = function() -- Quest: Shattering Stars (BST LB5)
            return mainJob == xi.job.BST and mainLevel >= 66
        end,

        [85] = function() -- Quest: Beyond Infinity
            return player:hasKeyItem(xi.ki.SOUL_GEM_CLASP)
        end,

        [96] = function() -- Mission 2-3
            return player:hasKeyItem(xi.ki.DARK_KEY)
        end,

        [99] = function() -- Windurst 6-2: A Saintly Invitation
            return windurstMission == xi.mission.id.windurst.SAINTLY_INVITATION and
                nationStatus == 1
        end,

        [101] = function() -- Quest: Shattering Stars (MNK LB5)
            return mainJob == xi.job.MNK and mainLevel >= 66
        end,

        [102] = function() -- Quest: Shattering Stars (WHM LB5)
            return mainJob == xi.job.WHM and mainLevel >= 66
        end,

        [103] = function() -- Quest: Shattering Stars (SMN LB5)
            return mainJob == xi.job.SMN and mainLevel >= 66
        end,

        [116] = function() -- Quest: Beyond Infinity
            return player:hasKeyItem(xi.ki.SOUL_GEM_CLASP)
        end,

        [128] = function() -- ZM4: The Temple of Uggalepih
            return zilartMission == xi.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH
        end,

        [163] = function() -- Quest: Survival of the Wisest (SCH LB5)
            return mainJob == xi.job.SCH and mainLevel >= 66
        end,

        [192] = function() -- ZM6: Through the Quicksand Caves
            return zilartMission == xi.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES
        end,

        [194] = function() -- Quest: Shattering Stars (SAM LB5)
            return mainJob == xi.job.SAM and mainLevel >= 66
        end,

        [195] = function() -- Quest: Shattering Stars (NIN LB5)
            return mainJob == xi.job.NIN and mainLevel >= 66
        end,

        [196] = function() -- Quest: Shattering Stars (DRG LB5)
            return mainJob == xi.job.DRG and mainLevel >= 66
        end,

        [224] = function() -- Quest: The Moonlit Path
            return player:hasKeyItem(xi.ki.MOON_BAUBLE)
        end,

        [225] = function() -- Windurst 9-2: Moon Reading
            return windurstMission == xi.mission.id.windurst.MOON_READING and
                nationStatus == 2
        end,

        [256] = function() -- ZM8: Return to Delkfutt's Tower
            return zilartMission == xi.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER and
                zilartStatus == 2
        end,

        [288] = function() -- ZM14: Ark Angels (Hume)
            return zilartMission == xi.mission.id.zilart.ARK_ANGELS and
                zilartStatus == 1 and
                npcId == getEntranceOffset(0) and
                not player:hasKeyItem(xi.ki.SHARD_OF_APATHY)
        end,

        [289] = function() -- ZM14: Ark Angels (Tarutaru)
            return zilartMission == xi.mission.id.zilart.ARK_ANGELS and
                zilartStatus == 1 and
                npcId == getEntranceOffset(1) and
                not player:hasKeyItem(xi.ki.SHARD_OF_COWARDICE)
        end,

        [290] = function() -- ZM14: Ark Angels (Mithra)
            return zilartMission == xi.mission.id.zilart.ARK_ANGELS and
                zilartStatus == 1 and
                npcId == getEntranceOffset(2) and
                not player:hasKeyItem(xi.ki.SHARD_OF_ENVY)
        end,

        [291] = function() -- ZM14: Ark Angels (Elvaan)
            return zilartMission == xi.mission.id.zilart.ARK_ANGELS and
                zilartStatus == 1 and
                npcId == getEntranceOffset(3) and
                not player:hasKeyItem(xi.ki.SHARD_OF_ARROGANCE)
        end,

        [292] = function() -- ZM14: Ark Angels (Galka)
            return zilartMission == xi.mission.id.zilart.ARK_ANGELS and
                zilartStatus == 1 and
                npcId == getEntranceOffset(4) and
                not player:hasKeyItem(xi.ki.SHARD_OF_RAGE)
        end,

        [293] = function() -- ZM14 Divine Might
            return player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT) == QUEST_ACCEPTED or
                player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.DIVINE_MIGHT_REPEAT) == QUEST_ACCEPTED
        end,

        [320] = function() -- ZM16: The Celestial Nexus
            return zilartMission == xi.mission.id.zilart.THE_CELESTIAL_NEXUS
        end,

        [416] = function() -- Quest: Trial by Wind
            return player:hasKeyItem(xi.ki.TUNING_FORK_OF_WIND)
        end,

        [417] = function() -- Quest: Carbuncle Debacle
            return player:getCharVar('CarbuncleDebacleProgress') == 6
        end,

        [418] = function() -- Quest: Trial-size Trial by Wind
            return mainJob == xi.job.SMN and mainLevel >= 20
        end,

        [420] = function() -- ASA4: Sugar-coated Directive
            return asaMission >= xi.mission.id.asa.SUGAR_COATED_DIRECTIVE and
                player:hasKeyItem(xi.ki.DOMINAS_EMERALD_SEAL)
        end,

        [448] = function() -- Quest: Trial by Lightning
            return player:hasKeyItem(xi.ki.TUNING_FORK_OF_LIGHTNING)
        end,

        [449] = function() -- Quest: Carbuncle Debacle
            return player:getCharVar('CarbuncleDebacleProgress') == 3
        end,

        [450] = function() -- Quest: Trial-size Trial by Lightning
            return mainJob == xi.job.SMN and mainLevel >= 20
        end,

        [452] = function() -- ASA4: Sugar-coated Directive
            return asaMission >= xi.mission.id.asa.SUGAR_COATED_DIRECTIVE and
                player:hasKeyItem(xi.ki.DOMINAS_VIOLET_SEAL)
        end,

        [480] = function() -- Quest: Trial by Ice
            return player:hasKeyItem(xi.ki.TUNING_FORK_OF_ICE)
        end,

        [481] = function() -- Quest: Class Reunion
            return player:getCharVar('ClassReunionProgress') == 5
        end,

        [482] = function() -- Quest: Trial-size Trial by Ice
            return mainJob == xi.job.SMN and mainLevel >= 20
        end,

        [484] = function() -- ASA4: Sugar-coated Directive
            return asaMission >= xi.mission.id.asa.SUGAR_COATED_DIRECTIVE and
                player:hasKeyItem(xi.ki.DOMINAS_AZURE_SEAL)
        end,

        [512] = function() -- Mission 5-1
            return player:getCurrentMission(player:getNation()) == xi.mission.id.nation.ARCHLICH and
                nationStatus == 11
        end,

        [516] = function() -- San d'Oria 9-2: The Heir to the Light
            return sandoriaMission == xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT and
                nationStatus == 3
        end,

        [517] = function() -- Quest: Shattering Stars (PLD LB5)
            return mainJob == xi.job.PLD and mainLevel >= 66
        end,

        [518] = function() -- Quest: Shattering Stars (DRK LB5)
            return mainJob == xi.job.DRK and mainLevel >= 66
        end,

        [519] = function() -- Quest: Shattering Stars (BRD LB5)
            return mainJob == xi.job.BRD and mainLevel >= 66
        end,

        [530] = function() -- Quest: A Furious Finale (DNC LB5)
            return mainJob == xi.job.DNC and mainLevel >= 66
        end,

        -- Temp disabled pending BCNM mob fixes
        -- [532] = function() -- Those Who Lurk in Shadows (ACP7)
        --     return acpMission >= xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_III and
        --         player:hasKeyItem(xi.ki.MARK_OF_SEED)
        -- end,

        [533] = function() -- Quest: Beyond Infinity
            return player:hasKeyItem(xi.ki.SOUL_GEM_CLASP)
        end,

        [544] = function() -- Quest: Trial by Fire
            return player:hasKeyItem(xi.ki.TUNING_FORK_OF_FIRE)
        end,

        [545] = function() -- Quest: Trial-size Trial by Fire
            return mainJob == xi.job.SMN and mainLevel >= 20
        end,

        [547] = function() -- ASA4: Sugar-coated Directive
            return asaMission >= xi.mission.id.asa.SUGAR_COATED_DIRECTIVE and
                player:hasKeyItem(xi.ki.DOMINAS_SCARLET_SEAL)
        end,

        [576] = function() -- Quest: Trial by Earth
            return player:hasKeyItem(xi.ki.TUNING_FORK_OF_EARTH)
        end,

        [577] = function() -- Quest: The Puppet Master
            return player:getCharVar('Quest[2][81]Prog') == 1
        end,

        [578] = function() -- Quest: Trial-size Trial by Earth
            return mainJob == xi.job.SMN and mainLevel >= 20
        end,

        [580] = function() -- ASA4: Sugar-coated Directive
            return asaMission >= xi.mission.id.asa.SUGAR_COATED_DIRECTIVE and
                player:hasKeyItem(xi.ki.DOMINAS_AMBER_SEAL)
        end,

        [608] = function() -- Quest: Trial by Water
            return player:hasKeyItem(xi.ki.TUNING_FORK_OF_WATER)
        end,

        [609] = function() -- Quest: Trial-size Trial by Water
            return mainJob == xi.job.SMN and mainLevel >= 20
        end,

        [611] = function() -- ASA4: Sugar-coated Directive
            return asaMission >= xi.mission.id.asa.SUGAR_COATED_DIRECTIVE and
                player:hasKeyItem(xi.ki.DOMINAS_CERULEAN_SEAL)
        end,

        [641] = function() -- ENM: Follow the White Rabbit
            return player:hasKeyItem(xi.ki.ZEPHYR_FAN) and npcId == getEntranceOffset(2)
        end,

        [642] = function() -- ENM: When Hell Freezes Over
            return player:hasKeyItem(xi.ki.ZEPHYR_FAN) and npcId == getEntranceOffset(4)
        end,

        [672] = function() -- PM5-3 U2: Head Wind
            return promathiaMission == xi.mission.id.cop.THREE_PATHS and
                player:getMissionStatus(xi.mission.log_id.COP, xi.mission.status.COP.ULMIA) == 7
        end,

        [673] = function() -- ENM: Like the Wind
            return player:hasKeyItem(xi.ki.MIASMA_FILTER)
        end,

        [674] = function() -- ENM: Sheep in Antlion's Clothing
            return player:hasKeyItem(xi.ki.MIASMA_FILTER)
        end,

        [675] = function() -- ENM: Shell We Dance?
            return player:hasKeyItem(xi.ki.MIASMA_FILTER)
        end,

        [676] = function() -- ENM: Totentanz
            return player:hasKeyItem(xi.ki.MIASMA_FILTER)
        end,

        [677] = function() -- Quest: Tango with a Tracker
            return player:hasKeyItem(xi.ki.LETTER_FROM_SHIKAREE_X)
        end,

        [678] = function() -- Quest: Requiem of Sin
            return player:hasKeyItem(xi.ki.LETTER_FROM_SHIKAREE_Y)
        end,

        [704] = function() -- PM3-5: Darkness Named
            return promathiaMission == xi.mission.id.cop.DARKNESS_NAMED and
                player:getCharVar('Mission[6][358]Status') == 4
        end,

        [705] = function() -- ENM: Test Your Mite
            return player:hasKeyItem(xi.ki.ASTRAL_COVENANT)
        end,

        [706] = function() -- Quest: Waking Dreams
            return player:hasKeyItem(xi.ki.VIAL_OF_DREAM_INCENSE)
        end,

        [736] = function() -- PM5-3 L3: A Century of Hardship
            return promathiaMission == xi.mission.id.cop.THREE_PATHS and
                player:getMissionStatus(xi.mission.log_id.COP, xi.mission.status.COP.LOUVERANCE) == 8
        end,

        [738] = function() -- ENM: Bionic Bug
            return player:hasKeyItem(xi.ki.SHAFT_2716_OPERATING_LEVER)
        end,

        [739] = function() -- ENM: Pulling Your Strings
            return player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL)
        end,

        [740] = function() -- ENM: Automaton Assault
            return player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL)
        end,

        [768] = function() -- PM1-3: The Mothercrystals
            return promathiaMission == xi.mission.id.cop.BELOW_THE_ARKS or
                (promathiaMission == xi.mission.id.cop.THE_MOTHERCRYSTALS and not player:hasKeyItem(xi.ki.LIGHT_OF_HOLLA))
        end,

        [769] = function() -- ENM: Simulant
            return player:hasKeyItem(xi.ki.CENSER_OF_ABANDONMENT)
        end,

        [800] = function() -- PM1-3: The Mothercrystals
            return promathiaMission == xi.mission.id.cop.BELOW_THE_ARKS or
                (promathiaMission == xi.mission.id.cop.THE_MOTHERCRYSTALS and not player:hasKeyItem(xi.ki.LIGHT_OF_DEM))
        end,

        [801] = function() -- ENM: You Are What You Eat
            return player:hasKeyItem(xi.ki.CENSER_OF_ANTIPATHY)
        end,

        [832] = function() -- PM1-3: The Mothercrystals
            return promathiaMission == xi.mission.id.cop.BELOW_THE_ARKS or
                (promathiaMission == xi.mission.id.cop.THE_MOTHERCRYSTALS and not player:hasKeyItem(xi.ki.LIGHT_OF_MEA))
        end,

        [833] = function() -- ENM: Playing Host
            return player:hasKeyItem(xi.ki.CENSER_OF_ANIMUS)
        end,

        [864] = function() -- PM5-2: Desires of Emptiness
            return promathiaMission == xi.mission.id.cop.DESIRES_OF_EMPTINESS and
                player:getCharVar('Mission[6][518]Status') == 2
        end,

        [865] = function() -- ENM: Pulling the Plug
            return player:hasKeyItem(xi.ki.CENSER_OF_ACRIMONY)
        end,

        [896] = function() -- Quest: Storms of Fate
            return player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) == QUEST_ACCEPTED and
                player:getCharVar('StormsOfFate') == 2
        end,

        [960] = function() -- PM2-5: Ancient Vows
            return promathiaMission == xi.mission.id.cop.ANCIENT_VOWS and
                player:getCharVar('Mission[6][248]Status') == 2 and
                player:getPreviousZone() == xi.zone.RIVERNE_SITE_A01
        end,

        [961] = function() -- PM4-2: The Savage
            return promathiaMission == xi.mission.id.cop.THE_SAVAGE and
                player:getCharVar('Mission[6][418]Status') == 1 and
                player:getPreviousZone() == xi.zone.RIVERNE_SITE_B01
        end,

        [962] = function() -- ENM: Fire in the Sky
            return player:hasKeyItem(xi.ki.MONARCH_BEARD)
        end,

        [963] = function() -- ENM: Bad Seed
            return player:hasKeyItem(xi.ki.MONARCH_BEARD)
        end,

        [964] = function() -- ENM: Bugard in the Clouds
            return player:hasKeyItem(xi.ki.MONARCH_BEARD)
        end,

        [965] = function() -- ENM: Beloved of Atlantes
            return player:hasKeyItem(xi.ki.MONARCH_BEARD)
        end,

        [992] = function() -- PM6-4: One to be Feared
            return promathiaMission == xi.mission.id.cop.ONE_TO_BE_FEARED and
                player:getCharVar('Mission[6][638]Status') == 3
        end,

        [993] = function() -- PM7-5: The Warrior's Path
            return promathiaMission == xi.mission.id.cop.THE_WARRIORS_PATH and
                player:getCharVar('Mission[6][748]Status') == 1
        end,

        [1024] = function() -- PM8-3: When Angels Fall
            return promathiaMission == xi.mission.id.cop.WHEN_ANGELS_FALL and
                promathiaStatus == 4
        end,

        [1056] = function() -- PM8-4: Dawn
            return promathiaMission == xi.mission.id.cop.DAWN and
                promathiaStatus == 2
        end,

        [1057] = function() -- Apocalypse Nigh
            return player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) == QUEST_ACCEPTED and
                player:getCharVar('ApocalypseNigh') == 4
        end,

        [1090] = function() -- Quest: Puppetmaster Blues
            return player:hasKeyItem(xi.ki.TOGGLE_SWITCH)
        end,

        [1091] = function() -- Quest: Breaking the Bonds of Fate (COR LB5)
            return mainJob == xi.job.COR and mainLevel >= 66
        end,

        [1092] = function() -- TOAU35: Legacy of the Lost
            return toauMission == xi.mission.id.toau.LEGACY_OF_THE_LOST
        end,

        [1122] = function() -- Quest: Omens (BLU AF Quest 2)
            return player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.OMENS) == QUEST_ACCEPTED and
                xi.quest.getVar(player, xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.OMENS, 'Prog') == 0
        end,

        [1123] = function() -- Quest: Achieving True Power (PUP LB5)
            return mainJob == xi.job.PUP and mainLevel >= 66
        end,

        [1124] = function() -- TOAU22: Shield of Diplomacy
            return toauMission == xi.mission.id.toau.SHIELD_OF_DIPLOMACY and toauStatus == 2
        end,

        [1154] = function() -- Quest: The Beast Within (BLU LB5)
            return mainJob == xi.job.BLU and mainLevel >= 66
        end,

        [1156] = function() -- TOAU29: Puppet in Peril
            return toauMission == xi.mission.id.toau.PUPPET_IN_PERIL and toauStatus == 1
        end,

        [2721] = function() -- WOTG07: Purple, The New Black
            return player:getCurrentMission(xi.mission.log_id.WOTG) == xi.mission.id.wotg.PURPLE_THE_NEW_BLACK and
                player:getMissionStatus(xi.mission.log_id.WOTG) == 1
        end,
    }

    -- Requirements to enter a battlefield already registered by a party member
    local enterReqs =
    {
        [640] = function() -- PM5-3 U3: Flames for the Dead
            return npc:getXPos() > -721 and npc:getXPos() < 719
        end,

        [641] = function() -- ENM: Follow the White Rabbit
            return player:hasKeyItem(xi.ki.ZEPHYR_FAN)
        end,

        [642] = function() -- ENM: When Hell Freezes Over
            return player:hasKeyItem(xi.ki.ZEPHYR_FAN)
        end,

        [673] = function() -- ENM: Like the Wind
            return player:hasKeyItem(xi.ki.MIASMA_FILTER)
        end,

        [674] = function() -- ENM: Sheep in Antlion's Clothing
            return player:hasKeyItem(xi.ki.MIASMA_FILTER)
        end,

        [675] = function() -- ENM: Shell We Dance?
            return player:hasKeyItem(xi.ki.MIASMA_FILTER)
        end,

        [676] = function() -- ENM: Totentanz
            return player:hasKeyItem(xi.ki.MIASMA_FILTER)
        end,

        [705] = function() -- ENM: Test Your Mite
            return player:hasKeyItem(xi.ki.ASTRAL_COVENANT)
        end,

        [738] = function() -- ENM: Bionic Bug
            return player:hasKeyItem(xi.ki.SHAFT_2716_OPERATING_LEVER)
        end,

        [739] = function() -- ENM: Pulling Your Strings
            return player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL)
        end,

        [740] = function() -- ENM: Automaton Assault
            return player:hasKeyItem(xi.ki.SHAFT_GATE_OPERATING_DIAL)
        end,

        [769] = function() -- ENM: Simulant
            return player:hasKeyItem(xi.ki.CENSER_OF_ABANDONMENT)
        end,

        [801] = function() -- ENM: You Are What You Eat
            return player:hasKeyItem(xi.ki.CENSER_OF_ANTIPATHY)
        end,

        [833] = function() -- ENM: Playing Host
            return player:hasKeyItem(xi.ki.CENSER_OF_ANIMUS)
        end,

        [865] = function() -- ENM: Pulling the Plug
            return player:hasKeyItem(xi.ki.CENSER_OF_ACRIMONY)
        end,

        [897] = function() -- Quest: The Wyrmking Descends
            return player:hasKeyItem(xi.ki.WHISPER_OF_THE_WYRMKING)
        end,

        [962] = function() -- ENM: Fire in the Sky
            return player:hasKeyItem(xi.ki.MONARCH_BEARD)
        end,

        [963] = function() -- ENM: Bad Seed
            return player:hasKeyItem(xi.ki.MONARCH_BEARD)
        end,

        [964] = function() -- ENM: Bugard in the Clouds
            return player:hasKeyItem(xi.ki.MONARCH_BEARD)
        end,

        [965] = function() -- ENM: Beloved of Atlantes
            return player:hasKeyItem(xi.ki.MONARCH_BEARD)
        end,

        [928] = function() -- Quest: Ouryu Cometh
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_VOWS) or
                (
                    promathiaMission == xi.mission.id.cop.ANCIENT_VOWS and
                    player:getCharVar('Mission[6][248]Status') >= 2
                )
        end,

        [1057] = function() -- Quest: Apocalypse Nigh
            return player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) or
                (
                    player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) == QUEST_ACCEPTED and
                    player:getCharVar('ApocalypseNigh') == 4
                )
        end,

        [1290] = function() -- NW Apollyon
            return player:hasKeyItem(xi.ki.COSMO_CLEANSE) and
                player:hasKeyItem(xi.ki.RED_CARD) and
                npcId == getEntranceOffset(0)
        end,

        [1291] = function() -- SW Apollyon
            return player:hasKeyItem(xi.ki.COSMO_CLEANSE) and
                player:hasKeyItem(xi.ki.RED_CARD) and
                npcId == getEntranceOffset(0)
        end,

        [1292] = function() -- NE Apollyon
            return player:hasKeyItem(xi.ki.COSMO_CLEANSE) and
                player:hasKeyItem(xi.ki.BLACK_CARD) and
                npcId == getEntranceOffset(1)
        end,

        [1293] = function() -- SE Apollyon
            return player:hasKeyItem(xi.ki.COSMO_CLEANSE) and
                player:hasKeyItem(xi.ki.BLACK_CARD) and
                npcId == getEntranceOffset(1)
        end,

        [1294] = function() -- CS Apollyon
            return player:hasKeyItem(xi.ki.COSMO_CLEANSE) and
                (
                    (player:hasKeyItem(xi.ki.RED_CARD) and npcId == getEntranceOffset(0)) or
                    (player:hasKeyItem(xi.ki.BLACK_CARD) and npcId == getEntranceOffset(1))
                )
        end,

        [1296] = function() -- Central Apollyon
            return player:hasKeyItem(xi.ki.COSMO_CLEANSE) and
            (
                (player:hasKeyItem(xi.ki.RED_CARD) and npcId == getEntranceOffset(0)) or
                (player:hasKeyItem(xi.ki.BLACK_CARD) and npcId == getEntranceOffset(1))
            )
        end,

        [1298] = function() -- Temenos Western Tower
            return player:hasKeyItem(xi.ki.COSMO_CLEANSE) and
                player:hasKeyItem(xi.ki.WHITE_CARD)
        end,

        [1299] = function() -- Temenos Northern Tower
            return player:hasKeyItem(xi.ki.COSMO_CLEANSE) and
                player:hasKeyItem(xi.ki.WHITE_CARD)
        end,

        [1300] = function() -- Temenos Eastern Tower
            return player:hasKeyItem(xi.ki.COSMO_CLEANSE) and
                player:hasKeyItem(xi.ki.WHITE_CARD)
        end,

        [1301] = function() -- Central Temenos Basement
            return player:hasKeyItem(xi.ki.COSMO_CLEANSE) and
                player:hasKeyItem(xi.ki.WHITE_CARD)
        end,

        [1303] = function() -- Central Temenos 1st Floor
            return player:hasKeyItem(xi.ki.COSMO_CLEANSE) and
                player:hasKeyItem(xi.ki.WHITE_CARD)
        end,

        [1304] = function() -- Central Temenos 2nd Floor
            return player:hasKeyItem(xi.ki.COSMO_CLEANSE) and
                player:hasKeyItem(xi.ki.WHITE_CARD)
        end,

        [1305] = function() -- Central Temenos 3rd Floor
            return player:hasKeyItem(xi.ki.COSMO_CLEANSE) and
                player:hasKeyItem(xi.ki.WHITE_CARD)
        end,

        [1306] = function() -- Central Temenos 4th Floor
            return player:hasKeyItem(xi.ki.COSMO_CLEANSE) and
                player:hasKeyItem(xi.ki.WHITE_CARD)
        end,

        [2721] = function() -- WOTG07: Purple, The New Black
            return player:hasCompletedMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.PURPLE_THE_NEW_BLACK)
        end,
    }

    -- Determine whether player meets battlefield requirements
    local req = registrant and registerReqs[bfid] or enterReqs[bfid]

    if not req or req() then
        return true
    else
        return false
    end
end

-----------------------------------
-- check ability to skip a cutscene
-----------------------------------
local function checkSkip(player, bfid)
    local battlefield = xi.battlefield.contents[bfid]
    if battlefield then
        return battlefield:checkSkipCutscene(player)
    end

    local sandoriaMission  = player:getCurrentMission(xi.mission.log_id.SANDORIA)
    local bastokMission    = player:getCurrentMission(xi.mission.log_id.BASTOK)
    local windurstMission  = player:getCurrentMission(xi.mission.log_id.WINDURST)
    local promathiaMission = player:getCurrentMission(xi.mission.log_id.COP)

    local nationStatus    = player:getMissionStatus(player:getNation())
    local promathiaStatus = player:getCharVar('PromathiaStatus')

    -- Requirements to skip a battlefield
    local skipReqs =
    {
        [0] = function() -- Mission 2-3
            return player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY_SANDORIA2) or
                player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS_SANDORIA2) or
                nationStatus > 9 and
                (
                    bastokMission == xi.mission.id.bastok.THE_EMISSARY_SANDORIA2 or
                    windurstMission == xi.mission.id.windurst.THE_THREE_KINGDOMS_SANDORIA2
                )
        end,

        [3] = function() -- San d'Oria 7-2: The Secret Weapon
            return player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_SECRET_WEAPON) or
                (
                    sandoriaMission == xi.mission.id.sandoria.THE_SECRET_WEAPON and
                    nationStatus > 2
                )
        end,

        [32] = function() -- San d'Oria 1-3: Save the Children
            return player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SAVE_THE_CHILDREN) or
                (
                    sandoriaMission == xi.mission.id.sandoria.SAVE_THE_CHILDREN and
                    nationStatus > 2
                )
        end,

        [33] = function() -- Quest: The Holy Crest
            return player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST)
        end,

        [64] = function() -- Mission 2-3
            return player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_TO_BASTOK2) or
                player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK2) or
                nationStatus > 10 and
                (
                    sandoriaMission == xi.mission.id.sandoria.JOURNEY_TO_BASTOK2 or
                    windurstMission == xi.mission.id.windurst.THE_THREE_KINGDOMS_BASTOK2
                )
        end,

        [67] = function() -- Bastok 7-2: On My Way
            return player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.ON_MY_WAY) or
                (
                    bastokMission == xi.mission.id.bastok.ON_MY_WAY and
                    nationStatus > 2
                )
        end,

        [96] = function() -- Mission 2-3
            return player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_TO_WINDURST2) or
                player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY_WINDURST2) or
                nationStatus > 8 and
                (
                    sandoriaMission == xi.mission.id.sandoria.JOURNEY_TO_WINDURST2 or
                    bastokMission == xi.mission.id.bastok.THE_EMISSARY_WINDURST2
                )
        end,

        [99] = function() -- Windurst 6-2: A Saintly Invitation
            return player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.SAINTLY_INVITATION) or
                (
                    windurstMission == xi.mission.id.windurst.SAINTLY_INVITATION and
                    nationStatus > 1
                )
        end,

        [161] = function() -- Bastok 9-2: Where Two Paths Converge
            return player:hasCompletedMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE) or
                (
                    bastokMission == xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE and
                    nationStatus > 4
                )
        end,

        [192] = function() -- ZM6: Through the Quicksand Caves
            return player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES)
        end,

        [224] = function() -- Quest: The Moonlit Path
            return player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_MOONLIT_PATH) or
                player:hasKeyItem(xi.ki.WHISPER_OF_THE_MOON)
        end,

        [225] = function() -- windurstMission 9-2: Moon Reading
            return player:hasCompletedMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.MOON_READING) or
                (
                    windurstMission == xi.mission.id.windurst.MOON_READING and
                    nationStatus > 4
                )
        end,

        [256] = function() -- ZM8: Return to Delkfutt's Tower
            return player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER)
        end,

        [288] = function() -- ZM14: Ark Angels (Hume)
            return player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.ARK_ANGELS)
        end,

        [289] = function() -- ZM14: Ark Angels (Tarutaru)
            return player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.ARK_ANGELS)
        end,

        [290] = function() -- ZM14: Ark Angels (Mithra)
            return player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.ARK_ANGELS)
        end,

        [291] = function() -- ZM14: Ark Angels (Elvaan)
            return player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.ARK_ANGELS)
        end,

        [292] = function() -- ZM14: Ark Angels (Galka)
            return player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.ARK_ANGELS)
        end,

        [320] = function() -- ZM16: The Celestial Nexus
            return player:hasCompletedMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CELESTIAL_NEXUS)
        end,

        [416] = function() -- Quest: Trial by Wind
            return player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WIND) or
                player:hasKeyItem(xi.ki.WHISPER_OF_GALES)
        end,

        [448] = function() -- Quest: Trial by Lightning
            return player:hasCompletedQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.TRIAL_BY_LIGHTNING) or
                player:hasKeyItem(xi.ki.WHISPER_OF_STORMS)
        end,

        [480] = function() -- Quest: Trial by Ice
            return player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TRIAL_BY_ICE) or
                player:hasKeyItem(xi.ki.WHISPER_OF_FROST)
        end,

        [512] = function() -- Mission 5-1
            return player:hasCompletedMission(player:getNation(), xi.mission.id.nation.ARCHLICH) or
                (
                    player:getCurrentMission(player:getNation()) == xi.mission.id.nation.ARCHLICH and
                    nationStatus > 11
                )
        end,

        [516] = function() -- San d'Oria 9-2: The Heir to the Light
            return player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT) or
                (
                    sandoriaMission == xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT and
                    nationStatus > 4
                )
        end,

        [544] = function() -- Quest: Trial by Fire
            return player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_FIRE) or
                player:hasKeyItem(xi.ki.WHISPER_OF_FLAMES)
        end,

        [576] = function() -- Quest: Trial by Earth
            return player:hasCompletedQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRIAL_BY_EARTH) or
                player:hasKeyItem(xi.ki.WHISPER_OF_TREMORS)
        end,

        [608] = function() -- Quest: Trial by Water
            return player:hasCompletedQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WATER) or
                player:hasKeyItem(xi.ki.WHISPER_OF_TIDES)
        end,

        [672] = function() -- PM5-3 U2: Head Wind
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THREE_PATHS) or
                (
                    promathiaMission == xi.mission.id.cop.THREE_PATHS and
                    player:getMissionStatus(xi.mission.log_id.COP, xi.mission.status.COP.ULMIA) > 7
                )
        end,

        [704] = function() -- PM3-5: Darkness Named
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED) or
                (
                    promathiaMission == xi.mission.id.cop.DARKNESS_NAMED and
                    player:getCharVar('Mission[6][358]Status') == 5
                )
        end,

        [706] = function() -- Quest: Waking Dreams
            return player:hasCompletedQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.WAKING_DREAMS) or
                player:hasKeyItem(xi.ki.WHISPER_OF_DREAMS)
        end,

        [736] = function() -- PM5-3 L3: A Century of Hardship
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THREE_PATHS) or
                (
                    promathiaMission == xi.mission.id.cop.THREE_PATHS and
                    player:getMissionStatus(xi.mission.log_id.COP, xi.mission.status.COP.LOUVERANCE) > 8
                )
        end,

        [768] = function() -- PM1-3: The Mothercrystals
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS) or
                player:hasKeyItem(xi.ki.LIGHT_OF_HOLLA)
        end,

        [800] = function() -- PM1-3: The Mothercrystals
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS) or
                player:hasKeyItem(xi.ki.LIGHT_OF_DEM)
        end,

        [832] = function() -- PM1-3: The Mothercrystals
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS) or
                player:hasKeyItem(xi.ki.LIGHT_OF_MEA)
        end,

        [864] = function() -- PM5-2: Desires of Emptiness
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DESIRES_OF_EMPTINESS) or
                (
                    promathiaMission == xi.mission.id.cop.DESIRES_OF_EMPTINESS and
                    player:getCharVar('Mission[6][518]Status') > 2
                )
        end,

        [896] = function() -- Quest: Storms of Fate
            local stormsOfFateStatus = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE)

            return stormsOfFateStatus == QUEST_COMPLETED or
                (
                    stormsOfFateStatus == QUEST_ACCEPTED and
                    player:getCharVar('StormsOfFate') > 2
                )
        end,

        [960] = function() -- PM2-5: Ancient Vows
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_VOWS)
        end,

        [961] = function() -- PM4-2: The Savage
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_SAVAGE) or
                (
                    promathiaMission == xi.mission.id.cop.THE_SAVAGE and
                    player:getCharVar('Mission[6][418]Status') > 1
                )
        end,

        [993] = function() -- PM7-5: The Warrior's Path
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIORS_PATH)
        end,

        [1024] = function() -- PM8-3: When Angels Fall
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.WHEN_ANGELS_FALL) or
                (
                    promathiaMission == xi.mission.id.cop.WHEN_ANGELS_FALL and
                    promathiaStatus > 4
                )
        end,

        [1056] = function() -- PM8-4: Dawn
            return player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN) or
                (
                    promathiaMission == xi.mission.id.cop.DAWN and
                    promathiaStatus > 2
                )
        end,

        [1057] = function() -- Apocalypse Nigh
            return player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH)
        end,

        [2721] = function() -- WOTG07: Purple, The New Black
            return player:hasCompletedMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.PURPLE_THE_NEW_BLACK)
        end,
    }

    -- Determine whether player meets cutscene skip requirements
    local req = skipReqs[bfid]

    if not req then
        return false
    elseif req() then
        return true
    end

    return false
end

-----------------------------------
-- Which battlefields are valid for registrant?
-----------------------------------
local function findBattlefields(player, npc, itemId)
    local mask = 0
    local zbfs = battlefields[player:getZoneID()]

    if zbfs == nil then
        return 0
    end

    for k, v in pairs(zbfs) do
        if
            v[3] == itemId and
            checkReqs(player, npc, v[2], true) and
            not player:battlefieldAtCapacity(v[2])
        then
            mask = bit.bor(mask, math.pow(2, v[1]))
        end
    end

    return mask
end

-----------------------------------
-- Get battlefield id for a given zone and bit
-----------------------------------
local function getBattlefieldIdByBit(player, bit)
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
-- Get battlefield bit for a given zone and id
-----------------------------------
local function getBattlefieldMaskById(player, bfid)
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
-- Get battlefield bit for a given zone and id
-----------------------------------
local function getItemById(player, bfid)
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

xi.bcnm.onTrade = function(player, npc, trade, onUpdate)
    if xi.battlefield.rejectLevelSyncedParty(player, npc) then -- player's party has level sync, abort.
        return false
    end

    -- Validate trade
    local itemId

    if not trade then
        return false

    -- Chips for limbus
    elseif npcUtil.tradeHasExactly(trade, { xi.item.SILVER_CHIP, xi.item.CERULEAN_CHIP, xi.item.ORCHID_CHIP }) then
        itemId = -1

    -- Chips for limbus
    elseif npcUtil.tradeHasExactly(trade, { xi.item.SMALT_CHIP, xi.item.SMOKY_CHIP, xi.item.CHARCOAL_CHIP, xi.item.MAGENTA_CHIP }) then
        itemId = -2

    -- Orbs / Testimonies
    else
        itemId = trade:getItemId(0)

        if
            itemId == nil or
            itemId < 1 or
            itemId > 65535 or
            trade:getItemCount() ~= 1 or
            trade:getSlotQty(0) ~= 1
        then
            return false

        -- Check for already used Orb or testimony.
        elseif player:getWornUses(itemId) > 0 then
            player:messageBasic(xi.msg.basic.ITEM_UNABLE_TO_USE_2, 0, 0) -- Unable to use item.
            return false
        end
    end

    -- Validate battlefield status
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) and not onUpdate then
        player:messageBasic(xi.msg.basic.WAIT_LONGER, 0, 0) -- You must wait longer to perform that action.

        return false
    end

    -- Check if another party member has battlefield status effect. If so, don't allow trade.
    local alliance = player:getAlliance()
    for _, member in pairs(alliance) do
        if member:hasStatusEffect(xi.effect.BATTLEFIELD) then
            player:messageBasic(xi.msg.basic.WAIT_LONGER, 0, 0) -- You must wait longer to perform that action.

            return false
        end
    end

    -- Open menu of valid battlefields
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
xi.bcnm.onTrigger = function(player, npc)
    -- Cannot enter if anyone in party is level/master sync'd
    if xi.battlefield.rejectLevelSyncedParty(player, npc) then
        return false
    end

    -- Player has battlefield status effect. That means a battlefield is open OR the player is inside a battlefield.
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        -- Player is inside battlefield. Attempting to leave.
        if player:getBattlefield() then
            player:startOptionalCutscene(32003)

            return true

        -- Player is outside battlefield. Attempting to enter.
        else
            local stat = player:getStatusEffect(xi.effect.BATTLEFIELD)
            local bfid = stat:getPower()
            local mask = getBattlefieldMaskById(player, bfid)

            if mask ~= 0 and checkReqs(player, npc, bfid, false) then
                player:startEvent(32000, 0, 0, 0, mask, 0, 0, 0, 0)

                return true
            end
        end

    -- Player doesn't have battlefield status effect. That means player wants to register a new battlefield OR is attempting to enter a closed one.
    else
        -- Check if another party member has battlefield status effect. If so, that means the player is trying to enter a closed battlefield.
        local alliance = player:getAlliance()
        for _, member in pairs(alliance) do
            if member:hasStatusEffect(xi.effect.BATTLEFIELD) then
                -- player:messageSpecial() -- You are eligible but cannot enter.

                return false
            end
        end

        -- No one in party/alliance has battlefield status effect. We want to register a new battlefield.
        local mask = findBattlefields(player, npc, 0)

        -- GMs get access to all BCNMs
        if player:getGMLevel() > 0 and player:checkNameFlags(0x04000000) then
            mask = 268435455
        end

        -- mask = 268435455 -- uncomment to open menu with all possible battlefields
        if mask ~= 0 then
            player:startEvent(32000, 0, 0, 0, mask, 0, 0, 0, 0)
            return true
        end
    end

    return false
end

-----------------------------------
-- onEventUpdate
-----------------------------------
xi.bcnm.onEventUpdate = function(player, csid, option, extras)
    -- player:printToPlayer(string.format('EventUpdateBCNM csid=%i option=%i extras=%i', csid, option, extras))

    -- Requesting a battlefield
    if csid == 32000 then
        if option == 0 then
            -- todo: check if battlefields full, check party member requiremenst
            return 0
        elseif option == 255 then
            -- todo: check if battlefields full, check party member requirements
            return 0
        end

        local area = player:getLocalVar('[battlefield]area')
        area       = area + 1

        local battlefieldIndex = bit.rshift(option, 4)
        local battlefieldId    = getBattlefieldIdByBit(player, battlefieldIndex)
        local id               = battlefieldId or player:getBattlefieldID()
        local skip             = checkSkip(player, id)

        local clearTime = 1
        local name      = 'Meme'
        local partySize = 1

        local result = xi.battlefield.returnCode.REQS_NOT_MET
        result       = player:registerBattlefield(id, area)
        local status = xi.battlefield.status.OPEN

        if result ~= xi.battlefield.returnCode.CUTSCENE then
            if result == xi.battlefield.returnCode.INCREMENT_REQUEST then
                if area < 3 then
                    player:setLocalVar('[battlefield]area', area)
                else
                    result = xi.battlefield.returnCode.WAIT
                    player:updateEvent(result)
                end
            end

            return false
        else
            -- Only allow entrance if battlefield is open and playerhas battlefield effect, witch can be lost mid battlefield selection.
            if
                not player:getBattlefield() and
                player:hasStatusEffect(xi.effect.BATTLEFIELD)
                -- and id:getStatus() == xi.battlefield.status.OPEN -- TODO: Uncomment only once that can-of-worms is dealt with.
            then
                player:enterBattlefield()
            end

            -- Handle record
            local initiatorId   = 0
            local initiatorName = ''
            local battlefield   = player:getBattlefield()

            if battlefield then
                battlefield:setLocalVar('[cs]bit', battlefieldIndex)
                name, clearTime, partySize = battlefield:getRecord()
                initiatorId, initiatorName = battlefield:getInitiator()
            end

            -- Register party members
            if initiatorId == player:getID() then
                local effect = player:getStatusEffect(xi.effect.BATTLEFIELD)
                local zone   = player:getZoneID()
                local item   = getItemById(player, effect:getPower())

                -- Handle traded items
                if item ~= 0 then
                    -- Remove limbus chips
                    if zone == 37 or zone == 38 then
                        player:tradeComplete()

                    -- Set other traded item to worn
                    elseif player:hasItem(item) and player:getName() == initiatorName then
                        player:incrementItemWear(item)
                    end
                end

                -- Handle party/alliance members
                local alliance = player:getAlliance()
                for _, member in pairs(alliance) do
                    if
                        member:getZoneID() == zone and
                        not member:hasStatusEffect(xi.effect.BATTLEFIELD) and
                        not member:getBattlefield()
                    then
                        member:addStatusEffect(effect)
                        member:registerBattlefield(id, area, player:getID())
                    end
                end
            end
        end

        player:updateEvent(result, battlefieldIndex, 0, clearTime, partySize, skip)
        player:updateEventString(name)
        return status < xi.battlefield.status.LOCKED and result < xi.battlefield.returnCode.LOCKED

    -- Leaving a battlefield
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

xi.bcnm.onEventFinish = function(player, csid, option, npc)
    -- player:printToPlayer(string.format('EventFinishBCNM csid=%i option=%i', csid, option))
    player:setLocalVar('[battlefield]area', 0)

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
