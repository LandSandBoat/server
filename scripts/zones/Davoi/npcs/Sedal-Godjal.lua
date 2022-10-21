-----------------------------------
-- Area: Davoi
--  NPC: Sedal-Godjal
-- Involved in Quests: Whence the Wind Blows
-- Involved in Missions: Windurst 8-1/8-2
-- !pos 185 -3 -116 149
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/missions")
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
