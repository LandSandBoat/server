-----------------------------------
-- Area: Port Windurst
--  NPC: Fennella
-- Type: Guildworker's Union Representative
-- !pos -177.811 -2.835 65.639 240
-----------------------------------
require("scripts/globals/crafting")
local ID = require("scripts/zones/Port_Windurst/IDs")
-----------------------------------
local entity = {}

local keyitems =
{
    [0] = { id = xi.ki.FROG_FISHING,    rank = xi.crafting.rank.NOVICE,  cost =  30000 },
    [1] = { id = xi.ki.SERPENT_RUMORS,  rank = xi.crafting.rank.ADEPT,   cost =  95000 },
    [2] = { id = xi.ki.MOOCHING,        rank = xi.crafting.rank.VETERAN, cost = 115000 },
    [3] = { id = xi.ki.ANGLERS_ALMANAC, rank = xi.crafting.rank.VETERAN, cost =  20000 },
}

local items =
{
    [0] = { id = xi.items.ROBBER_RIG,           rank = xi.crafting.rank.NOVICE,     cost =   1500 },
    [1] = { id = xi.items.FISHERMANS_BELT,      rank = xi.crafting.rank.NOVICE,     cost =  10000 },
    [2] = { id = xi.items.WADERS,               rank = xi.crafting.rank.JOURNEYMAN, cost =  70000 },
    [3] = { id = xi.items.FISHERMANS_APRON,     rank = xi.crafting.rank.ARTISAN,    cost = 100000 },
    [4] = { id = xi.items.FISHING_HOLE_MAP,     rank = xi.crafting.rank.VETERAN,    cost = 150000 },
    [5] = { id = xi.items.FISHERMANS_SIGNBOARD, rank = xi.crafting.rank.VETERAN,    cost = 200000 },
    [6] = { id = xi.items.NET_AND_LURE,         rank = xi.crafting.rank.ARTISAN,    cost =  50000 },
    [7] = { id = xi.items.FISHERMENS_EMBLEM,    rank = xi.crafting.rank.VETERAN,    cost =  15000 },
}

entity.onTrade = function(player, npc, trade)
    xi.crafting.unionRepresentativeTrade(player, npc, trade, 10021, 0)
end

entity.onTrigger = function(player, npc)
    xi.crafting.unionRepresentativeTrigger(player, 0, 10020, "guild_fishing", keyitems)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 10020 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 0, "guild_Fishing", keyitems, items)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10020 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 0, "guild_Fishing", keyitems, items)
    elseif csid == 10021 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
