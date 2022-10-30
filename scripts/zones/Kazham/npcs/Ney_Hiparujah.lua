-----------------------------------
-- Area: Kazham
--  NPC: Ney Hiparujah
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(251 + player:getFameLevel(xi.quest.fame_area.WINDURST))
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
