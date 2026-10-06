-----------------------------------
-- Area: Windurst Woods
--  NPC: Toppi-Meppi
-- !pos 112.639 -4.999 -139.181 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.chocoboRacing.onChocobuckExchangeTrigger(player, 789)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.chocoboRacing.onChocobuckExchangeEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.chocoboRacing.onChocobuckExchangeEventFinish(player, csid, option, npc)
end

return entity
