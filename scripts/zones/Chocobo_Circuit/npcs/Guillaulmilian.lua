-----------------------------------
-- Area: Chocobo Circuit
--  NPC: Guillaulmilian
-- !pos -380.984 -4.000 -451.755 70
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
