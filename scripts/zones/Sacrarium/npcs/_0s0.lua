-----------------------------------
-- Area: Sacrarium
--  NPC: _0s0 (Iron Gate)
-- !pos -35.026 -3.000 -9.997 28
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
