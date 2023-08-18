-----------------------------------
-- Area: Rabao
--  NPC: Maryoh Comyujah
-- Involved in Mission: The Mithra and the Crystal (Zilart 12)
-- !pos 0 8 73 247
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(43) -- Standard dialog
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
