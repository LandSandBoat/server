-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Najjar
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("UnderOathCS") == 1 then  -- Quest: Under Oath - PLD AF3
        player:startEvent(16)
    else
        player:startEvent(17)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 16 then
        player:setCharVar("UnderOathCS", 2)  -- Quest: Under Oath - PLD AF3
    end
end

return entity
