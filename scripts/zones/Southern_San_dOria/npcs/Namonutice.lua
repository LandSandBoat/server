-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Namonutice
-- Fame Checker
-- !zone 230
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(31, player:getFame(xi.fameArea.SANDORIA))
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
