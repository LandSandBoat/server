-----------------------------------
-- Area: Windurst Woods
--  NPC: An Polaali
-- Working 100%
-----------------------------------
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.A_SONG_OF_LOVE) then
        player:startEvent(407)
    elseif player:getCharVar("CHASING_TALES_TRACK_BOOK") == 1 then
        player:startEvent(404) -- Neeed CS here
    else
        player:startEvent(44)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
