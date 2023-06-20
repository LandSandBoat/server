-----------------------------------
-- Area: Metalworks
--  NPC: Lorena
-- Type: Blacksmithing Guildworker's Union Representative
-- !pos -104.990 1 30.995 237
-----------------------------------
local ID = require("scripts/zones/Metalworks/IDs")
require("scripts/globals/crafting")
-----------------------------------
local entity = {}

local keyitems =
{
    [0] = { id = xi.ki.METAL_PURIFICATION,    rank = xi.crafting.rank.NOVICE,  cost = 40000 },
    [1] = { id = xi.ki.METAL_ENSORCELLMENT,   rank = xi.crafting.rank.NOVICE,  cost = 40000 },
    [2] = { id = xi.ki.CHAINWORK,             rank = xi.crafting.rank.NOVICE,  cost = 10000 },
    [3] = { id = xi.ki.SHEETING,              rank = xi.crafting.rank.NOVICE,  cost = 10000 },
    [4] = { id = xi.ki.WAY_OF_THE_BLACKSMITH, rank = xi.crafting.rank.VETERAN, cost = 20000 },
}

local items =
{
    [0] = { id = xi.items.BLACKSMITHS_BELT,      rank = xi.crafting.rank.NOVICE,     cost =  10000 },
    [1] = { id = xi.items.SMITHYS_MITTS,         rank = xi.crafting.rank.JOURNEYMAN, cost =  70000 },
    [2] = { id = xi.items.BLACKSMITHS_APRON,     rank = xi.crafting.rank.ARTISAN,    cost = 100000 },
    [3] = { id = xi.items.MASTERSMITH_ANVIL,     rank = xi.crafting.rank.VETERAN,    cost = 150000 },
    [4] = { id = xi.items.BLACKSMITHS_SIGNBOARD, rank = xi.crafting.rank.VETERAN,    cost = 200000 },
    [5] = { id = xi.items.SMITHS_RING,           rank = xi.crafting.rank.CRAFTSMAN,  cost =  80000 },
    [6] = { id = xi.items.STONE_HEARTH,          rank = xi.crafting.rank.ARTISAN,    cost =  50000 },
    [7] = { id = xi.items.BLACKSMITHS_EMBLEM,    rank = xi.crafting.rank.VETERAN,    cost =  15000 },
}

entity.onTrade = function(player, npc, trade)
    xi.crafting.unionRepresentativeTrade(player, npc, trade, 801, 2)
end

entity.onTrigger = function(player, npc)
    xi.crafting.unionRepresentativeTrigger(player, 2, 800, "guild_smithing", keyitems)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 800 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 2, "guild_smithing", keyitems, items)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 800 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 2, "guild_smithing", keyitems, items)
    elseif csid == 801 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
