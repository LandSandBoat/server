-----------------------------------
-- Area: The Garden of Ru'Hmet
--  NPC: particle gate
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:hasKeyItem(tpz.ki.BRAND_OF_TWILIGHT)==false) then
        player:startEvent(111)
    end

    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 111 and option==1) then
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BRAND_OF_TWILIGHT)
        player:addKeyItem(tpz.ki.BRAND_OF_TWILIGHT)
    end
end
