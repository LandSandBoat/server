-----------------------------------
-- Area: Abyssea - La Theine
--  NPC: Cavernous Maw
-- !pos -480.009, 0.000, 799.927 132
-- Teleports Players to La Theine Plateau
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(200)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 200 and option == 1 then
        player:setPos(-562, 0.001, 640, 26, 102)
    end
end

return entity
