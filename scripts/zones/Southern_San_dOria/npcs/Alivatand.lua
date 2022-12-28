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

local keyitems =
{
    [0] = { id = xi.ki.LEATHER_PURIFICATION,  rank = xi.crafting.rank.NOVICE,  cost = 40000 },
    [1] = { id = xi.ki.LEATHER_ENSORCELLMENT, rank = xi.crafting.rank.NOVICE,  cost = 40000 },
    [2] = { id = xi.ki.TANNING,               rank = xi.crafting.rank.NOVICE,  cost = 10000 },
    [3] = { id = xi.ki.WAY_OF_THE_TANNER,     rank = xi.crafting.rank.VETERAN, cost = 20000 },
}

local items =
{
    [0] = { id = xi.items.TANNERS_BELT,      rank = xi.crafting.rank.NOVICE,     cost =  10000 },
    [1] = { id = xi.items.TANNERS_GLOVES,    rank = xi.crafting.rank.JOURNEYMAN, cost =  70000 },
    [2] = { id = xi.items.TANNERS_APRON,     rank = xi.crafting.rank.ARTISAN,    cost = 100000 },
    [3] = { id = xi.items.GOLDEN_FLEECE,     rank = xi.crafting.rank.VETERAN,    cost = 150000 },
    [4] = { id = xi.items.TANNERS_SIGNBOARD, rank = xi.crafting.rank.VETERAN,    cost = 200000 },
    [5] = { id = xi.items.TANNERS_RING,      rank = xi.crafting.rank.CRAFTSMAN,  cost =  80000 },
    [6] = { id = xi.items.HIDE_STRETCHER,    rank = xi.crafting.rank.ARTISAN,    cost =  50000 },
    [7] = { id = xi.items.TANNERS_EMBLEM,    rank = xi.crafting.rank.VETERAN,    cost =  15000 },
}

entity.onTrade = function(player, npc, trade)
    xi.crafting.unionRepresentativeTrade(player, npc, trade, 691, 5)
end

entity.onTrigger = function(player, npc)
    xi.crafting.unionRepresentativeTrigger(player, 5, 690, "guild_leathercraft", keyitems)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 690 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 5, "guild_leathercraft", keyitems, items)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 690 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 5, "guild_leathercraft", keyitems, items)
    elseif csid == 691 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
