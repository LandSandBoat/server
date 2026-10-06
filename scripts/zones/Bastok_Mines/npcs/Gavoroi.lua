-----------------------------------
-- Area: Bastok Mines
--  NPC: Gavoroi
-- !pos 63.874 0.000 -88.468 234
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.chocoboRacing.onChocobuckExchangeTrigger(player, 552)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.chocoboRacing.onChocobuckExchangeEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.chocoboRacing.onChocobuckExchangeEventFinish(player, csid, option, npc)
end

return entity
