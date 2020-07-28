-------------------------------------------------
--    Crafting functions
--  Info from:
--      http://wiki.ffxiclopedia.org/wiki/Crafts_%26_Hobbies
-------------------------------------------------

-----------------------------------
-- IDs for signupGuild bitmask
-----------------------------------

guild =
{
    ["alchemy"]      = 2,
    ["bonecraft"]    = 4,
    ["clothcraft"]   = 8,
    ["cooking"]      = 16,
    ["fishing"]      = 32,
    ["goldsmithing"] = 64,
    ["leathercraft"] = 128,
    ["smithing"]     = 256,
    ["woodworking"]  = 512
    -- Synergy not implemented yet
}

-----------------------------------
-- Table for Test Item
-----------------------------------

local TI_Alchemy = {937, 4157, 4163, 947, 16543, 4116, 16479, 4120, 16609, 10792}
local TI_Bonecraft = {13442, 13441, 13323, 13459, 13091, 17299, 16420, 12508, 13987, 11058} --  Way of The Boneworker + Hajduk Ring
local TI_Clothcraft = {13583, 13584, 13204, 13075, 12723, 13586, 13752, 12612, 14253, 11000}
local TI_Cooking = {4355, 4416, 4489, 4381, 4413, 4558, 4546, 4440, 4561, } -- Sprightly Soup + Way of the Culinarian
local TI_Fishing = {4401, 4379, 4469, 4480, 4462, 4479, 4471, 4478, 4474, 5817, } -- Tiger shark
local TI_Goldsmithing = {12496, 12497, 12495, 13082, 13446, 13084, 12545, 13125, 16515, } --  Evader Earring**Guild item must be made with an Inferno Crystal
local TI_Leathercraft = {13594, 16386, 13588, 13195, 12571, 12572, 12980, 12702, 12447, } --  Urja Trousers(Signed with Terra Crystal)
local TI_Smithing = {16530, 12299, 16512, 16650, 16651, 16559, 12427, 16577, 12428, } -- Gorkhali Kukri
local TI_Woodworking = {22, 23, 17354, 17348, 17053, 17156, 17054, 56, 17101, } -- Vejovis wand signed
local TI_Synergy = {}

local HQCrystals = {
    [1] = {
        id = 4238,
        cost = 200
    },
    [2] = {
        id = 4239,
        cost = 200
    },
    [3] = {
        id = 4240,
        cost = 200
    },
    [4] = {
        id = 4241,
        cost = 200
    },
    [5] = {
        id = 4242,
        cost = 200
    },
    [6] = {
        id = 4243,
        cost = 200
    },
    [7] = {
        id = 4244,
        cost = 500
    },
    [8] = {
        id = 4245,
        cost = 500
    },
}

-----------------------------------
-- isGuildMember Action
-----------------------------------

function isGuildMember(player, guild)

    local guildOK = player:getCharVar("Guild_Member")
    local bit = {}

    for i = 12, 1, -1 do
        twop = 2^i

        if (guildOK >= twop) then
            bit[i]=1 guildOK = guildOK - twop
        else
            bit[i]=0
        end
        --printf("bit %u: %u", i, bit[i])
    end

    return bit[guild]

end

-----------------------------------
-- signupGuild Action
-----------------------------------

function signupGuild(player, nbr)
    player:addCharVar("Guild_Member", nbr)
end

-----------------------------------
-- getTestItem Action
-----------------------------------

function getTestItem(player, npc, craftID)

    local TItemList = {}
    local NextRank = player:getSkillRank(craftID) + 1

    switch (npc:getName()): caseof
    {
        ["Abd-al-Raziq"] = function (x)     TItemList = TI_Alchemy end,
        ["Peshi_Yohnts"] = function (x)     TItemList = TI_Bonecraft end,
        ["Ponono"] = function (x)             TItemList = TI_Clothcraft end,
        ["Piketo-Puketo"] = function (x)     TItemList = TI_Cooking end,
        ["Thubu_Parohren"] = function (x)     TItemList = TI_Fishing end,
        ["Reinberta"] = function (x)         TItemList = TI_Goldsmithing end,
        ["Faulpie"] = function (x)             TItemList = TI_Leathercraft end,
        ["Mevreauche"] = function (x)         TItemList = TI_Smithing end,
        ["Ghemp"] = function (x)             TItemList = TI_Smithing end,
        ["Cheupirudaux"] = function (x)     TItemList = TI_Woodworking end,
    }

    return TItemList[NextRank]
end

-----------------------------------
-- canGetNewRank Action
-----------------------------------

function canGetNewRank(player, skillLvL, craftID)

    local Rank = player:getSkillRank(craftID) + 1
    local canGet = 0

    -- 0 fonctionne pas en lua donc rank + 1
    if (Rank == 1 and skillLvL >= 256 or
       Rank == 2 and skillLvL >= 577 or
       Rank == 3 and skillLvL >= 898 or
       Rank == 4 and skillLvL >= 1219 or
       Rank == 5 and skillLvL >= 1540 or
       Rank == 6 and skillLvL >= 1861 or
       Rank == 7 and skillLvL >= 2182 or
       Rank == 8 and skillLvL >= 2503 or
       Rank == 9 and skillLvL >= 2824) then
--       Rank == 10 and skillLvL >= 3145) then
            canGet = 1
    end

    return canGet

end

-----------------------------------
-- tradeTestItem Action
-----------------------------------

function tradeTestItem(player, npc, trade, craftID)

    local guildID = craftID - 48
    local skillLvL = player:getSkillLevel(craftID)
    local myTI = getTestItem(player, npc, craftID)
    local newRank = 0

    if (canGetNewRank(player, skillLvL, craftID) == 1 and
        trade:hasItemQty(myTI, 1) and
        trade:getItemCount() == 1) then
        newRank = player:getSkillRank(craftID) + 1
        player:tradeComplete()
        if player:getCharVar('[GUILD]currentGuild') == guildID + 1 then
            player:setCharVar('[GUILD]daily_points', -1)
        end
    end

    return newRank

end

-- 1: test item
-- 2: skill point
-- 3: ??
-- 4: 0 pas dans la guilde 1 dans la guilde
-- 7: 0 pas deja dans une guilde, 11: nombreuse guilde

-----------------------------------
-- getCraftSkillCap
-----------------------------------
function getCraftSkillCap(player, craftID)

    local Rank = player:getSkillRank(craftID)
    return (Rank+1)*10

end

-----------------------------------
-- getAdvImageSupportCost
-----------------------------------
function getAdvImageSupportCost(player, craftID)

    local Rank = player:getSkillRank(craftID)
    return (Rank+1)*30

end

function unionRepresentativeTrigger(player, guildID, csid, currency, keyitems)
    local gpItem, remainingPoints = player:getCurrentGPItem(guildID)
    local rank = player:getSkillRank(guildID + 48)
    local cap = (rank + 1) * 10
    local kibits = 0

    for kbit, ki in pairs(keyitems) do
        if (rank >= ki.rank) then
            if not player:hasKeyItem(ki.id) then
                kibits = bit.bor(kibits, bit.lshift(1, kbit))
            end
        end
    end

    player:startEvent(csid, player:getCurrency(currency), player:getCharVar('[GUILD]currentGuild') - 1, gpItem, remainingPoints, cap, 0, kibits)
end

function unionRepresentativeTriggerFinish(player, option, target, guildID, currency, keyitems, items)
    local rank = player:getSkillRank(guildID + 48)
    local category = bit.band(bit.rshift(option, 2), 3)
    local text = zones[player:getZoneID()].text

    if (bit.tobit(option) == -1 and rank >= 3) then
        local oldGuild = player:getCharVar('[GUILD]currentGuild') - 1
        player:setCharVar('[GUILD]currentGuild', guildID + 1)

        if (oldGuild == -1) then
            player:messageSpecial(text.GUILD_NEW_CONTRACT, guildID)
        else
            player:messageSpecial(text.GUILD_TERMINATE_CONTRACT, guildID, oldGuild)
            player:setCharVar('[GUILD]daily_points', -1)
        end
    elseif (category == 3) then -- keyitem
        local ki = keyitems[bit.band(bit.rshift(option, 5), 15) - 1]
        if (ki and rank >= ki.rank) then
            if (player:getCurrency(currency) >= ki.cost) then
                player:delCurrency(currency, ki.cost)
                player:addKeyItem(ki.id)
                player:messageSpecial(text.KEYITEM_OBTAINED, ki.id)
            else
               player:messageText(target, text.NOT_HAVE_ENOUGH_GP, false, 6)
            end
        end
    elseif (category == 2 or category == 1) then -- item
        local idx = bit.band(option, 3)
        local i = items[(category - 1) * 4 + idx]
        local quantity = math.min(bit.rshift(option, 9), 12)
        local cost = quantity * i.cost
        if (i and rank >= i.rank) then
            if (player:getCurrency(currency) >= cost) then
                local delivered = 0
                for count = 1, quantity do -- addItem does not appear to honor quantity if the item doesn't stack.
                    if (player:addItem(i.id, true)) then
                        player:delCurrency(currency, i.cost)
                        player:messageSpecial(text.ITEM_OBTAINED, i.id)
                        delivered = delivered + 1
                    end
                end
                if (delivered == 0) then
                    player:messageSpecial(text.ITEM_CANNOT_BE_OBTAINED, i.id)
                end
            else
               player:messageText(target, text.NOT_HAVE_ENOUGH_GP, false, 6)
            end
        end
    elseif (category == 0 and option ~= 1073741824) then -- HQ crystal
        local i = HQCrystals[bit.band(bit.rshift(option, 5), 15)]
        local quantity = bit.rshift(option, 9)
        local cost = quantity * i.cost
        if (i and rank >= 3) then
            if (player:getCurrency(currency) >= cost) then
                if (player:addItem(i.id, quantity)) then
                    player:delCurrency(currency, cost)
                    player:messageSpecial(text.ITEM_OBTAINED, i.id)
                else
                    player:messageSpecial(text.ITEM_CANNOT_BE_OBTAINED, i.id)
                end
            else
               player:messageText(target, text.NOT_HAVE_ENOUGH_GP, false, 6)
            end
        end
    end
end

function unionRepresentativeTrade(player, npc, trade, csid, guildID)
    local gpItem, remainingPoints = player:getCurrentGPItem(guildID)
    local text = zones[player:getZoneID()].text

    if (player:getCharVar('[GUILD]currentGuild') - 1 == guildID) then
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
            if (totalPoints > 0) then
                player:confirmTrade()
                player:startEvent(csid, totalPoints)
            end
        end
    end
end
