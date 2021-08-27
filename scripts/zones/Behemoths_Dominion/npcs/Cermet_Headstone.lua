-----------------------------------
-- Area: Behemoth's Dominion
--  NPC: Cermet Headstone
-- Involved in Mission: ZM5 Headstone Pilgrimage (Lightning Headstone)
-- !pos -74 -4 -87 127
-----------------------------------
local ID = require("scripts/zones/Behemoths_Dominion/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/titles")
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
