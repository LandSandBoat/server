-----------------------------------
-- Area: Monastic Cavern
--  NPC: Magicite
-- Involved in Mission: Magicite
-- !pos -160.899 -8.437 7.800 150
-----------------------------------
local ID = zones[xi.zone.MONASTIC_CAVERN]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:messageText(npc, ID.text.THE_MAGICITE_GLOWS_OMINOUSLY, false, 6)
end

return entity
