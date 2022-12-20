-----------------------------------
-- Area: Windurst Woods
--  NPC: Samigo-Pormigo
-- Type: Guildworker's Union Representative
-- !pos -9.782 -5.249 -134.432 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/crafting")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

local keyitems =
{
    [0] = { id = xi.ki.BONE_PURIFICATION,     rank = xi.crafting.rank.NOVICE,  cost = 40000 },
    [1] = { id = xi.ki.BONE_ENSORCELLMENT,    rank = xi.crafting.rank.NOVICE,  cost = 40000 },
    [2] = { id = xi.ki.FILING,                rank = xi.crafting.rank.NOVICE,  cost = 10000 },
    [3] = { id = xi.ki.WAY_OF_THE_BONEWORKER, rank = xi.crafting.rank.VETERAN, cost = 20000 },
}

local items =
{
    [0] = { id = xi.items.BONEWORKERS_BELT,          rank = xi.crafting.rank.NOVICE,     cost =  10000 },
    [1] = { id = xi.items.PROTECTIVE_SPECTACLES,     rank = xi.crafting.rank.JOURNEYMAN, cost =  70000 },
    [2] = { id = xi.items.BONEWORKERS_APRON,         rank = xi.crafting.rank.ARTISAN,    cost = 100000 },
    [3] = { id = xi.items.DROGAROGAS_FANG,           rank = xi.crafting.rank.VETERAN,    cost = 150000 },
    [4] = { id = xi.items.BONEWORKERS_SIGNBOARD,     rank = xi.crafting.rank.VETERAN,    cost = 200000 },
    [5] = { id = xi.items.BONECRAFTERS_RING,         rank = xi.crafting.rank.CRAFTSMAN,  cost =  80000 },
    [6] = { id = xi.items.SET_OF_BONECRAFTING_TOOLS, rank = xi.crafting.rank.ARTISAN,    cost =  50000 },
    [7] = { id = xi.items.BONEWORKERS_EMBLEM,        rank = xi.crafting.rank.VETERAN,    cost =  15000 },
}

entity.onTrade = function(player, npc, trade)
    xi.crafting.unionRepresentativeTrade(player, npc, trade, 10023, 6)
end

entity.onTrigger = function(player, npc)
    xi.crafting.unionRepresentativeTrigger(player, 6, 10022, "guild_bonecraft", keyitems)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 10022 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 6, "guild_bonecraft", keyitems, items)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10022 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 6, "guild_bonecraft", keyitems, items)
    elseif csid == 10023 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
