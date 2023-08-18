-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Kubhe Ijyuhla
-- !pos 23.257 0.000 21.532 50
-----------------------------------
require("scripts/globals/quests")
local ID = zones[xi.zone.AHT_URHGAN_WHITEGATE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
