-----------------------------------
-- Area: Qulun Dome
--  NPC: Magicite
-- Involved in Mission: Magicite
-- !pos 9.182 22.554 -84.158 148
-----------------------------------
local ID = zones[xi.zone.QULUN_DOME]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:messageText(npc, ID.text.THE_MAGICITE_GLOWS_OMINOUSLY, false, 6)
end

return entity
