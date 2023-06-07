-----------------------------------
-- Crafting Guilds
-- Ref: http://wiki.ffxiclopedia.org/wiki/Crafts_%26_Hobbies
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/keyitems')
require('scripts/globals/npc_util')
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
    [7] = { id = xi.items.AURORA_CRYSTAL,   cost = 500 },
    [8] = { id = xi.items.TWILIGHT_CRYSTAL, cost = 500 },
}

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
    if player:getLocalVar("skipRenounceDialog") == 0 then
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
            player:setLocalVar("skipRenounceDialog", 1)

            -- TODO: Param 3 is taken directly from captures, but now we know this is incorrect.
            -- TODO: bitmask needs checking.
            player:startEvent(eventId, VanadielTime(), realSkill, rankCap, param3, 0, 0, count, bitmask)

            return true
        end
    end

    return false
end

--------------------------------------------------
-- Guild Point NPCs (Union Representatives)
--------------------------------------------------
xi.crafting.unionRepresentativeTrade = function(player, npc, trade, csid, guildID)
    local _, remainingPoints = player:getCurrentGPItem(guildID)
    local ID                 = zones[player:getZoneID()]

    if player:getCharVar('[GUILD]currentGuild') - 1 == guildID then
        if remainingPoints == 0 then
            player:messageText(npc, ID.text.NO_MORE_GP_ELIGIBLE)
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

xi.crafting.unionRepresentativeTrigger = function(player, guildId, csid, currency, keyitems)
    local gpItem, remainingPoints = player:getCurrentGPItem(guildId)
    local rank                    = player:getSkillRank(guildId + 48)
    local cap                     = (rank + 1) * 10
    local kibits                  = 0

    for kbit, ki in pairs(keyitems) do
        if rank >= ki.rank then
            if not player:hasKeyItem(ki.id) then
                kibits = bit.bor(kibits, bit.lshift(1, kbit))
            end
        end
    end

    player:startEvent(csid, player:getCurrency(currency), player:getCharVar('[GUILD]currentGuild') - 1, gpItem, remainingPoints, cap, 0, kibits)
end

xi.crafting.unionRepresentativeTriggerFinish = function(player, option, target, guildID, currency, keyitems, items)
    local rank     = player:getSkillRank(guildID + 48)
    local category = bit.band(bit.rshift(option, 2), 3)
    local ID       = zones[player:getZoneID()]

    -- Contract Dialog.
    if bit.tobit(option) == -1 and rank >= 3 then
        local oldGuild = player:getCharVar('[GUILD]currentGuild') - 1
        player:setCharVar('[GUILD]currentGuild', guildID + 1)

        if oldGuild == -1 then
            player:messageSpecial(ID.text.GUILD_NEW_CONTRACT, guildID)
        else
            player:messageSpecial(ID.text.GUILD_TERMINATE_CONTRACT, guildID, oldGuild)
            player:setCharVar('[GUILD]daily_points', 1)
        end

    -- GP Key Item Option.
    elseif category == 3 then
        local ki = keyitems[bit.band(bit.rshift(option, 5), 15) - 1]

        if ki and rank >= ki.rank then
            if player:getCurrency(currency) >= ki.cost then
                player:delCurrency(currency, ki.cost)
                npcUtil.giveKeyItem(player, ki.id)
            else
                player:messageText(target, ID.text.NOT_HAVE_ENOUGH_GP, false, 6)
            end
        end

    -- GP Item Option.
    elseif category == 2 or category == 1 then
        local idx      = bit.band(option, 3)
        local i        = items[(category - 1) * 4 + idx]
        local quantity = math.min(bit.rshift(option, 9), 12)
        local cost     = quantity * i.cost

        if i and rank >= i.rank then
            if player:getCurrency(currency) >= cost then
                local delivered = 0

                for count = 1, quantity do -- addItem does not appear to honor quantity if the item doesn't stack.
                    if player:addItem(i.id, true) then
                        player:delCurrency(currency, i.cost)
                        player:messageSpecial(ID.text.ITEM_OBTAINED, i.id)
                        delivered = delivered + 1
                    end
                end

                if delivered == 0 then
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, i.id)
                end
            else
                player:messageText(target, ID.text.NOT_HAVE_ENOUGH_GP, false, 6)
            end
        end

    -- HQ crystal Option.
    elseif category == 0 and option ~= 1073741824 then
        local i        = hqCrystals[bit.band(bit.rshift(option, 5), 15)]
        local quantity = bit.rshift(option, 9)
        local cost     = quantity * i.cost

        if i and rank >= 3 then
            if
                player:getCurrency(currency) >= cost and
                npcUtil.giveItem(player, { { i.id, quantity } })
            then
                player:delCurrency(currency, cost)
            else
                player:messageText(target, ID.text.NOT_HAVE_ENOUGH_GP, false, 6)
            end
        end
    end
end
