-----------------------------------
-- Area: FeiYin
--  NPC: Strange Apparatus
-- !pos -94 -15 220 204
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    player:startEvent(27, 0, 0, 1474, 0, 0, 0, 0, player:getZoneID())
end

entity.onTrigger = function(player, npc)
    player:startEvent(25, 0, 0, 1474, 0, 0, 0, 0, player:getZoneID())
end

return entity
