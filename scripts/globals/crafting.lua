-----------------------------------
-- Crafting Guilds
-- Ref: http://wiki.ffxiclopedia.org/wiki/Crafts_%26_Hobbies
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.crafting = {}

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

xi.crafting.hasJoinedGuild = function(player, guildId)
    local joinedGuildMask = player:getCharVar('Guild_Member') + 1

    return utils.mask.getBit(joinedGuildMask, guildId)
end

xi.crafting.signupGuild = function(player, guildId)
    player:incrementCharVar('Guild_Member', bit.lshift(1, guildId + 1))
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
