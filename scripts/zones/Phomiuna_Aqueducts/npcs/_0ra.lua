-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _0ra (Iron Gate)
-- !pos 180.000 -25.500 71.400 27
-----------------------------------
function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (npc:getAnimation() == 9) then
        npc:openDoor()
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
