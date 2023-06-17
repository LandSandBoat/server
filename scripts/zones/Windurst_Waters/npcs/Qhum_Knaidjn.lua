-----------------------------------
-- Area: Windurst Waters
--  NPC: Qhum_Knaidjn
-- Type: Guildworker's Union Representative
-- !pos -112.561 -2 55.205 238
-----------------------------------
require("scripts/globals/crafting")
local ID = require("scripts/zones/Windurst_Waters/IDs")
-----------------------------------
local entity = {}

local keyitems =
{
    [0] = { id = xi.ki.RAW_FISH_HANDLING,     rank = xi.crafting.rank.NOVICE,  cost = 30000 },
    [1] = { id = xi.ki.NOODLE_KNEADING,       rank = xi.crafting.rank.NOVICE,  cost = 30000 },
    [2] = { id = xi.ki.PATISSIER,             rank = xi.crafting.rank.NOVICE,  cost =  8000 },
    [3] = { id = xi.ki.STEWPOT_MASTERY,       rank = xi.crafting.rank.NOVICE,  cost = 30000 },
    [4] = { id = xi.ki.WAY_OF_THE_CULINARIAN, rank = xi.crafting.rank.VETERAN, cost = 20000 },
}

local items =
{
    [0] = { id = xi.items.CULINARIANS_BELT,        rank = xi.crafting.rank.NOVICE,     cost =  10000 },
    [1] = { id = xi.items.CHEFS_HAT,               rank = xi.crafting.rank.JOURNEYMAN, cost =  70000 },
    [2] = { id = xi.items.CULINARIANS_APRON,       rank = xi.crafting.rank.ARTISAN,    cost = 100000 },
    [3] = { id = xi.items.CORDON_BLEU_COOKING_SET, rank = xi.crafting.rank.VETERAN,    cost = 150000 },
    [4] = { id = xi.items.CULINARIANS_SIGNBOARD,   rank = xi.crafting.rank.VETERAN,    cost = 200000 },
    [5] = { id = xi.items.CHEFS_RING,              rank = xi.crafting.rank.CRAFTSMAN,  cost =  80000 },
    [6] = { id = xi.items.BRASS_CROCK,             rank = xi.crafting.rank.ARTISAN,    cost =  50000 },
    [7] = { id = xi.items.CULINARIANS_EMBLEM,      rank = xi.crafting.rank.VETERAN,    cost =  15000 },
}

entity.onTrade = function(player, npc, trade)
    xi.crafting.unionRepresentativeTrade(player, npc, trade, 10025, 8)
end

entity.onTrigger = function(player, npc)
    xi.crafting.unionRepresentativeTrigger(player, 8, 10024, "guild_cooking", keyitems)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 10024 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 8, "guild_cooking", keyitems, items)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10024 then
        xi.crafting.unionRepresentativeTriggerFinish(player, option, npc, 8, "guild_cooking", keyitems, items)
    elseif csid == 10025 then
        player:messageSpecial(ID.text.GP_OBTAINED, option)
    end
end

return entity
