-----------------------------------
-- Area: Altar Room
--  NPC: Magicite
-- Involved in Mission: Magicite
-- !pos -346.776 21.833 46.173 152
-----------------------------------
local ID = zones[xi.zone.ALTAR_ROOM]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:messageText(npc, ID.text.THE_MAGICITE_GLOWS_OMINOUSLY, false, 6)
end

return entity
