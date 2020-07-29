-----------------------------------
-- Area: Kamihr Drifts
--  NPC: Liseran Door Entrance
-- Zones to Outer Ra'Kaznar (zone 274)
-- !pos -34.549 -181.334 -20.031 274
-----------------------------------
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(34)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 34 and option == 1) then
        player:setPos(-39.846, -179.334, -19.921, 131, 274)
    end
end
