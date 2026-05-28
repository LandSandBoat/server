-----------------------------------
-- Expeditionary Force - Data
-----------------------------------
xi = xi or {}
xi.expeditionaryForce = xi.expeditionaryForce or {}

-- Can disable and enable expeditionary force for the server. Used during implementation.
xi.expeditionaryForce.enabled = true

-- Variables to modify as retail data is collected.
xi.expeditionaryForce.config =
{
    minRank              = 3,                                      -- Conquest rank required. Useful for debugging.
    partySizeByPlace     = { [0] = 4, [1] = 6, [2] = 5, [3] = 4 }, -- 0 = no standing yet DEBUG: change to 4, 1, 1, 1 for testing.
    creditRange          = 50,    -- Yalms from banner for credit eligibility
    capUsesConfrontation = true,  -- Only capped players can engage the NMs TODO: Remove
    capWearsOnZone       = true,  -- Zoning out removes the level cap TODO: Remove
    capLingerTime        = 900,   -- Seconds the cap lasts if not removed (15 min)
    capRemovalWindow     = 30,    -- Seconds CLEARED state lasts; click in this window removes the cap
    bannerRespawn        = 300,   -- Seconds banner stays HIDDEN between cycles
    chainTimeout         = 900,   -- Seconds between kills to keep the chain
    baseKillInfluence    = 50,    -- Placeholder. Retail verify.
    baseChestInfluence   = 50,    -- Placeholder. Retail verify.
}

-- CP awarded on collection, by count of participated regions the nation controls. Tiers 1-8 based on Wiki.
-- The data appears to follow a cubic, but then 13 would be 27,175 CP. This seems abnormal.
-- TODO: Update 9-13. Wiki only holds information up to 8 regions. Though, I do question the validity of 8.
xi.expeditionaryForce.cpReward =
{
    [1]  = 3000, [2]  = 4200, [3]  = 4800, [4]  = 5160,
    [5]  = 5430, [6]  = 5700, [7]  = 6105, [8]  = 7320,
    [9]  = 7320, [10] = 7320, [11] = 7320, [12] = 7320,
    [13] = 7320,
}

-- Overseer npc_list name to gate glyph item id.
-- Item ids resolved at load via GetItemIDByName; names match item_basic.sql.
-- TODO: Only scripts for 3/9 of the glyphs are created. Test in Windurst Woods for now.
xi.expeditionaryForce.gateGlyphs =
{
    ['Crying_Wind_IM']   = GetItemIDByName('bastok_mines_gate_glyph'),
    ['Rabid_Wolf_IM']    = GetItemIDByName('bastok_markets_gate_glyph'),
    ['Flying_Axe_IM']    = GetItemIDByName('port_bastok_gate_glyph'),
    ['Achantere_TK']     = GetItemIDByName('northern_san_doria_gate_glyph'),
    ['Aravoge_TK']       = GetItemIDByName('western_san_doria_gate_glyph'),
    ['Arpevion_TK']      = GetItemIDByName('eastern_san_doria_gate_glyph'),
    ['Harara_WW']        = GetItemIDByName('windurst_woods_gate_glyph'),
    ['Milma-Hapilma_WW'] = GetItemIDByName('port_windurst_gate_glyph'),
    ['Puroiko-Maiko_WW'] = GetItemIDByName('windurst_waters_gate_glyph'),
}

-- Only one glyph allowed per town. So, in theory, can have 3 glyphs in inventory.
-- Re-keyed view of gateGlyphs grouped by nation for this check.
local gg = xi.expeditionaryForce.gateGlyphs
xi.expeditionaryForce.gateGlyphsByNation =
{
    [xi.nation.BASTOK]   = { gg['Crying_Wind_IM'], gg['Rabid_Wolf_IM'],    gg['Flying_Axe_IM']    },
    [xi.nation.SANDORIA] = { gg['Achantere_TK'],   gg['Aravoge_TK'],       gg['Arpevion_TK']      },
    [xi.nation.WINDURST] = { gg['Harara_WW'],      gg['Milma-Hapilma_WW'], gg['Puroiko-Maiko_WW'] },
}

-- Per-region definitions. 
-- A region is active only when EFs are global-enabled, region-enabled, and required fields are present (see isRegionActive).
-- TODO: Retail test and update bannerSpawns and nmPool
-- TODO: All nmPool data has not been confirmed. They are definately INCORRECT. It is just an educated guess from old placeholders.
-- TODO: To test the nmPool for Zulkheim, the monster initial positions are changed from 0,0,0 to 1,1,1 to match Garrison. Only Zulkheim monsters have been modfied for this.
-- TODO: Any banner spawns below are placeholders for testing.
xi.expeditionaryForce.regions =
{
    [xi.region.ZULKHEIM] =
    {
        enabled      = true,
        eventOption  = 0x20006,
        menuBit      = 0x000040,
        zoneId       = xi.zone.VALKURM_DUNES,
        insignia     = xi.ki.ZULKHEIM_EF_INSIGNIA,
        minLevel     = 20,
        levelCap     = 30,
        bannerSpawns = { { -116.204, 4.000, -113.608, 160 } }, -- TODO: 1 of 5 from npc_list.sql; grid: E-6,C-7,F-9,J-6,K-8
        nmPool       =
        {
            { 'Hobgoblin_Warrior', 'Hobgoblin_White_Mage', 'Hobgoblin_Black_Mage', 'Hobgoblin_Thief', 'Hobgoblin_Ranger', 'Hobgoblin_Beastmaster' },
            { 'Halforc_Warrior', 'Halforc_Monk', 'Halforc_Paladin', 'Halforc_Ranger', 'Halforc_Dragoon' },
            { 'Metaquadav_Warrior', 'Metaquadav_White_Mage', 'Metaquadav_Black_Mage', 'Metaquadav_Thief', 'Metaquadav_Paladin', 'Metaquadav_Dark_Knight' },
        },
    },

    [xi.region.NORVALLEN] =
    {
        enabled      = false,
        eventOption  = 0x20007,
        menuBit      = 0x000080,
        zoneId       = xi.zone.JUGNER_FOREST,
        insignia     = xi.ki.NORVALLEN_EF_INSIGNIA,
        minLevel     = 25,
        levelCap     = 30,
        bannerSpawns = { { 600.809, 0.872, 217.453, 130 } }, -- TODO: 1 of 5 from npc_list.sql; grid: G-6,J-11,K-9,L-7,?
        nmPool       =
        {
            { 'Hobgoblin_Warrior', 'Hobgoblin_White_Mage', 'Hobgoblin_Black_Mage', 'Hobgoblin_Thief', 'Hobgoblin_Ranger', 'Hobgoblin_Beastmaster' },
            { 'Halforc_Warrior', 'Halforc_Monk', 'Halforc_Paladin', 'Halforc_Ranger', 'Halforc_Dragoon' },
        },
    },

    [xi.region.DERFLAND] =
    {
        enabled      = false,
        eventOption  = 0x20009,
        menuBit      = 0x000200,
        zoneId       = xi.zone.PASHHOW_MARSHLANDS,
        insignia     = xi.ki.DERFLAND_EF_INSIGNIA,
        minLevel     = 25,
        levelCap     = 30,
        bannerSpawns = { { 140.080, 23.923, -411.951, 112 } }, -- TODO: 1 of 5 from npc_list.sql; grid: E-5,G-8,I-11,J-7,?
        nmPool       =
        {
            { 'Hobgoblin_Warrior', 'Hobgoblin_White_Mage', 'Hobgoblin_Black_Mage', 'Hobgoblin_Thief', 'Hobgoblin_Ranger', 'Hobgoblin_Beastmaster' },
            { 'Metaquadav_Warrior', 'Metaquadav_White_Mage', 'Metaquadav_Black_Mage', 'Metaquadav_Thief', 'Metaquadav_Paladin', 'Metaquadav_Dark_Knight' },
        },
    },

    [xi.region.KOLSHUSHU] =
    {
        enabled      = false,
        eventOption  = 0x2000B,
        menuBit      = 0x000800,
        zoneId       = xi.zone.BUBURIMU_PENINSULA,
        insignia     = xi.ki.KOLSHUSHU_EF_INSIGNIA,
        minLevel     = 20,
        levelCap     = 30,
        bannerSpawns = { { -173.299, -81.871, 150.200, 246 } }, -- TODO: 1 of 5 from npc_list.sql; grid: E-9,G-10,I-6,J-5,K-8
        nmPool       =
        {
            { 'Hobgoblin_Warrior', 'Hobgoblin_White_Mage', 'Hobgoblin_Black_Mage', 'Hobgoblin_Thief', 'Hobgoblin_Ranger', 'Hobgoblin_Beastmaster' },
            { 'Theoyagudo_Monk', 'Theoyagudo_White_Mage', 'Theoyagudo_Black_Mage', 'Theoyagudo_Bard', 'Theoyagudo_Samurai', 'Theoyagudo_Ninja', 'Theoyagudo_Summoner' },
        },
    },

    [xi.region.ARAGONEU] =
    {
        enabled      = false,
        eventOption  = 0x2000C,
        menuBit      = 0x001000,
        zoneId       = xi.zone.MERIPHATAUD_MOUNTAINS,
        insignia     = xi.ki.ARAGONEU_EF_INSIGNIA,
        minLevel     = 25,
        levelCap     = 30,
        bannerSpawns = { { 153.000, -36.444, 23.500, 16 } }, -- TODO: 1 of 5 from npc_list.sql; grid: D-6,H-11,I-5,K-11,?
        nmPool       =
        {
            { 'Hobgoblin_Warrior', 'Hobgoblin_White_Mage', 'Hobgoblin_Black_Mage', 'Hobgoblin_Thief', 'Hobgoblin_Ranger', 'Hobgoblin_Beastmaster' },
            { 'Theoyagudo_Monk', 'Theoyagudo_White_Mage', 'Theoyagudo_Black_Mage', 'Theoyagudo_Bard', 'Theoyagudo_Samurai', 'Theoyagudo_Ninja', 'Theoyagudo_Summoner' },
        },
    },

    [xi.region.FAUREGANDI] =
    {
        enabled      = false,
        eventOption  = 0x2000D,
        menuBit      = 0x002000,
        zoneId       = xi.zone.BEAUCEDINE_GLACIER,
        insignia     = xi.ki.FAUREGANDI_EF_INSIGNIA,
        minLevel     = 35,
        levelCap     = 40,
        bannerSpawns = { { 162.059, -0.859, 250.538, 139 } }, -- TODO: 1 of 5 from npc_list.sql; grid: G-7,H-7,I-8,J-6,?
        nmPool       =
        {
            { 'Hobgoblin_Warrior', 'Hobgoblin_White_Mage', 'Hobgoblin_Black_Mage', 'Hobgoblin_Thief', 'Hobgoblin_Ranger', 'Hobgoblin_Beastmaster' },
            { 'Gigas_Warrior', 'Gigas_Monk', 'Gigas_Beastmaster', 'Gigas_Ranger' },
        },
    },

    [xi.region.VALDEAUNIA] =
    {
        enabled      = false,
        eventOption  = 0x2000E,
        menuBit      = 0x004000,
        zoneId       = xi.zone.XARCABARD,
        insignia     = xi.ki.VALDEAUNIA_EF_INSIGNIA,
        minLevel     = 40,
        levelCap     = 50,
        bannerSpawns = { { 27.934, -10.061, 398.640, 126 } }, -- TODO: 1 of 5 from npc_list.sql; grid: G-9,G-7,H-7,I-6,?
        nmPool       =
        {
            { 'Hobgoblin_Warrior', 'Hobgoblin_White_Mage', 'Hobgoblin_Black_Mage', 'Hobgoblin_Thief', 'Hobgoblin_Ranger', 'Hobgoblin_Beastmaster' },
            { 'Gigas_Warrior', 'Gigas_Monk', 'Gigas_Beastmaster', 'Gigas_Ranger' },
        },
    },

    [xi.region.QUFIMISLAND] =
    {
        enabled      = false,
        eventOption  = 0x2000F,
        menuBit      = 0x008000,
        zoneId       = xi.zone.QUFIM_ISLAND,
        insignia     = xi.ki.QUFIM_EF_INSIGNIA,
        minLevel     = 25,
        levelCap     = 30,
        bannerSpawns = { { 101.491, -23.093, 199.798, 218 } }, -- TODO: 1 of 5 from npc_list.sql; grid: F-8,H-8,H-8,I-8,?
        -- TODO: Fix Giant High Ranger (17293629)
        nmPool       =
        {
            { 'Hobgoblin_Warrior', 'Hobgoblin_White_Mage', 'Hobgoblin_Black_Mage', 'Hobgoblin_Thief', 'Hobgoblin_Ranger', 'Hobgoblin_Beastmaster' },
            { 'Giant_Warrior', 'Giant_Monk', 'Giant_Beastmaster' },
        },
    },

    [xi.region.LITELOR] =
    {
        enabled      = false,
        eventOption  = 0x20010,
        menuBit      = 0x010000,
        zoneId       = xi.zone.THE_SANCTUARY_OF_ZITAH,
        insignia     = xi.ki.LITELOR_EF_INSIGNIA,
        minLevel     = 35,
        levelCap     = 40,
        bannerSpawns = { { 199.396, -0.746, -527.072, 169 } }, -- TODO: 1 of 5 from npc_list.sql; grid: E-7,E-10,J-12,L-10,?
        nmPool       =
        {
            { 'Hobgoblin_Warrior', 'Hobgoblin_White_Mage', 'Hobgoblin_Black_Mage', 'Hobgoblin_Thief', 'Hobgoblin_Ranger', 'Hobgoblin_Beastmaster' },
        },
    },

    [xi.region.KUZOTZ] =
    {
        enabled      = false,
        eventOption  = 0x20011,
        menuBit      = 0x020000,
        zoneId       = xi.zone.EASTERN_ALTEPA_DESERT,
        insignia     = xi.ki.KUZOTZ_EF_INSIGNIA,
        minLevel     = 40,
        levelCap     = 50,
        bannerSpawns = { { -399.822, 0.161, -168.998, 174 } }, -- TODO: 1 of 5 from npc_list.sql; grid: E-7,G-5,H-6,J-10,J-6
        nmPool       =
        {
            { 'Hobgoblin_Warrior', 'Hobgoblin_White_Mage', 'Hobgoblin_Black_Mage', 'Hobgoblin_Thief', 'Hobgoblin_Ranger', 'Hobgoblin_Beastmaster' },
            { 'Contantican_Warrior', 'Contantican_Black_Mage', 'Contantican_Paladin', 'Contantican_Ranger' },
        },
    },

    [xi.region.VOLLBOW] =
    {
        enabled      = false,
        eventOption  = 0x20012,
        menuBit      = 0x040000,
        zoneId       = xi.zone.CAPE_TERIGGAN,
        insignia     = xi.ki.VOLLBOW_EF_INSIGNIA,
        minLevel     = 65,
        levelCap     = 99, -- Uncapped
        bannerSpawns = { { -54.134, 0.333, -405.397, 199 } }, -- TODO: 1 of 5 from npc_list.sql; grid: G-6,H-7,I-9,I-6,J-8
        nmPool       =
        {
            { 'Hobgoblin_Warrior', 'Hobgoblin_White_Mage', 'Hobgoblin_Black_Mage', 'Hobgoblin_Thief', 'Hobgoblin_Ranger', 'Hobgoblin_Beastmaster' },
        },
    },

    [xi.region.ELSHIMO_LOWLANDS] =
    {
        enabled      = false,
        eventOption  = 0x20013,
        menuBit      = 0x080000,
        zoneId       = xi.zone.YUHTUNGA_JUNGLE,
        insignia     = xi.ki.ELSHIMO_LOWLANDS_EF_INSIGNIA,
        minLevel     = 35,
        levelCap     = 40,
        bannerSpawns = { { -647.367, 0.000, 42.053, 28 } }, -- TODO: 1 of 5 from npc_list.sql; grid: D-8,G-11,H-9,K-8,?
        nmPool       =
        {
            { 'Hobgoblin_Warrior', 'Hobgoblin_White_Mage', 'Hobgoblin_Black_Mage', 'Hobgoblin_Thief', 'Hobgoblin_Ranger', 'Hobgoblin_Beastmaster' },
            -- TODO: 'Demishagin_White_Mage' is a typo in mob_spawn_points.sql? row 17281478
            { 'Demisahagin_Monk', 'Demishagin_White_Mage', 'Demisahagin_Bard', 'Demisahagin_Dragoon' },
        },
    },

    [xi.region.ELSHIMO_UPLANDS] =
    {
        enabled      = false,
        eventOption  = 0x20014,
        menuBit      = 0x100000,
        zoneId       = xi.zone.YHOATOR_JUNGLE,
        insignia     = xi.ki.ELSHIMO_UPLANDS_EF_INSIGNIA,
        minLevel     = 45,
        levelCap     = 50,
        bannerSpawns = { { 0.348, -20.126, 73.479, 202 } }, -- TODO: 1 of 5 from npc_list.sql; grid: F-10,G-9,H-10,J-10,?
        nmPool       =
        {
            { 'Hobgoblin_Warrior', 'Hobgoblin_White_Mage', 'Hobgoblin_Black_Mage', 'Hobgoblin_Thief', 'Hobgoblin_Ranger', 'Hobgoblin_Beastmaster' },
            { 'Noctonberry_Black_Mage', 'Noctonberry_Thief', 'Noctonberry_Ninja', 'Noctonberry_Summoner' },
        },
    },

    -- Starter regions: Retail does not offer EF here. Disabled for safety since they exist in overseer menu.
    [xi.region.RONFAURE]     = { enabled = false },
    [xi.region.GUSTABERG]    = { enabled = false },
    [xi.region.SARUTABARUTA] = { enabled = false },
}