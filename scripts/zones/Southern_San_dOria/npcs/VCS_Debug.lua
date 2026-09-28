-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Chocobo
-- Type: VCS developer debug menu (GM only)
-- !pos -6.800 1.548 -104.500 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.chocoboRaising.onTriggerDebug(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.chocoboRaising.onEventUpdateDebug(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.chocoboRaising.onEventFinishDebug(player, csid, option, npc)
end

return entity
