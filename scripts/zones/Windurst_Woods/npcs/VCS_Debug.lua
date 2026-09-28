-----------------------------------
-- Area: Windurst Woods
--  NPC: Chocobo
-- Type: VCS developer debug menu (GM only)
-- !pos 134.041 -7.000 -115.267 241
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
