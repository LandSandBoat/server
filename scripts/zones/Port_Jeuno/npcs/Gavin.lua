-----------------------------------
-- Area: Port Jeuno
--  NPC: Gavin
-- !pos -15 8 44 246
-----------------------------------
local ID = zones[xi.zone.PORT_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:showText(npc, ID.text.GAVIN_DIALOG, xi.ki.AIRSHIP_PASS_FOR_KAZHAM)
end

return entity
