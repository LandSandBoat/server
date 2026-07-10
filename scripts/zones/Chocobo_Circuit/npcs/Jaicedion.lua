-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Jaicedion
-- !pos -41.904 -14.500 -135.923 70
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.chocoboRacing.onToteboardTrigger(player, 336)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.chocoboRacing.onToteboardEventUpdate(player, option)
end

return entity
