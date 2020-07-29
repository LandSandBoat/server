-----------------------------------
-- Area: Ro'Maeve
--  NPC: _3e0 (Moongate)
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
-----------------------------------

function onTrigger(player, npc)
    if (player:hasKeyItem(tpz.ki.MOONGATE_PASS) == true) then
        npc:openDoor(10)
    end
end

function onTrade(player, npc, trade)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
