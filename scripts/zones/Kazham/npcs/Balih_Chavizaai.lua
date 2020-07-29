-----------------------------------
-- Area: Kazham
--  NPC: Balih Chavizaai
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCharVar("BathedInScent") == 1) then
        player:startEvent(160) -- scent from Blue Rafflesias
    else
        player:startEvent(40)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
