-----------------------------------
-- Area: Windurst Woods
--  NPC: Selele
-- Type: Tutorial NPC
-- !pos 106.9 -5 -31.5 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.tutorial.onTrigger(player, npc, 813, 2)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.tutorial.onEventFinish(player, csid, option, 813, 2)
end

return entity
