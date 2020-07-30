-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _0r9 (Ornate Gate)
-- !pos 139.000 -25.500 60.000 27
-----------------------------------
function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar('X_MARKS_THE_SPOT') == 4 then
        player:startEvent(37)
    elseif (npc:getAnimation() == 9) then
        npc:openDoor()
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 37 then
        player:setCharVar('X_MARKS_THE_SPOT', 5)
    end
end
