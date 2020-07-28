-----------------------------------
-- Area: Bastok Markets
--  NPC: Ellard
-- Type: Guildworker's Union Representative
-- !pos -214.355 -7.814 -63.809 235
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Bastok_Markets/IDs")

local keyitems = {
    [0] = {
        id = tpz.ki.GOLD_PURIFICATION,
        rank = 3,
        cost = 40000
    },
    [1] = {
        id = tpz.ki.GOLD_ENSORCELLMENT,
        rank = 3,
        cost = 40000
    },
    [2] = {
        id = tpz.ki.CHAINWORK,
        rank = 3,
        cost = 10000
    },
    [3] = {
        id = tpz.ki.SHEETING,
        rank = 3,
        cost = 10000
    },
    [4] = {
        id = tpz.ki.CLOCKMAKING,
        rank = 3,
        cost = 10000
    },
    [5] = {
        id = tpz.ki.WAY_OF_THE_GOLDSMITH,
        rank = 9,
        cost = 20000
    }
}

local items = {
    [0] = {
        id = 15446,
        rank = 3,
        cost = 10000
    },
    [1] = {
        id = 13945,
        rank = 5,
        cost = 70000
    },
    [2] = {
        id = 14394,
        rank = 5,
        cost = 100000
    },
    [3] = {
        id = 151,
        rank = 9,
        cost = 150000
    },
    [4] = {
        id = 335,
        rank = 9,
        cost = 200000
    },
    [5] = {
        id = 15821,
        rank = 6,
        cost = 80000
    },
    [6] = {
        id = 3595,
        rank = 7,
        cost = 50000
    },
    [7] = {
        id = 3325,
        rank = 9,
        cost = 15000
    }
}

function onTrade(player, npc, trade)
    unionRepresentativeTrade(player, npc, trade, 341, 3)
end

function onTrigger(player, npc)
    unionRepresentativeTrigger(player, 3, 340, "guild_goldsmithing", keyitems)
end

function onEventUpdate(player, csid, option, target)
    if (csid == 340) then
        unionRepresentativeTriggerFinish(player, option, target, 3, "guild_goldsmithing", keyitems, items)
    end
end

function onEventFinish(player, csid, option, target)
    if (csid == 340) then
        unionRepresentativeTriggerFinish(player, option, target, 3, "guild_goldsmithing", keyitems, items)
    elseif (csid == 341) then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end
