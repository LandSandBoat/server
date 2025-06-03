-----------------------------------
-- Area: King_Ranperre's Tomb
--  NPC: Strange Apparatus
-- !pos -260 7 -142 190
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    player:startEvent(13, 0, 0, 1474, 0, 0, 0, 0, player:getZoneID())
end

entity.onTrigger = function(player, npc)
    player:startEvent(11, 0, 0, 1474, 0, 0, 0, 0, player:getZoneID())
end

return entity
