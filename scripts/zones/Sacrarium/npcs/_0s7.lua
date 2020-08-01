-----------------------------------
-- Area: Sacrarium
--  NPC: _0s7 (Wooden Gate)
-- !pos 213.375 -3.500 -20.000 28
-----------------------------------

function onTrigger(player, npc)
    if (npc:getAnimation() == 9) then
        npc:openDoor()
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
