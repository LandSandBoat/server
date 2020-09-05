-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Liseran Door Exit
-- Zones out to Kamihr Drifts (zone 267)
-- !pos -34.549 -181.334 -20.031 274
-----------------------------------
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:startEvent(28)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 28 and option == 1) then
        player:setPos(-279.709, 19.976, 60.353, 0, 267)
    end
end
