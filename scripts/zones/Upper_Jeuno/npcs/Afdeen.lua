-----------------------------------
-- Area: Upper Jeuno
--  NPC: Afdeen
-- Standard Merchant NPC
-- !pos 1.462 0.000 21.627 244
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(179)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 179 and option == 1 then
        player:setPos(0, 0, 0, 0, 44)
    end
end

return entity
