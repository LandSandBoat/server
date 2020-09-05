-----------------------------------
-- Area: Lower Jeuno
--  NPC: Yin Pocanakhu
-- Involved in Quest: Borghertz's Hands (1st quest only)
-- !pos 35 4 -43 245
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getCharVar("BorghertzHandsFirstTime") == 2) then
        player:startEvent(220)
    else
        player:startEvent(209)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 220 and option == 0 and player:delGil(1000)) then
        player:startEvent(221)
        player:setCharVar("BorghertzHandsFirstTime", 0)
        player:setCharVar("BorghertzCS", 1)
    end

end
