-----------------------------------
-- Crafting Guilds
-- Ref: http://wiki.ffxiclopedia.org/wiki/Crafts_%26_Hobbies
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.crafting = {}

-- Ordered by ACTUAL guild ID.
-- I'll change the actual numbers later, once I get to guild masters and I make sure I dont break stuff.
xi.crafting.guild =
{
    FISHING      = 5,
    WOODWORKING  = 9,
    SMITHING     = 8,
    GOLDSMITHING = 6,
    CLOTHCRAFT   = 3,
    LEATHERCRAFT = 7,
    BONECRAFT    = 2,
    ALCHEMY      = 1,
    COOKING      = 4,
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

xi.crafting.guildTable =
{
    -- [guildId] = { skill used,   'currency used'      },
    [0] = { xi.skill.FISHING,      'guild_fishing'      },
    [1] = { xi.skill.WOODWORKING,  'guild_woodworking'  },
    [2] = { xi.skill.SMITHING,     'guild_smithing'     },
    [3] = { xi.skill.GOLDSMITHING, 'guild_goldsmithing' },
    [4] = { xi.skill.CLOTHCRAFT,   'guild_weaving'      },
    [5] = { xi.skill.LEATHERCRAFT, 'guild_leathercraft' },
    [6] = { xi.skill.BONECRAFT,    'guild_bonecraft'    },
    [7] = { xi.skill.ALCHEMY,      'guild_alchemy'      },
    [8] = { xi.skill.COOKING,      'guild_cooking'      },
}

-- Keys are based on the player's current rank in the guild in order to be eligible
-- for the next rank-up test.  Example: At Amateur, a value of 256 is required to
-- be eligible for the test to move to Recruit

-- This magic numbers make no sense to me. At all.
-- Example:
-- At rank Amateur (Very first rank): I should have (in the database) 80+ skill points, AKA, lvl 8+ to be eligible for next rank.
-- At rank Craftsman (Last rank before the specialitation): I should have 680+ skill points, AKA lvl 68+ to be eligible for next rank.
-- So what does 256 or 2182 even mean?
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
    ['Abd-al-Raziq']   = {   937,  4157,  4163,   947, 16543,  4116, 16479,  4120, 16609, 10792 },
    ['Peshi_Yohnts']   = { 13442, 13441, 13323, 13459, 13091, 17299, 16420, 12508, 13987, 11058 },
    ['Ponono']         = { 13583, 13584, 13204, 13075, 12723, 13586, 13752, 12612, 14253, 11000 },
    ['Piketo-Puketo']  = {  4355,  4416,  4489,  4381,  4413,  4558,  4546,  4440,  4561,  5930 },
    ['Thubu_Parohren'] = {  4401,  4379,  4469,  4480,  4462,  4479,  4471,  4478,  4474,  5817 },
    ['Reinberta']      = { 12496, 12497, 12495, 13082, 13446, 13084, 12545, 13125, 16515, 11060 },
    ['Faulpie']        = { 13594, 16386, 13588, 13195, 12571, 12572, 12980, 12702, 12447, 10577 },
    ['Mevreauche']     = { 16530, 12299, 16512, 16650, 16651, 16559, 12427, 16577, 12428, 19788 },
    ['Ghemp']          = { 16530, 12299, 16512, 16650, 16651, 16559, 12427, 16577, 12428, 19788 },
    ['Cheupirudaux']   = {    22,    23, 17354, 17348, 17053, 17156, 17054,    56, 17101, 18884 },
}

local hqCrystals =
{
    [0] = { id = xi.item.ROBBER_RIG,       cost = 1500 }, -- Robber Rig is located in category 3. Not a typo.
    [1] = { id = xi.item.INFERNO_CRYSTAL,  cost =  200 },
    [2] = { id = xi.item.GLACIER_CRYSTAL,  cost =  200 },
    [3] = { id = xi.item.CYCLONE_CRYSTAL,  cost =  200 },
    [4] = { id = xi.item.TERRA_CRYSTAL,    cost =  200 },
    [5] = { id = xi.item.PLASMA_CRYSTAL,   cost =  200 },
    [6] = { id = xi.item.TORRENT_CRYSTAL,  cost =  200 },
    [7] = { id = xi.item.AURORA_CRYSTAL,   cost =  500 },
    [8] = { id = xi.item.TWILIGHT_CRYSTAL, cost =  500 },
}

local guildKeyItemTable =
{
    [0] = -- Fishing
    {
        [0] = { id = xi.ki.FROG_FISHING,    rank = xi.crafting.rank.NOVICE,  cost =  30000 },
        [1] = { id = xi.ki.SERPENT_RUMORS,  rank = xi.crafting.rank.ADEPT,   cost =  95000 },
        [2] = { id = xi.ki.MOOCHING,        rank = xi.crafting.rank.VETERAN, cost = 115000 },
        [3] = { id = xi.ki.ANGLERS_ALMANAC, rank = xi.crafting.rank.VETERAN, cost =  20000 },
    },
    [1] = -- Woodworking
    {
        [0] = { id = xi.ki.WOOD_PURIFICATION,    rank = xi.crafting.rank.NOVICE,  cost = 40000 },
        [1] = { id = xi.ki.WOOD_ENSORCELLMENT,   rank = xi.crafting.rank.NOVICE,  cost = 40000 },
        [2] = { id = xi.ki.LUMBERJACK,           rank = xi.crafting.rank.NOVICE,  cost = 10000 },
        [3] = { id = xi.ki.BOLTMAKER,            rank = xi.crafting.rank.NOVICE,  cost = 10000 },
        [4] = { id = xi.ki.WAY_OF_THE_CARPENTER, rank = xi.crafting.rank.VETERAN, cost = 20000 },
    },
    [2] = -- Smithing
    {
        [0] = { id = xi.ki.METAL_PURIFICATION,    rank = xi.crafting.rank.NOVICE,  cost = 40000 },
        [1] = { id = xi.ki.METAL_ENSORCELLMENT,   rank = xi.crafting.rank.NOVICE,  cost = 40000 },
        [2] = { id = xi.ki.CHAINWORK,             rank = xi.crafting.rank.NOVICE,  cost = 10000 },
        [3] = { id = xi.ki.SHEETING,              rank = xi.crafting.rank.NOVICE,  cost = 10000 },
        [4] = { id = xi.ki.WAY_OF_THE_BLACKSMITH, rank = xi.crafting.rank.VETERAN, cost = 20000 },
    },
    [3] = -- Goldsmithing
    {
        [0] = { id = xi.ki.GOLD_PURIFICATION,    rank = xi.crafting.rank.NOVICE,  cost = 40000 },
        [1] = { id = xi.ki.GOLD_ENSORCELLMENT,   rank = xi.crafting.rank.NOVICE,  cost = 40000 },
        [2] = { id = xi.ki.CHAINWORK,            rank = xi.crafting.rank.NOVICE,  cost = 10000 },
        [3] = { id = xi.ki.SHEETING,             rank = xi.crafting.rank.NOVICE,  cost = 10000 },
        [4] = { id = xi.ki.CLOCKMAKING,          rank = xi.crafting.rank.NOVICE,  cost = 10000 },
        [5] = { id = xi.ki.WAY_OF_THE_GOLDSMITH, rank = xi.crafting.rank.VETERAN, cost = 20000 },
    },
    [4] = -- Clothcraft
    {
        [0] = { id = xi.ki.CLOTH_PURIFICATION,  rank = xi.crafting.rank.NOVICE,  cost = 40000 },
        [1] = { id = xi.ki.CLOTH_ENSORCELLMENT, rank = xi.crafting.rank.NOVICE,  cost = 40000 },
        [2] = { id = xi.ki.SPINNING,            rank = xi.crafting.rank.NOVICE,  cost = 10000 },
        [3] = { id = xi.ki.FLETCHING,           rank = xi.crafting.rank.NOVICE,  cost = 10000 },
        [4] = { id = xi.ki.WAY_OF_THE_WEAVER,   rank = xi.crafting.rank.VETERAN, cost = 20000 },
    },
    [5] = -- Leathercraft
    {
        [0] = { id = xi.ki.LEATHER_PURIFICATION,  rank = xi.crafting.rank.NOVICE,  cost = 40000 },
        [1] = { id = xi.ki.LEATHER_ENSORCELLMENT, rank = xi.crafting.rank.NOVICE,  cost = 40000 },
        [2] = { id = xi.ki.TANNING,               rank = xi.crafting.rank.NOVICE,  cost = 10000 },
        [3] = { id = xi.ki.WAY_OF_THE_TANNER,     rank = xi.crafting.rank.VETERAN, cost = 20000 },
    },
    [6] = -- Bonecraft
    {
        [0] = { id = xi.ki.BONE_PURIFICATION,     rank = xi.crafting.rank.NOVICE,  cost = 40000 },
        [1] = { id = xi.ki.BONE_ENSORCELLMENT,    rank = xi.crafting.rank.NOVICE,  cost = 40000 },
        [2] = { id = xi.ki.FILING,                rank = xi.crafting.rank.NOVICE,  cost = 10000 },
        [3] = { id = xi.ki.WAY_OF_THE_BONEWORKER, rank = xi.crafting.rank.VETERAN, cost = 20000 },
    },
    [7] = -- Alchemy
    {
        [0] = { id = xi.ki.ANIMA_SYNTHESIS,        rank = xi.crafting.rank.NOVICE,  cost = 20000 },
        [1] = { id = xi.ki.ALCHEMIC_PURIFICATION,  rank = xi.crafting.rank.NOVICE,  cost = 40000 },
        [2] = { id = xi.ki.ALCHEMIC_ENSORCELLMENT, rank = xi.crafting.rank.NOVICE,  cost = 40000 },
        [3] = { id = xi.ki.TRITURATION,            rank = xi.crafting.rank.NOVICE,  cost = 10000 },
        [4] = { id = xi.ki.CONCOCTION,             rank = xi.crafting.rank.NOVICE,  cost = 20000 },
        [5] = { id = xi.ki.IATROCHEMISTRY,         rank = xi.crafting.rank.NOVICE,  cost = 10000 },
        [6] = { id = xi.ki.WAY_OF_THE_ALCHEMIST,   rank = xi.crafting.rank.VETERAN, cost = 20000 },
    },
    [8] = -- Cooking
    {
        [0] = { id = xi.ki.RAW_FISH_HANDLING,     rank = xi.crafting.rank.NOVICE,  cost = 30000 },
        [1] = { id = xi.ki.NOODLE_KNEADING,       rank = xi.crafting.rank.NOVICE,  cost = 30000 },
        [2] = { id = xi.ki.PATISSIER,             rank = xi.crafting.rank.NOVICE,  cost =  8000 },
        [3] = { id = xi.ki.STEWPOT_MASTERY,       rank = xi.crafting.rank.NOVICE,  cost = 30000 },
        [4] = { id = xi.ki.WAY_OF_THE_CULINARIAN, rank = xi.crafting.rank.VETERAN, cost = 20000 },
    },
}

local guildItemTable =
{
    [0] = -- Fishing
    {
        [0] = { id = xi.item.FISHERMANS_BELT,      rank = xi.crafting.rank.APPRENTICE, cost =  10000 },
        [1] = { id = xi.item.WADERS,               rank = xi.crafting.rank.JOURNEYMAN, cost =  70000 },
        [2] = { id = xi.item.FISHERMANS_APRON,     rank = xi.crafting.rank.ARTISAN,    cost = 100000 },
        [3] = { id = xi.item.FISHING_HOLE_MAP,     rank = xi.crafting.rank.VETERAN,    cost = 150000 },
        [4] = { id = xi.item.FISHERMANS_SIGNBOARD, rank = xi.crafting.rank.VETERAN,    cost = 200000 },
        -- There is a blank space here. Robber Rig SHOULD be here, but it isnt. It's with the crystals.
        [6] = { id = xi.item.NET_AND_LURE,         rank = xi.crafting.rank.ARTISAN,    cost =  50000 },
        [7] = { id = xi.item.FISHERMENS_EMBLEM,    rank = xi.crafting.rank.VETERAN,    cost =  15000 },
    },
    [1] = -- Woodworking
    {
        [0] = { id = xi.item.CARPENTERS_BELT,      rank = xi.crafting.rank.NOVICE,     cost =  10000 },
        [1] = { id = xi.item.CARPENTERS_GLOVES,    rank = xi.crafting.rank.JOURNEYMAN, cost =  70000 },
        [2] = { id = xi.item.CARPENTERS_APRON,     rank = xi.crafting.rank.ARTISAN,    cost = 100000 },
        [3] = { id = xi.item.DRAWING_DESK,         rank = xi.crafting.rank.VETERAN,    cost = 150000 },
        [4] = { id = xi.item.CARPENTERS_SIGNBOARD, rank = xi.crafting.rank.VETERAN,    cost = 200000 },
        [5] = { id = xi.item.CARPENTERS_RING,      rank = xi.crafting.rank.CRAFTSMAN,  cost =  80000 },
        [6] = { id = xi.item.CARPENTERS_KIT,       rank = xi.crafting.rank.ARTISAN,    cost =  50000 },
        [7] = { id = xi.item.CARPENTERS_EMBLEM,    rank = xi.crafting.rank.VETERAN,    cost =  15000 },
    },
    [2] = -- Smithing
    {
        [0] = { id = xi.item.BLACKSMITHS_BELT,      rank = xi.crafting.rank.NOVICE,     cost =  10000 },
        [1] = { id = xi.item.SMITHYS_MITTS,         rank = xi.crafting.rank.JOURNEYMAN, cost =  70000 },
        [2] = { id = xi.item.BLACKSMITHS_APRON,     rank = xi.crafting.rank.ARTISAN,    cost = 100000 },
        [3] = { id = xi.item.MASTERSMITH_ANVIL,     rank = xi.crafting.rank.VETERAN,    cost = 150000 },
        [4] = { id = xi.item.BLACKSMITHS_SIGNBOARD, rank = xi.crafting.rank.VETERAN,    cost = 200000 },
        [5] = { id = xi.item.SMITHS_RING,           rank = xi.crafting.rank.CRAFTSMAN,  cost =  80000 },
        [6] = { id = xi.item.STONE_HEARTH,          rank = xi.crafting.rank.ARTISAN,    cost =  50000 },
        [7] = { id = xi.item.BLACKSMITHS_EMBLEM,    rank = xi.crafting.rank.VETERAN,    cost =  15000 },
    },
    [3] = -- Goldsmithing
    {
        [0] = { id = xi.item.GOLDSMITHS_BELT,      rank = xi.crafting.rank.NOVICE,     cost =  10000 },
        [1] = { id = xi.item.SHADED_SPECTACLES,    rank = xi.crafting.rank.JOURNEYMAN, cost =  70000 },
        [2] = { id = xi.item.GOLDSMITHS_APRON,     rank = xi.crafting.rank.ARTISAN,    cost = 100000 },
        [3] = { id = xi.item.STACK_OF_FOOLS_GOLD,  rank = xi.crafting.rank.VETERAN,    cost = 150000 },
        [4] = { id = xi.item.GOLDSMITHS_SIGNBOARD, rank = xi.crafting.rank.VETERAN,    cost = 200000 },
        [5] = { id = xi.item.GOLDSMITHS_RING,      rank = xi.crafting.rank.CRAFTSMAN,  cost =  80000 },
        [6] = { id = xi.item.GEMSCOPE,             rank = xi.crafting.rank.ARTISAN,    cost =  50000 },
        [7] = { id = xi.item.GOLDSMITHS_EMBLEM,    rank = xi.crafting.rank.VETERAN,    cost =  15000 },
    },
    [4] = -- Clothcraft
    {
        [0] = { id = xi.item.WEAVERS_BELT,          rank = xi.crafting.rank.NOVICE,     cost =  10000 },
        [1] = { id = xi.item.MAGNIFYING_SPECTACLES, rank = xi.crafting.rank.JOURNEYMAN, cost =  70000 },
        [2] = { id = xi.item.WEAVERS_APRON,         rank = xi.crafting.rank.ARTISAN,    cost = 100000 },
        [3] = { id = xi.item.GILT_TAPESTRY,         rank = xi.crafting.rank.VETERAN,    cost = 150000 },
        [4] = { id = xi.item.WEAVERS_SIGNBOARD,     rank = xi.crafting.rank.VETERAN,    cost = 200000 },
        [5] = { id = xi.item.TAILORS_RING,          rank = xi.crafting.rank.CRAFTSMAN,  cost =  80000 },
        [6] = { id = xi.item.SPINNING_WHEEL,        rank = xi.crafting.rank.ARTISAN,    cost =  50000 },
        [7] = { id = xi.item.WEAVERS_EMBLEM,        rank = xi.crafting.rank.VETERAN,    cost =  15000 },
    },
    [5] = -- Leathercraft
    {
        [0] = { id = xi.item.TANNERS_BELT,      rank = xi.crafting.rank.NOVICE,     cost =  10000 },
        [1] = { id = xi.item.TANNERS_GLOVES,    rank = xi.crafting.rank.JOURNEYMAN, cost =  70000 },
        [2] = { id = xi.item.TANNERS_APRON,     rank = xi.crafting.rank.ARTISAN,    cost = 100000 },
        [3] = { id = xi.item.GOLDEN_FLEECE,     rank = xi.crafting.rank.VETERAN,    cost = 150000 },
        [4] = { id = xi.item.TANNERS_SIGNBOARD, rank = xi.crafting.rank.VETERAN,    cost = 200000 },
        [5] = { id = xi.item.TANNERS_RING,      rank = xi.crafting.rank.CRAFTSMAN,  cost =  80000 },
        [6] = { id = xi.item.HIDE_STRETCHER,    rank = xi.crafting.rank.ARTISAN,    cost =  50000 },
        [7] = { id = xi.item.TANNERS_EMBLEM,    rank = xi.crafting.rank.VETERAN,    cost =  15000 },
    },
    [6] = -- Bonecraft
    {
        [0] = { id = xi.item.BONEWORKERS_BELT,          rank = xi.crafting.rank.NOVICE,     cost =  10000 },
        [1] = { id = xi.item.PROTECTIVE_SPECTACLES,     rank = xi.crafting.rank.JOURNEYMAN, cost =  70000 },
        [2] = { id = xi.item.BONEWORKERS_APRON,         rank = xi.crafting.rank.ARTISAN,    cost = 100000 },
        [3] = { id = xi.item.DROGAROGAS_FANG,           rank = xi.crafting.rank.VETERAN,    cost = 150000 },
        [4] = { id = xi.item.BONEWORKERS_SIGNBOARD,     rank = xi.crafting.rank.VETERAN,    cost = 200000 },
        [5] = { id = xi.item.BONECRAFTERS_RING,         rank = xi.crafting.rank.CRAFTSMAN,  cost =  80000 },
        [6] = { id = xi.item.SET_OF_BONECRAFTING_TOOLS, rank = xi.crafting.rank.ARTISAN,    cost =  50000 },
        [7] = { id = xi.item.BONEWORKERS_EMBLEM,        rank = xi.crafting.rank.VETERAN,    cost =  15000 },
    },
    [7] = -- Alchemy
    {
        [0] = { id = xi.item.ALCHEMISTS_BELT,      rank = xi.crafting.rank.NOVICE,     cost =  10000 },
        [1] = { id = xi.item.CADUCEUS,             rank = xi.crafting.rank.JOURNEYMAN, cost =  70000 },
        [2] = { id = xi.item.ALCHEMISTS_APRON,     rank = xi.crafting.rank.ARTISAN,    cost = 100000 },
        [3] = { id = xi.item.COPY_OF_EMERALDA,     rank = xi.crafting.rank.VETERAN,    cost = 150000 },
        [4] = { id = xi.item.ALCHEMISTS_SIGNBOARD, rank = xi.crafting.rank.VETERAN,    cost = 200000 },
        [5] = { id = xi.item.ALCHEMISTS_RING,      rank = xi.crafting.rank.CRAFTSMAN,  cost =  80000 },
        [6] = { id = xi.item.ALEMBIC,              rank = xi.crafting.rank.ARTISAN,    cost =  50000 },
        [7] = { id = xi.item.ALCHEMISTS_EMBLEM,    rank = xi.crafting.rank.VETERAN,    cost =  15000 },
    },
    [8] = -- Cooking
    {
        [0] = { id = xi.item.CULINARIANS_BELT,        rank = xi.crafting.rank.NOVICE,     cost =  10000 },
        [1] = { id = xi.item.CHEFS_HAT,               rank = xi.crafting.rank.JOURNEYMAN, cost =  70000 },
        [2] = { id = xi.item.CULINARIANS_APRON,       rank = xi.crafting.rank.ARTISAN,    cost = 100000 },
        [3] = { id = xi.item.CORDON_BLEU_COOKING_SET, rank = xi.crafting.rank.VETERAN,    cost = 150000 },
        [4] = { id = xi.item.CULINARIANS_SIGNBOARD,   rank = xi.crafting.rank.VETERAN,    cost = 200000 },
        [5] = { id = xi.item.CHEFS_RING,              rank = xi.crafting.rank.CRAFTSMAN,  cost =  80000 },
        [6] = { id = xi.item.BRASS_CROCK,             rank = xi.crafting.rank.ARTISAN,    cost =  50000 },
        [7] = { id = xi.item.CULINARIANS_EMBLEM,      rank = xi.crafting.rank.VETERAN,    cost =  15000 },
    },
}

xi.crafting.hasJoinedGuild = function(player, guildId)
    local joinedGuildMask = player:getCharVar('Guild_Member')

    return utils.mask.getBit(joinedGuildMask, guildId)
end

xi.crafting.signupGuild = function(player, guildId)
    player:incrementCharVar('Guild_Member', bit.lshift(1, guildId))
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
    local guildId    = craftID - 48
    local skillLvL   = player:getSkillLevel(craftID)
    local testItemId = xi.crafting.getTestItem(player, npc, craftID)
    local newRank    = 0

    if
        canGetNewRank(player, skillLvL, craftID) and
        npcUtil.tradeHasExactly(trade, testItemId)
    then
        newRank = player:getSkillRank(craftID) + 1

        if player:getCharVar('[GUILD]currentGuild') == guildId + 1 then
            player:setCharVar('[GUILD]daily_points', 1)
        end
    end

    return newRank
end

-----------------------------------
-- Guild Master event parameters
-----------------------------------
-- 1: Test item ID OR current vanadiel time.
-- 2: Player REAL Skill at current guild craft.
-- 3: Player REAL Skill cap at current guild craft.
-- 4: Bitmask. First 9 bits used for guilds joined.
    -- Bit 0 = Fishing
    -- Bit 4 = Clothcraft
    -- Bit 8 = Cooking
    -- Higher bits unknown, but used.
-- 5: Expert Quest status.
-- 6: ???
-- 7: COUNT for the number of guilds at rank ARTISAN or higher. This count seems to cycle between it and 0, for rank renouncement trigger.
-- 8: ???

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
-- Rank Renouncement functions
-----------------------------------
xi.crafting.unionRepresentativeEventUpdateRenounce = function(player, craftID)
    local ID = zones[player:getZoneID()]

    player:setSkillRank(craftID, 6)
    player:setSkillLevel(craftID, 700)
    player:messageSpecial(ID.text.RENOUNCE_CRAFTSMAN, 0, craftID - 49)
end

xi.crafting.unionRepresentativeTriggerRenounceCheck = function(player, eventId, realSkill, rankCap, param3)
    if player:getLocalVar('skipRenounceDialog') == 0 then
        local count   = 0
        local bitmask = 0

        for craftID = xi.skill.WOODWORKING, xi.skill.COOKING do
            local rank = player:getSkillRank(craftID)

            if rank >= xi.crafting.rank.ARTISAN then
                count = count + 1
            else
                -- This needs checking. Probably made-up.
                bitmask = bit.bor(bitmask, bit.lshift(1, craftID - 48))
            end
        end

        if count >= 2 then
            player:setLocalVar('skipRenounceDialog', 1)

            -- TODO: Param 3 is taken directly from captures, but now we know this is incorrect.
            -- TODO: bitmask needs checking.
            player:startEvent(eventId, VanadielTime(), realSkill, rankCap, param3, 0, 0, count, bitmask)

            return true
        end
    end

    return false
end

-----------------------------------
-- Guild Point NPCs (Union Representatives)
-----------------------------------
xi.crafting.guildPointOnTrade = function(player, npc, trade, csid, guildId)
    local ID                 = zones[player:getZoneID()]
    local _, remainingPoints = player:getCurrentGPItem(guildId)

    if player:getCharVar('[GUILD]currentGuild') - 1 == guildId then
        if remainingPoints == 0 then
            player:messageText(npc, ID.text.NO_MORE_GP_ELIGIBLE)
        else
            local totalPoints = 0
            for tradeSlot = 0, 8 do
                local items, points = player:addGuildPoints(guildId, tradeSlot)

                if items ~= 0 and points ~= 0 then
                    totalPoints = totalPoints + points
                    trade:confirmSlot(tradeSlot, items)
                end
            end

            if totalPoints > 0 then
                player:confirmTrade()
                player:startEvent(csid, totalPoints)
            end
        end
    end
end

xi.crafting.guildPointOnTrigger = function(player, csid, guildId)
    local gpItem, remainingPoints = player:getCurrentGPItem(guildId)
    local rank                    = player:getSkillRank(xi.crafting.guildTable[guildId][1])
    local skillCap                = (rank + 1) * 10
    local keyItemBits             = 0
    local currency                = xi.crafting.guildTable[guildId][2]
    local keyItems                = guildKeyItemTable[guildId]

    for currentBit, keyItem in pairs(keyItems) do
        if rank >= keyItem.rank then
            if not player:hasKeyItem(keyItem.id) then
                keyItemBits = bit.bor(keyItemBits, bit.lshift(1, currentBit))
            end
        end
    end

    player:startEvent(csid, player:getCurrency(currency), player:getCharVar('[GUILD]currentGuild') - 1, gpItem, remainingPoints, skillCap, 0, keyItemBits)
end

xi.crafting.guildPointOnEventFinish = function(player, option, target, guildId)
    local ID       = zones[player:getZoneID()]
    local rank     = player:getSkillRank(xi.crafting.guildTable[guildId][1])
    local category = bit.band(bit.rshift(option, 2), 3)
    local currency = xi.crafting.guildTable[guildId][2]
    local keyItems = guildKeyItemTable[guildId]
    local items    = guildItemTable[guildId]

    -- Contract Dialog.
    if bit.tobit(option) == -1 and rank >= 3 then
        local oldGuild = player:getCharVar('[GUILD]currentGuild') - 1
        player:setCharVar('[GUILD]currentGuild', guildId + 1)

        if oldGuild == -1 then
            player:messageSpecial(ID.text.GUILD_NEW_CONTRACT, guildId)
        else
            player:messageSpecial(ID.text.GUILD_TERMINATE_CONTRACT, guildId, oldGuild)
            player:setCharVar('[GUILD]daily_points', 1)
        end

    -- GP Key Item Option.
    elseif category == 3 then
        local keyItem = keyItems[bit.band(bit.rshift(option, 5), 15) - 1]

        if keyItem and rank >= keyItem.rank then
            if player:getCurrency(currency) >= keyItem.cost then
                player:delCurrency(currency, keyItem.cost)
                npcUtil.giveKeyItem(player, keyItem.id)
            else
                player:messageText(target, ID.text.NOT_HAVE_ENOUGH_GP, false, 6)
            end
        end

    -- GP Item Option.
    elseif category == 2 or category == 1 then
        local index    = bit.band(option, 3)
        local item     = items[(category - 1) * 4 + index]
        local quantity = math.min(bit.rshift(option, 9), 12)
        local cost     = quantity * item.cost

        if item and rank >= item.rank then
            if player:getCurrency(currency) >= cost then
                local delivered = 0

                for count = 1, quantity do -- addItem does not appear to honor quantity if the item doesn't stack.
                    if player:addItem(item.id, true) then
                        player:delCurrency(currency, item.cost)
                        player:messageSpecial(ID.text.ITEM_OBTAINED, item.id)
                        delivered = delivered + 1
                    end
                end

                if delivered == 0 then
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item.id)
                end
            else
                player:messageText(target, ID.text.NOT_HAVE_ENOUGH_GP, false, 6)
            end
        end

    -- HQ crystal Option.
    elseif
        category == 0 and
        option ~= utils.EVENT_CANCELLED_OPTION
    then
        local crystal  = hqCrystals[bit.band(bit.rshift(option, 5), 15)]
        local quantity = bit.rshift(option, 9)
        local cost     = quantity * crystal.cost

        if crystal and rank >= 3 then
            if
                player:getCurrency(currency) >= cost and
                npcUtil.giveItem(player, { { crystal.id, quantity } })
            then
                player:delCurrency(currency, cost)
            else
                player:messageText(target, ID.text.NOT_HAVE_ENOUGH_GP, false, 6)
            end
        end
    end
end
