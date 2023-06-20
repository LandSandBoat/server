-----------------------------------
-- Area: Bastok Markets
--  NPC: Ellard
-- Type: Guildworker's Union Representative
-- !pos -214.355 -7.814 -63.809 235
-----------------------------------
require('scripts/globals/crafting')
require('scripts/globals/items')
-----------------------------------
local ID = require('scripts/zones/Bastok_Markets/IDs')
-----------------------------------
local entity = {}

local keyitems =
{
    [0] = { id = xi.ki.GOLD_PURIFICATION,    rank = xi.crafting.rank.NOVICE,  cost = 40000 },
    [1] = { id = xi.ki.GOLD_ENSORCELLMENT,   rank = xi.crafting.rank.NOVICE,  cost = 40000 },
    [2] = { id = xi.ki.CHAINWORK,            rank = xi.crafting.rank.NOVICE,  cost = 10000 },
    [3] = { id = xi.ki.SHEETING,             rank = xi.crafting.rank.NOVICE,  cost = 10000 },
    [4] = { id = xi.ki.CLOCKMAKING,          rank = xi.crafting.rank.NOVICE,  cost = 10000 },
    [5] = { id = xi.ki.WAY_OF_THE_GOLDSMITH, rank = xi.crafting.rank.VETERAN, cost = 20000 },
}

local items =
{
    [0] = { id = xi.items.GOLDSMITHS_BELT,      rank = xi.crafting.rank.NOVICE,     cost =  10000 },
    [1] = { id = xi.items.SHADED_SPECTACLES,    rank = xi.crafting.rank.JOURNEYMAN, cost =  70000 },
    [2] = { id = xi.items.GOLDSMITHS_APRON,     rank = xi.crafting.rank.ARTISAN,    cost = 100000 },
    [3] = { id = xi.items.STACK_OF_FOOLS_GOLD,  rank = xi.crafting.rank.VETERAN,    cost = 150000 },
    [4] = { id = xi.items.GOLDSMITHS_SIGNBOARD, rank = xi.crafting.rank.VETERAN,    cost = 200000 },
    [5] = { id = xi.items.GOLDSMITHS_RING,      rank = xi.crafting.rank.CRAFTSMAN,  cost =  80000 },
    [6] = { id = xi.items.GEMSCOPE,             rank = xi.crafting.rank.ARTISAN,    cost =  50000 },
    [7] = { id = xi.items.GOLDSMITHS_EMBLEM,    rank = xi.crafting.rank.VETERAN,    cost =  15000 },
}

entity.onTrade = function(player, npc, trade)
    xi.crafting.unionRepresentativeTrade(player, npc, trade, 341, 3)
end

entity.onTrigger = function(player, npc)
    xi.crafting.unionRepresentativeTrigger(player, 3, 340, "guild_goldsmithing", keyitems)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 340 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 3, "guild_goldsmithing", keyitems, items)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 340 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 3, "guild_goldsmithing", keyitems, items)
    elseif csid == 341 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
