-----------------------------------
-- Crafting Guilds
-- Ref: http://wiki.ffxiclopedia.org/wiki/Crafts_%26_Hobbies
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
require('scripts/globals/status')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.crafting = {}

xi.crafting.guild =
{
    ALCHEMY      = 1,
    BONECRAFT    = 2,
    CLOTHCRAFT   = 3,
    COOKING      = 4,
    FISHING      = 5,
    GOLDSMITHING = 6,
    LEATHERCRAFT = 7,
    SMITHING     = 8,
    WOODWORKING  = 9,
}

xi.crafting.rank =
{
    AMATEUR    = 0,
    RECRUIT    = 1,
    INITIATE   = 2,
    NOVICE     = 3,
    APPRENTICE = 4,
    JOURNEYMAN = 5,
    CRAFTSMAN  = 6,
    ARTISAN    = 7,
    ADEPT      = 8,
    VETERAN    = 9,
    EXPERT     = 10,
}

-- Keys are based on the player's current rank in the guild in order to be eligible
-- for the next rank-up test.  Example: At Amateur, a value of 256 is required to
-- be eligible for the test to move to Recruit
local requiredSkillForRank =
{
    [xi.crafting.rank.AMATEUR]    = 256,
    [xi.crafting.rank.RECRUIT]    = 577,
    [xi.crafting.rank.INITIATE]   = 898,
    [xi.crafting.rank.NOVICE]     = 1219,
    [xi.crafting.rank.APPRENTICE] = 1540,
    [xi.crafting.rank.JOURNEYMAN] = 1861,
    [xi.crafting.rank.CRAFTSMAN]  = 2182,
    [xi.crafting.rank.ARTISAN]    = 2503,
    [xi.crafting.rank.ADEPT]      = 2824,
    [xi.crafting.rank.VETERAN]    = 3145,
}

-- Table for Test Items
local testItemsByNPC =
{
    ["Abd-al-Raziq"]   = {   937,  4157,  4163,   947, 16543,  4116, 16479,  4120, 16609, 10792 },
    ["Peshi_Yohnts"]   = { 13442, 13441, 13323, 13459, 13091, 17299, 16420, 12508, 13987, 11058 },
    ["Ponono"]         = { 13583, 13584, 13204, 13075, 12723, 13586, 13752, 12612, 14253, 11000 },
    ["Piketo-Puketo"]  = {  4355,  4416,  4489,  4381,  4413,  4558,  4546,  4440,  4561,  5930 },
    ["Thubu_Parohren"] = {  4401,  4379,  4469,  4480,  4462,  4479,  4471,  4478,  4474,  5817 },
    ["Reinberta"]      = { 12496, 12497, 12495, 13082, 13446, 13084, 12545, 13125, 16515, 11060 },
    ["Faulpie"]        = { 13594, 16386, 13588, 13195, 12571, 12572, 12980, 12702, 12447, 10577 },
    ["Mevreauche"]     = { 16530, 12299, 16512, 16650, 16651, 16559, 12427, 16577, 12428, 19788 },
    ["Ghemp"]          = { 16530, 12299, 16512, 16650, 16651, 16559, 12427, 16577, 12428, 19788 },
    ["Cheupirudaux"]   = {    22,    23, 17354, 17348, 17053, 17156, 17054,    56, 17101, 18884 },
}

local hqCrystals =
{
    [1] = { id = xi.items.INFERNO_CRYSTAL,  cost = 200 },
    [2] = { id = xi.items.GLACIER_CRYSTAL,  cost = 200 },
    [3] = { id = xi.items.CYCLONE_CRYSTAL,  cost = 200 },
    [4] = { id = xi.items.TERRA_CRYSTAL,    cost = 200 },
    [5] = { id = xi.items.PLASMA_CRYSTAL,   cost = 200 },
    [6] = { id = xi.items.TORRENT_CRYSTAL,  cost = 200 },
    [7] = { id = xi.items.AURORA_CRYSTAL,   cost = 200 },
    [8] = { id = xi.items.TWILIGHT_CRYSTAL, cost = 200 },
}

xi.crafting.gpRewards =
{
    [0] = -- Fishing
    {
        ["Keyitems"] =
        {
            [0] = { id = xi.ki.FROG_FISHING,    rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 30000,  999999) },
            [1] = { id = xi.ki.SERPENT_RUMORS,  rank = 8, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 95000,  999999) },
            [2] = { id = xi.ki.MOOCHING,        rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 115000, 999999) },
            [3] = { id = xi.ki.ANGLERS_ALMANAC, rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_SOA == 1, 20000,  999999) },
        },
        ["Items"] =
        {
            [0] = { id = 17002, rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     1500,   999999) },
            [1] = { id = 15452, rank = 4, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     10000,  999999) },
            [2] = { id = 14195, rank = 5, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     70000,  999999) },
            [3] = { id = 14400, rank = 7, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     100000, 999999) },
            [4] = { id = 191,   rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     150000, 999999) },
            [5] = { id = 340,   rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_WOTG == 1,    200000, 999999) },
            [6] = { id = 3670,  rank = 7, cost = utils.ternary(xi.settings.main.ENABLE_ABYSSEA == 1, 50000,  999999) },
            [7] = { id = 3330,  rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_ABYSSEA == 1, 15000,  999999) },
        },
    },
    [1] = -- Woodworking
    {
        ["Keyitems"] =
        {
            [0] = { id = xi.ki.WOOD_PURIFICATION,    rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 40000, 999999) },
            [1] = { id = xi.ki.WOOD_ENSORCELLMENT,   rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 40000, 999999) },
            [2] = { id = xi.ki.LUMBERJACK,           rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 10000, 999999) },
            [3] = { id = xi.ki.BOLTMAKER,            rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 10000, 999999) },
            [4] = { id = xi.ki.WAY_OF_THE_CARPENTER, rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_SOA == 1, 20000, 999999) },
        },
        ["Items"] =
        {
            [0] = { id = 15444, rank = 1, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     10000,  999999) },
            [1] = { id = 14830, rank = 5, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     70000,  999999) },
            [2] = { id = 14392, rank = 7, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     100000, 999999) },
            [3] = { id = 28,    rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     150000, 999999) },
            [4] = { id = 341,   rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_TOAU == 1,    200000, 999999) },
            [5] = { id = 15819, rank = 6, cost = utils.ternary(xi.settings.main.ENABLE_WOTG == 1,    80000,  999999) },
            [6] = { id = 3672,  rank = 8, cost = utils.ternary(xi.settings.main.ENABLE_ABYSSEA == 1, 50000,  999999) },
            [7] = { id = 3331,  rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_ABYSSEA == 1, 15000,  999999) },
        },
    },
    [2] = -- Smithing
    {
        ["Keyitems"] =
        {
            [0] = { id = xi.ki.METAL_PURIFICATION,    rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 40000, 999999) },
            [1] = { id = xi.ki.METAL_ENSORCELLMENT,   rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 40000, 999999) },
            [2] = { id = xi.ki.CHAINWORK,             rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 10000, 999999) },
            [3] = { id = xi.ki.SHEETING,              rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 10000, 999999) },
            [4] = { id = xi.ki.WAY_OF_THE_BLACKSMITH, rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_SOA == 1, 20000, 999999) },
        },
        ["Items"] =
        {
            [0] = { id = 15445, rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     10000,  999999) },
            [1] = { id = 14831, rank = 5, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     70000,  999999) },
            [2] = { id = 14393, rank = 7, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     100000, 999999) },
            [3] = { id = 153,   rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     150000, 999999) },
            [4] = { id = 334,   rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_TOAU == 1,    200000, 999999) },
            [5] = { id = 15820, rank = 6, cost = utils.ternary(xi.settings.main.ENABLE_WOTG == 1,    80000,  999999) },
            [6] = { id = 3661,  rank = 7, cost = utils.ternary(xi.settings.main.ENABLE_ABYSSEA == 1, 50000,  999999) },
            [7] = { id = 3324,  rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_ABYSSEA == 1, 15000,  999999) },
        },
    },
    [3] = -- Goldsmithing
    {
        ["Keyitems"] =
        {
            [0] = { id = xi.ki.GOLD_PURIFICATION,    rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,  40000, 999999) },
            [1] = { id = xi.ki.GOLD_ENSORCELLMENT,   rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,  40000, 999999) },
            [2] = { id = xi.ki.CHAINWORK,            rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,  10000, 999999) },
            [3] = { id = xi.ki.SHEETING,             rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,  10000, 999999) },
            [4] = { id = xi.ki.CLOCKMAKING,          rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_TOAU == 1, 10000, 999999) },
            [5] = { id = xi.ki.WAY_OF_THE_GOLDSMITH, rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_SOA == 1,  20000, 999999) },
        },
        ["Items"] =
        {
            [0] = { id = 15446, rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     10000,  999999) },
            [1] = { id = 13945, rank = 5, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     70000,  999999) },
            [2] = { id = 14394, rank = 7, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     100000, 999999) },
            [3] = { id = 151,   rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     150000, 999999) },
            [4] = { id = 335,   rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_TOAU == 1,    200000, 999999) },
            [5] = { id = 15821, rank = 6, cost = utils.ternary(xi.settings.main.ENABLE_WOTG == 1,    80000,  999999) },
            [6] = { id = 3595,  rank = 7, cost = utils.ternary(xi.settings.main.ENABLE_ABYSSEA == 1, 50000,  999999) },
            [7] = { id = 3325,  rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_ABYSSEA == 1, 15000,  999999) },
        },
    },
    [4] = -- Clothcraft
    {
        ["Keyitems"] =
        {
            [0] = { id = xi.ki.CLOTH_PURIFICATION,  rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 40000, 999999) },
            [1] = { id = xi.ki.CLOTH_ENSORCELLMENT, rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 40000, 999999) },
            [2] = { id = xi.ki.SPINNING,            rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 10000, 999999) },
            [3] = { id = xi.ki.FLETCHING,           rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 10000, 999999) },
            [4] = { id = xi.ki.WAY_OF_THE_WEAVER,   rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_SOA == 1, 20000, 999999) },
        },
        ["Items"] =
        {
            [0] = { id = 15447, rank = 4, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     10000,  999999) },
            [1] = { id = 13946, rank = 5, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     70000,  999999) },
            [2] = { id = 14395, rank = 7, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     100000, 999999) },
            [3] = { id = 198,   rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     150000, 999999) },
            [4] = { id = 337,   rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_TOAU == 1,    200000, 999999) },
            [5] = { id = 15822, rank = 6, cost = utils.ternary(xi.settings.main.ENABLE_WOTG == 1,    80000,  999999) },
            [6] = { id = 3665,  rank = 7, cost = utils.ternary(xi.settings.main.ENABLE_ABYSSEA == 1, 50000,  999999) },
            [7] = { id = 3327,  rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_ABYSSEA == 1, 15000,  999999) },
        },
    },
    [5] = -- Leathercraft
    {
        ["Keyitems"] =
        {
            [0] = { id = xi.ki.LEATHER_PURIFICATION,  rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 40000, 999999) },
            [1] = { id = xi.ki.LEATHER_ENSORCELLMENT, rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 40000, 999999) },
            [2] = { id = xi.ki.TANNING,               rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 10000, 999999) },
            [3] = { id = xi.ki.WAY_OF_THE_TANNER,     rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_SOA == 1, 20000, 999999) },
        },
        ["Items"] =
        {
            [0] = { id = 15448, rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     10000,  999999) },
            [1] = { id = 14832, rank = 5, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     70000,  999999) },
            [2] = { id = 14396, rank = 7, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     100000, 999999) },
            [3] = { id = 202,   rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     150000, 999999) },
            [4] = { id = 339,   rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_TOAU == 1,    200000, 999999) },
            [5] = { id = 15823, rank = 6, cost = utils.ternary(xi.settings.main.ENABLE_WOTG == 1,    80000,  999999) },
            [6] = { id = 3668,  rank = 7, cost = utils.ternary(xi.settings.main.ENABLE_ABYSSEA == 1, 50000,  999999) },
            [7] = { id = 3329,  rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_ABYSSEA == 1, 15000,  999999) },
        },
    },
    [6] = -- Bonecraft
    {
        ["Keyitems"] =
        {
            [0] = { id = xi.ki.BONE_PURIFICATION,     rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 40000, 999999) },
            [1] = { id = xi.ki.BONE_ENSORCELLMENT,    rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 40000, 999999) },
            [2] = { id = xi.ki.FILING,                rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 10000, 999999) },
            [3] = { id = xi.ki.WAY_OF_THE_BONEWORKER, rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_SOA == 1, 20000, 999999) },
        },
        ["Items"] =
        {
            [0] = { id = 15449, rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     10000,  999999) },
            [1] = { id = 13947, rank = 5, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     70000,  999999) },
            [2] = { id = 14397, rank = 7, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     100000, 999999) },
            [3] = { id = 142,   rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     150000, 999999) },
            [4] = { id = 336,   rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_TOAU == 1,    200000, 999999) },
            [5] = { id = 15824, rank = 6, cost = utils.ternary(xi.settings.main.ENABLE_WOTG == 1,    80000,  999999) },
            [6] = { id = 3663,  rank = 7, cost = utils.ternary(xi.settings.main.ENABLE_ABYSSEA == 1, 50000,  999999) },
            [7] = { id = 3326,  rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_ABYSSEA == 1, 15000,  999999) },
        },
    },
    [7] = -- Alchemy
    {
        ["Keyitems"] =
        {
            [0] = { id = xi.ki.ANIMA_SYNTHESIS,        rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,  20000, 999999) },
            [1] = { id = xi.ki.ALCHEMIC_PURIFICATION,  rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,  40000, 999999) },
            [2] = { id = xi.ki.ALCHEMIC_ENSORCELLMENT, rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,  40000, 999999) },
            [3] = { id = xi.ki.TRITURATION,            rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,  10000, 999999) },
            [4] = { id = xi.ki.CONCOCTION,             rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,  20000, 999999) },
            [5] = { id = xi.ki.IATROCHEMISTRY,         rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_TOAU == 1, 10000, 999999) },
            [6] = { id = xi.ki.WAY_OF_THE_ALCHEMIST,   rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_SOA == 1,  20000, 999999) },
        },
        ["Items"] =
        {
            [0] = { id = 15450, rank = 4, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     10000,  999999) },
            [1] = { id = 17058, rank = 5, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     70000,  999999) },
            [2] = { id = 14398, rank = 7, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     100000, 999999) },
            [3] = { id = 134,   rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     150000, 999999) },
            [4] = { id = 342,   rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_TOAU == 1,    200000, 999999) },
            [5] = { id = 15825, rank = 6, cost = utils.ternary(xi.settings.main.ENABLE_WOTG == 1,    80000,  999999) },
            [6] = { id = 3674,  rank = 7, cost = utils.ternary(xi.settings.main.ENABLE_ABYSSEA == 1, 50000,  999999) },
            [7] = { id = 3332,  rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_ABYSSEA == 1, 15000,  999999) },
        },
    },
    [8] = -- Cooking
    {
        ["Keyitems"] =
        {
            [0] = { id = xi.ki.RAW_FISH_HANDLING,     rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 30000, 999999) },
            [1] = { id = xi.ki.NOODLE_KNEADING,       rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 30000, 999999) },
            [2] = { id = xi.ki.PATISSIER,             rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 8000,  999999) },
            [3] = { id = xi.ki.STEWPOT_MASTERY,       rank = 3, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1, 30000, 999999) },
            [4] = { id = xi.ki.WAY_OF_THE_CULINARIAN, rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_SOA == 1, 20000, 999999) },
        },
        ["Items"] =
        {
            [0] = { id = 15451, rank = 4, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     10000,  999999) },
            [1] = { id = 13948, rank = 5, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     70000,  999999) },
            [2] = { id = 14399, rank = 7, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     100000, 999999) },
            [3] = { id = 137,   rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_COP == 1,     150000, 999999) },
            [4] = { id = 338,   rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_TOAU == 1,    200000, 999999) },
            [5] = { id = 15826, rank = 6, cost = utils.ternary(xi.settings.main.ENABLE_WOTG == 1,    80000,  999999) },
            [6] = { id = 3667,  rank = 7, cost = utils.ternary(xi.settings.main.ENABLE_ABYSSEA == 1, 50000,  999999) },
            [7] = { id = 3328,  rank = 9, cost = utils.ternary(xi.settings.main.ENABLE_ABYSSEA == 1, 15000,  999999) },
        },
    },
}

-----------------------------------
-- isGuildMember Action
-----------------------------------
xi.crafting.hasJoinedGuild = function(player, guildId)
    local joinedGuildMask = player:getCharVar("Guild_Member")

    return utils.mask.getBit(joinedGuildMask, guildId)
end

xi.crafting.signupGuild = function(player, guildId)
    player:incrementCharVar("Guild_Member", bit.lshift(1, guildId))
end

-----------------------------------
-- getTestItem Action
-----------------------------------

xi.crafting.getTestItem = function(player, npc, craftID)
    local nextRank  = player:getSkillRank(craftID) + 1

    return testItemsByNPC[npc:getName()][nextRank]
end

-- canGetNewRank Action
local function canGetNewRank(player, skillLvl, craftId)
    local requiredSkill = requiredSkillForRank[player:getSkillRank(craftId)]

    if
        requiredSkill and
        skillLvl >= requiredSkill
    then
        return true
    end

    return false
end

-----------------------------------
-- tradeTestItem Action
-----------------------------------

xi.crafting.tradeTestItem = function(player, npc, trade, craftID)
    local guildID    = craftID - 48
    local skillLvL   = player:getSkillLevel(craftID)
    local testItemId = xi.crafting.getTestItem(player, npc, craftID)
    local newRank    = 0

    if
        canGetNewRank(player, skillLvL, craftID) and
        npcUtil.tradeHasExactly(trade, testItemId)
    then
        newRank = player:getSkillRank(craftID) + 1

        if player:getCharVar('[GUILD]currentGuild') == guildID + 1 then
            player:setCharVar('[GUILD]daily_points', 1)
        end
    end

    return newRank
end

-- 1: test item
-- 2: skill point
-- 3: ??
-- 4: 0 Not in the guild 1 In the guild
-- 7: 0 Not in a guild already, 11: Multiple guilds

-----------------------------------
-- getCraftSkillCap
-----------------------------------
xi.crafting.getCraftSkillCap = function(player, craftID)
    local rank = player:getSkillRank(craftID)
    return (rank + 1) * 10
end

xi.crafting.getRealSkill = function(player, craftID)
    return math.floor(player:getCharSkillLevel(craftID) / 10)
end

-----------------------------------
-- getAdvImageSupportCost
-----------------------------------
xi.crafting.getAdvImageSupportCost = function(player, craftID)
    local rank = player:getSkillRank(craftID)
    return (rank + 1) * 30
end

-----------------------------------
-- unionRepresentative
-----------------------------------
xi.crafting.unionRepresentativeTrigger = function(player, guildId, csid, currency, keyitems)
    local gpItem, remainingPoints = player:getCurrentGPItem(guildId)
    local rank   = player:getSkillRank(guildId + 48)
    local cap    = (rank + 1) * 10
    local kibits = 0
    local rewardTable = xi.crafting.gpRewards[guildId]["Keyitems"]

    for kbit, ki in pairs(rewardTable) do
        if rank >= ki.rank then
            if not player:hasKeyItem(ki.id) then
                kibits = bit.bor(kibits, bit.lshift(1, kbit))
            end
        end
    end

    player:startEvent(csid, player:getCurrency(currency), player:getCharVar('[GUILD]currentGuild') - 1, gpItem, remainingPoints, cap, 0, kibits)
end

xi.crafting.unionRepresentativeEventUpdateRenounce = function(player, craftID)
    local ID = zones[player:getZoneID()]

    player:setSkillRank(craftID, 6)
    player:setSkillLevel(craftID, 700)
    player:messageSpecial(ID.text.RENOUNCE_CRAFTSMAN, 0, craftID - 49)
end

xi.crafting.unionRepresentativeTriggerRenounceCheck = function(player, eventId, realSkill, rankCap, param3)
    if player:getLocalVar("renounceDialog") == 0 then
        local count   = 0
        local bitmask = 0

        for craftID = xi.skill.WOODWORKING, xi.skill.COOKING do
            local rank = player:getSkillRank(craftID)
            if rank < 7 then
                bitmask = bit.bor(bitmask, bit.lshift(1, craftID - 48))
            else
                count = count + 1
            end
        end

        if count > 1 then
            player:setLocalVar("renounceDialog", 1)
            player:startEvent(eventId, VanadielTime(), realSkill, rankCap, param3, 0, 0, count, bitmask)
            return true
        end
    end

    return false
end

xi.crafting.unionRepresentativeTriggerFinish = function(player, option, target, guildID, currency)
    local rank     = player:getSkillRank(guildID + 48)
    local category = bit.band(bit.rshift(option, 2), 3)
    local text     = zones[player:getZoneID()].text

    if bit.tobit(option) == -1 and rank >= 3 then
        local oldGuild = player:getCharVar('[GUILD]currentGuild') - 1
        player:setCharVar('[GUILD]currentGuild', guildID + 1)

        if oldGuild == -1 then
            player:messageSpecial(text.GUILD_NEW_CONTRACT, guildID)
        else
            player:messageSpecial(text.GUILD_TERMINATE_CONTRACT, guildID, oldGuild)
            player:setCharVar('[GUILD]daily_points', 1)
        end
    elseif category == 3 then -- keyitem
        local keyItemTable = xi.crafting.gpRewards[guildID]["Keyitems"]
        local ki           = keyItemTable[bit.band(bit.rshift(option, 5), 15) - 1]

        if ki and rank >= ki.rank then
            if utils.ternary(ki.cost == 999999, false, player:getCurrency(currency) >= ki.cost) then
                player:delCurrency(currency, ki.cost)
                npcUtil.giveKeyItem(player, ki.id)
            else
                player:messageText(target, text.NOT_HAVE_ENOUGH_GP, false, 6)
                if ki.cost == 999999 then
                    player:PrintToPlayer("This key item is out of era, no points have been deducted.", xi.msg.channel.UNKNOWN_32, "")
                end
            end
        end
    elseif category == 2 or category == 1 then -- item
        local idx       = bit.band(option, 3)
        local itemTable = xi.crafting.gpRewards[guildID]["Items"]
        local i         = itemTable[(category - 1) * 4 + idx]
        local quantity  = math.min(bit.rshift(option, 9), 12)
        local cost      = quantity * i.cost

        if i and rank >= i.rank then
            if utils.ternary(cost == 999999, false, player:getCurrency(currency) >= cost) then
                local delivered = 0
                for count = 1, quantity do -- addItem does not appear to honor quantity if the item doesn't stack.
                    if player:addItem(i.id, true) then
                        player:delCurrency(currency, i.cost)
                        player:messageSpecial(text.ITEM_OBTAINED, i.id)
                        delivered = delivered + 1
                    end
                end

                if delivered == 0 then
                    player:messageSpecial(text.ITEM_CANNOT_BE_OBTAINED, i.id)
                end
            else
                player:messageText(target, text.NOT_HAVE_ENOUGH_GP, false, 6)
                if cost == 999999 then
                    player:PrintToPlayer("This item is out of era, no points have been deducted.", xi.msg.channel.UNKNOWN_32, "")
                end
            end
        end
    elseif category == 0 and option ~= 1073741824 then -- HQ crystal
        local i = hqCrystals[bit.band(bit.rshift(option, 5), 15)]
        local quantity = bit.rshift(option, 9)
        local cost = quantity * i.cost

        if i and rank >= 3 then
            if
                player:getCurrency(currency) >= cost and
                npcUtil.giveItem(player, { { i.id, quantity } })
            then
                player:delCurrency(currency, cost)
            else
                player:messageText(target, text.NOT_HAVE_ENOUGH_GP, false, 6)
            end
        end
    end
end

xi.crafting.unionRepresentativeTrade = function(player, npc, trade, csid, guildID)
    local _, remainingPoints = player:getCurrentGPItem(guildID)
    local text = zones[player:getZoneID()].text

    if player:getCharVar('[GUILD]currentGuild') - 1 == guildID then
        if remainingPoints == 0 then
            player:messageText(npc, text.NO_MORE_GP_ELIGIBLE)
        else
            local totalPoints = 0
            for i = 0, 8 do
                local items, points = player:addGuildPoints(guildID, i)

                if items ~= 0 and points ~= 0 then
                    totalPoints = totalPoints + points
                    trade:confirmSlot(i, items)
                end
            end

            if totalPoints > 0 then
                player:confirmTrade()
                player:startEvent(csid, totalPoints)
            end
        end
    end
end
