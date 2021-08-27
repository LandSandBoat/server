-----------------------------------
-- Area: Rabao
--  NPC: Maryoh Comyujah
-- Involved in Mission: The Mithra and the Crystal (Zilart 12)
-- !pos 0 8 73 247
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
local ID = require("scripts/zones/Rabao/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(43) -- Standard dialog
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
