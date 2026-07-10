-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Uhko Rolinzoh
-- !pos -89.524 -14.500 -136.175 70
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.chocoboRacing.onToteboardTrigger(player, 334)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.chocoboRacing.onToteboardEventUpdate(player, option)
end

return entity
