-----------------------------------
-- Area: Kazham
--  NPC: Ney Hiparujah
-- Standard Info NPC
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(251 + player:getFameLevel(KAZHAM))
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
