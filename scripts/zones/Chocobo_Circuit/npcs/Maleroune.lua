-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Maleroune
-- !pos -380.827 -4.000 -508.221 70
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.chocoboRacing.onCounterTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.chocoboRacing.onCounterTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.chocoboRacing.onCounterEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.chocoboRacing.onCounterEventFinish(player, csid, option, npc)
end

return entity
