-----------------------------------
-- Area: Nashmau
--  NPC: Abihaal
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(221, player:getGil(), 100)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 221 and option == 333) then
        player:delGil(100)
    end
end
