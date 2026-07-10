-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Jadamo
-- !pos -65.812 -14.500 -136.126 70
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.chocoboRacing.onToteboardTrigger(player, 335)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.chocoboRacing.onToteboardEventUpdate(player, option)
end

return entity
