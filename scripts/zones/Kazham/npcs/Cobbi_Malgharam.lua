-----------------------------------
-- Area: Kazham
--  NPC: Cobbi Malgharam
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCharVar("BathedInScent") == 1) then
        player:startEvent(161) -- scent from Blue Rafflesias
    else
        player:startEvent(41)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
