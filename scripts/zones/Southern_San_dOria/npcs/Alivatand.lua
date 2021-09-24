-----------------------------------
-- Area: South San d'Oria
--  NPC: Alivatand
-- Type: Guildworker's Union Representative
-- !pos -179.458 -1 15.857 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/crafting")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

local keyitems = {
    [0] = {
        id = xi.ki.LEATHER_PURIFICATION,
        rank = 3,
        cost = 40000
    },
    [1] = {
        id = xi.ki.LEATHER_ENSORCELLMENT,
        rank = 3,
        cost = 40000
    },
    [2] = {
        id = xi.ki.TANNING,
        rank = 3,
        cost = 10000
    },
    [3] = {
        id = xi.ki.WAY_OF_THE_TANNER,
        rank = 9,
        cost = 20000
    }
}

local items = {
    [0] = {
        id = 15448, -- Tanner's Belt
        rank = 3,
        cost = 10000
    },
    [1] = {
        id = 14832, -- Tanner's Gloves
        rank = 5,
        cost = 70000
    },
    [2] = {
        id = 14396, -- Tanner's Apron
        rank = 7,
        cost = 100000
    },
    [3] = {
        id = 202, -- Golden Fleece
        rank = 9,
        cost = 150000
    },
    [4] = {
        id = 339, -- Tanner's Signboard
        rank = 9,
        cost = 200000
    },
    [5] = {
        id = 15823, -- Tanner's Ring
        rank = 6,
        cost = 80000
    },
    [6] = {
        id = 3668, -- Hide Stretcher
        rank = 7,
        cost = 50000
    },
    [7] = {
        id = 3329, -- Tanners' Emblem
        rank = 9,
        cost = 15000
    }
}

entity.onTrade = function(player, npc, trade)
    xi.crafting.unionRepresentativeTrade(player, npc, trade, 691, 5)
end

entity.onTrigger = function(player, npc)
    xi.crafting.unionRepresentativeTrigger(player, 5, 690, "guild_leathercraft", keyitems)
end

entity.onEventUpdate = function(player, csid, option, target)
    if (csid == 690) then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, target, 5, "guild_leathercraft", keyitems, items)
    end
end

entity.onEventFinish = function(player, csid, option, target)
    if (csid == 690) then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, target, 5, "guild_leathercraft", keyitems, items)
    elseif (csid == 691) then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
