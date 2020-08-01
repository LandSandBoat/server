-----------------------------------
-- Area: Mhaura
--  NPC: Felisa
-- Admits players to the dock in Mhaura.
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getZPos() > 38.5) then
        player:startEvent(221, player:getGil(), 100)
    else
        player:startEvent(235)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 221 and option == 333) then
        player:delGil(100)
    end

end
