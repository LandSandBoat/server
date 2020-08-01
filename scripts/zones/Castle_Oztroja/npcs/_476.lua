-----------------------------------
-- Area: Castle Oztroja
--  NPC: _476 (Brass Door)
-- !pos 145.005 -19.989 -140.000 151
-----------------------------------

function onTrigger(player, npc)
    npc:openDoor(6)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
