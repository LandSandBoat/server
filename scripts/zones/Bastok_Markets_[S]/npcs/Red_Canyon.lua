-----------------------------------
-- Area: Bastok Markets (S)
--  NPC: Red Canyon
-----------------------------------

function onTrigger(player, npc)
    player:startEvent(200)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 200 and option == 1) then
        player:setPos(380, 0, 147, 192, 88)
    end
end
