-----------------------------------
-- Area: Bastok Markets
--  NPC: Gulldago
-- Type: Tutorial NPC
-- !pos -364.121 -11.034 -167.456 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/settings/main")
require("scripts/globals/npc_util")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}


entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.tutorial.onTrigger(player, npc, 518, 1)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.tutorial.onEventFinish(player, csid, option, 518, 1)
end

return entity
