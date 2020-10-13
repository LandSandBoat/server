-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Najjar
--  General Info NPC
-------------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCharVar("UnderOathCS") == 1) then  -- Quest: Under Oath - PLD AF3
        player:startEvent(16)
    else
        player:startEvent(17)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 16) then
        player:setCharVar("UnderOathCS", 2)  -- Quest: Under Oath - PLD AF3
    end
end
