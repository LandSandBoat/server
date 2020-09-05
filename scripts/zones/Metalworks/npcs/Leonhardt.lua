-----------------------------------
-- Area: Metalworks
--  NPC: Leonhardt
-- Involved in Quest: Too Many Chefs
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getCharVar("TOO_MANY_CHEFS") == 3) then
        if trade:hasItemQty(2527, 1) then -- Trade Red Oven Mitt
            player:tradeComplete()
            player:startEvent(950)
        end
    end
end

function onTrigger(player, npc)
    if (player:getCharVar("TOO_MANY_CHEFS") == 1) then
        player:startEvent(948) -- part 2 Too Many Chefs
    else
        player:startEvent(945) -- standard
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 948) then
        player:setCharVar("TOO_MANY_CHEFS", 2)
    elseif (csid == 950) then
        player:setCharVar("TOO_MANY_CHEFS", 4)
    end
end
