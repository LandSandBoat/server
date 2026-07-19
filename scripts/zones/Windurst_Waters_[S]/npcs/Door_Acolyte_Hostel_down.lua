-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Door:Acolyte Hostel
-- !pos  124.000, -3.000, 222.215 94
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- TODO: Port to DefaultAction
    player:messageSpecial(ID.text.DOOR_ACOLYTE_HOSTEL_LOCKED)
end

return entity
