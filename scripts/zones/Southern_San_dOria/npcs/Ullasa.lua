-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ullasa
--  General Info NPC
-------------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if player:getCharVar("UnderOathCS") == 2 then  -- Quest: Under Oath - PLD AF3
        player:startEvent(40)
    else
        player:startEvent(39)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 40) then
        player:setCharVar("UnderOathCS", 3) -- Quest: Under Oath - PLD AF3
    end
end
