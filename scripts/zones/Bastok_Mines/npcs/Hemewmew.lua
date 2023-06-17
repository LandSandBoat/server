-----------------------------------
-- Area: Bastok Mines
--  NPC: Hemewmew
-- Type: Guildworker's Union Representative
-- !pos 117.970 1.017 -10.438 234
-----------------------------------
require('scripts/globals/crafting')
require('scripts/globals/items')
-----------------------------------
local ID = require('scripts/zones/Bastok_Mines/IDs')
-----------------------------------
local entity = {}

local keyitems =
{
    [0] = { id = xi.ki.ANIMA_SYNTHESIS,        rank = xi.crafting.rank.NOVICE,  cost = 20000 },
    [1] = { id = xi.ki.ALCHEMIC_PURIFICATION,  rank = xi.crafting.rank.NOVICE,  cost = 40000 },
    [2] = { id = xi.ki.ALCHEMIC_ENSORCELLMENT, rank = xi.crafting.rank.NOVICE,  cost = 40000 },
    [3] = { id = xi.ki.TRITURATION,            rank = xi.crafting.rank.NOVICE,  cost = 10000 },
    [4] = { id = xi.ki.CONCOCTION,             rank = xi.crafting.rank.NOVICE,  cost = 20000 },
    [5] = { id = xi.ki.IATROCHEMISTRY,         rank = xi.crafting.rank.NOVICE,  cost = 10000 },
    [6] = { id = xi.ki.WAY_OF_THE_ALCHEMIST,   rank = xi.crafting.rank.VETERAN, cost = 20000 },
}

local items =
{
    [0] = { id = xi.items.ALCHEMISTS_BELT,      rank = xi.crafting.rank.NOVICE,     cost =  10000 },
    [1] = { id = xi.items.CADUCEUS,             rank = xi.crafting.rank.JOURNEYMAN, cost =  70000 },
    [2] = { id = xi.items.ALCHEMISTS_APRON,     rank = xi.crafting.rank.ARTISAN,    cost = 100000 },
    [3] = { id = xi.items.COPY_OF_EMERALDA,     rank = xi.crafting.rank.VETERAN,    cost = 150000 },
    [4] = { id = xi.items.ALCHEMISTS_SIGNBOARD, rank = xi.crafting.rank.VETERAN,    cost = 200000 },
    [5] = { id = xi.items.ALCHEMISTS_RING,      rank = xi.crafting.rank.CRAFTSMAN,  cost =  80000 },
    [6] = { id = xi.items.ALEMBIC,              rank = xi.crafting.rank.ARTISAN,    cost =  50000 },
    [7] = { id = xi.items.ALCHEMISTS_EMBLEM,    rank = xi.crafting.rank.VETERAN,    cost =  15000 },
}

entity.onTrade = function(player, npc, trade)
    xi.crafting.unionRepresentativeTrade(player, npc, trade, 207, 7)
end

entity.onTrigger = function(player, npc)
    xi.crafting.unionRepresentativeTrigger(player, 7, 206, "guild_alchemy", keyitems)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 206 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 7, "guild_alchemy", keyitems, items)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 206 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 7, "guild_alchemy", keyitems, items)
    elseif csid == 207 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
