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
local entity = {}

local keyitems =
{
    [0] = { id = xi.ki.CLOTH_PURIFICATION,  rank = xi.crafting.rank.NOVICE,  cost = 40000 },
    [1] = { id = xi.ki.CLOTH_ENSORCELLMENT, rank = xi.crafting.rank.NOVICE,  cost = 40000 },
    [2] = { id = xi.ki.SPINNING,            rank = xi.crafting.rank.NOVICE,  cost = 10000 },
    [3] = { id = xi.ki.FLETCHING,           rank = xi.crafting.rank.NOVICE,  cost = 10000 },
    [4] = { id = xi.ki.WAY_OF_THE_WEAVER,   rank = xi.crafting.rank.VETERAN, cost = 20000 },
}

local items =
{
    [0] = { id = xi.items.WEAVERS_BELT,          rank = xi.crafting.rank.NOVICE,     cost =  10000 },
    [1] = { id = xi.items.MAGNIFYING_SPECTACLES, rank = xi.crafting.rank.JOURNEYMAN, cost =  70000 },
    [2] = { id = xi.items.WEAVERS_APRON,         rank = xi.crafting.rank.ARTISAN,    cost = 100000 },
    [3] = { id = xi.items.GILT_TAPESTRY,         rank = xi.crafting.rank.VETERAN,    cost = 150000 },
    [4] = { id = xi.items.WEAVERS_SIGNBOARD,     rank = xi.crafting.rank.VETERAN,    cost = 200000 },
    [5] = { id = xi.items.TAILORS_RING,          rank = xi.crafting.rank.CRAFTSMAN,  cost =  80000 },
    [6] = { id = xi.items.SPINNING_WHEEL,        rank = xi.crafting.rank.ARTISAN,    cost =  50000 },
    [7] = { id = xi.items.WEAVERS_EMBLEM,        rank = xi.crafting.rank.VETERAN,    cost =  15000 },
}

entity.onTrade = function(player, npc, trade)
    xi.crafting.unionRepresentativeTrade(player, npc, trade, 10025, 4)
end

entity.onTrigger = function(player, npc)
    xi.crafting.unionRepresentativeTrigger(player, 4, 10024, "guild_weaving", keyitems)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 10024 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 4, "guild_weaving", keyitems, items)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10024 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 4, "guild_weaving", keyitems, items)
    elseif csid == 10025 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
