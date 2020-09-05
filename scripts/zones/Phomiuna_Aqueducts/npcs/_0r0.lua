-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _0r0 (Iron Gate)
-- !pos -140.000 -25.500 71.213 27
-----------------------------------
function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (npc:getAnimation() ==9) then
        npc:openDoor()
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
