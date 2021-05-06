-----------------------------------
-- Area: Rabao
--  NPC: Mileon
-- Type: Lucky Roll Gambler
-- !pos 26.080 8.201 65.297 247
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(100)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
