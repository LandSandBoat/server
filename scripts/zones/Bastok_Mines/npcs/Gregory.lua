-----------------------------------
-- Area: Bastok Mines
--  NPC: Gregory
-- Type: ENM
-- !pos 51.530 -1 -83.940 234
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(256)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
