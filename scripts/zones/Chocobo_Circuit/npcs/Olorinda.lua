-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Olorinda
-- !pos -113.471 -14.500 -136.238 70
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.chocoboRacing.onToteboardTrigger(player, 333)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.chocoboRacing.onToteboardEventUpdate(player, option)
end

return entity
