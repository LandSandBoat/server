-----------------------------------
-- Area: Kazham
--  NPC: Vah Keshura
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCharVar("BathedInScent") == 1) then
        player:startEvent(187) -- scent from Blue Rafflesias
    else
        player:startEvent(124)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
