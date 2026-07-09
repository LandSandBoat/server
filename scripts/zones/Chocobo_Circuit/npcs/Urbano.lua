-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Urbano
-- !pos -17.515 -14.500 -136.001 70
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.chocoboRacing.onToteboardTrigger(player, 337)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.chocoboRacing.onToteboardEventUpdate(player, option)
end

return entity
