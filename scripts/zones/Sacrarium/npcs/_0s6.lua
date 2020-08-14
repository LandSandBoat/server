-----------------------------------
-- Area: Sacrarium
--  NPC: _0s6 (Wooden Gate)
-- !pos 213.375 -3.499 20.000 28
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
