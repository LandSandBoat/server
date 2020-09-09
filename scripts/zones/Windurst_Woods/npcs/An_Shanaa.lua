-----------------------------------
-- Area: Windurst Woods
--  NPC: An Shanaa
-- Working 100%
-----------------------------------
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.A_SONG_OF_LOVE) then
        player:startEvent(408, 0, tpz.ki.A_SONG_OF_LOVE)
    elseif player:getCharVar("CHASING_TALES_TRACK_BOOK") >= 1 then
        player:startEvent(405) -- Neeed CS here
    else
        player:startEvent(45)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
