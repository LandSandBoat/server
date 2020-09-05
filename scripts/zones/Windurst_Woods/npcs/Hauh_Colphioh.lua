-----------------------------------
-- Area: Windurst Woods
--  NPC: Hauh Colphioh
-- Type: Guildworker's Union Representative
-- !pos -38.173 -1.25 -113.679 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
require("scripts/globals/keyitems")
-----------------------------------

local keyitems = {
    [0] = {
        id = tpz.ki.CLOTH_PURIFICATION,
        rank = 3,
        cost = 40000
    },
    [1] = {
        id = tpz.ki.CLOTH_ENSORCELLMENT,
        rank = 3,
        cost = 40000
    },
    [2] = {
        id = tpz.ki.SPINNING,
        rank = 3,
        cost = 10000
    },
    [3] = {
        id = tpz.ki.FLETCHING,
        rank = 3,
        cost = 10000
    },
    [4] = {
        id = tpz.ki.WAY_OF_THE_WEAVER,
        rank = 9,
        cost = 20000
    }
}

local items = {
    [0] = {
        id = 15447, -- Weaver's Belt
        rank = 4,
        cost = 10000
    },
    [1] = {
        id = 13946, -- Magnifying Spectacles
        rank = 6,
        cost = 70000
    },
    [2] = {
        id = 14395, -- Weaver's Apron
        rank = 7,
        cost = 100000
    },
    [3] = {
        id = 198, -- Gilt Tapestry
        rank = 9,
        cost = 150000
    },
    [4] = {
        id = 337, -- Weaver's Signboard
        rank = 9,
        cost = 200000
    },
    [5] = {
        id = 15822, -- Tailor's Ring
        rank = 6,
        cost = 80000
    },
    [6] = {
        id = 3665, -- Spinning Wheel
        rank = 7,
        cost = 50000
    },
    [7] = {
        id = 3327, -- Weavers' Emblem
        rank = 9,
        cost = 15000
    }
}

function onTrade(player, npc, trade)
    unionRepresentativeTrade(player, npc, trade, 10025, 4)
end

function onTrigger(player, npc)
    unionRepresentativeTrigger(player, 4, 10024, "guild_weaving", keyitems)
end

function onEventUpdate(player, csid, option, target)
    if csid == 10024 then
        unionRepresentativeTriggerFinish(player, option, target, 4, "guild_weaving", keyitems, items)
    end
end

function onEventFinish(player, csid, option, target)
    if csid == 10024 then
        unionRepresentativeTriggerFinish(player, option, target, 4, "guild_weaving", keyitems, items)
    elseif csid == 10025 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end
