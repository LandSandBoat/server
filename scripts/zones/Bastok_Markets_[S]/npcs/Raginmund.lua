-----------------------------------
-- Area: Bastok Markets (S)
--  NPC: Raginmund
-- Involved in Quest: Too Many Chefs
-- Standard Info NPC
-- Location L-10
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCharVar("TOO_MANY_CHEFS") == 2) then
        player:startEvent(112) -- part 3 Too Many Chefs
    else
        player:startEvent(111) -- standard
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 112) then
        player:setCharVar("TOO_MANY_CHEFS", 3)
    end
end
