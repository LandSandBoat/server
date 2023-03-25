-----------------------------------
-- Area: The Sanctuary of Zitah
--  NPC: ???
-- Finishes Quest: Lovers in the Dusk
-- !zone 121
-----------------------------------
local ID = require("scripts/zones/The_Sanctuary_of_ZiTah/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/world")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
