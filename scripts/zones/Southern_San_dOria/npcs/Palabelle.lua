-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Palabelle
-- !pos -28.462 2.000 -80.858 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.chocoboRacing.onChocobuckExchangeTrigger(player, 876)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.chocoboRacing.onChocobuckExchangeEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.chocoboRacing.onChocobuckExchangeEventFinish(player, csid, option, npc)
end

return entity
