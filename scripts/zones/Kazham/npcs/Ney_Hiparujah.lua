-----------------------------------
-- Area: Kazham
--  NPC: Ney Hiparujah
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(251 + player:getFameLevel(xi.fameArea.WINDURST))
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
