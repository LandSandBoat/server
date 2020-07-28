-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _0r4 (Ornate Gate)
-- !pos -89.500 -25.500 60.000 27
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
