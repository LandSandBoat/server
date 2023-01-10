-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Andreas
-- Type: Guildworker's Union Representative
-- !pos -189.282 10.999 262.626 231
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/crafting")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

local keyitems =
{
    [0] = { id = xi.ki.WOOD_PURIFICATION,    rank = xi.crafting.rank.NOVICE,  cost = 40000 },
    [1] = { id = xi.ki.WOOD_ENSORCELLMENT,   rank = xi.crafting.rank.NOVICE,  cost = 40000 },
    [2] = { id = xi.ki.LUMBERJACK,           rank = xi.crafting.rank.NOVICE,  cost = 10000 },
    [3] = { id = xi.ki.BOLTMAKER,            rank = xi.crafting.rank.NOVICE,  cost = 10000 },
    [4] = { id = xi.ki.WAY_OF_THE_CARPENTER, rank = xi.crafting.rank.VETERAN, cost = 20000 },
}

local items =
{
    [0] = { id = xi.items.CARPENTERS_BELT,      rank = xi.crafting.rank.NOVICE,     cost =  10000 },
    [1] = { id = xi.items.CARPENTERS_GLOVES,    rank = xi.crafting.rank.JOURNEYMAN, cost =  70000 },
    [2] = { id = xi.items.CARPENTERS_APRON,     rank = xi.crafting.rank.ARTISAN,    cost = 100000 },
    [3] = { id = xi.items.DRAWING_DESK,         rank = xi.crafting.rank.VETERAN,    cost = 150000 },
    [4] = { id = xi.items.CARPENTERS_SIGNBOARD, rank = xi.crafting.rank.VETERAN,    cost = 200000 },
    [5] = { id = xi.items.CARPENTERS_RING,      rank = xi.crafting.rank.CRAFTSMAN,  cost =  80000 },
    [6] = { id = xi.items.CARPENTERS_KIT,       rank = xi.crafting.rank.ARTISAN,    cost =  50000 },
    [7] = { id = xi.items.CARPENTERS_EMBLEM,    rank = xi.crafting.rank.VETERAN,    cost =  15000 },
}

entity.onTrade = function(player, npc, trade)
    xi.crafting.unionRepresentativeTrade(player, npc, trade, 732, 1)
end

entity.onTrigger = function(player, npc)
    xi.crafting.unionRepresentativeTrigger(player, 1, 731, "guild_woodworking", keyitems)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 731 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 1, "guild_woodworking", keyitems, items)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 731 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 1, "guild_woodworking", keyitems, items)
    elseif csid == 732 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
