-----------------------------------
-- Area: Windurst Walls
--  NPC: Seven of Diamonds
-- Type: Standard NPC
-- !pos 6.612 -3.5 278.553 239
-----------------------------------
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.RHINOSTERY_CERTIFICATE) then
        player:startEvent(390)
    else
        player:startEvent(264)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
