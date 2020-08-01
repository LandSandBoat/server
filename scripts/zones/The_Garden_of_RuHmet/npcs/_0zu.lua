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

    if (player:hasKeyItem(tpz.ki.BRAND_OF_DAWN)==false) then
        player:startEvent(110)
    end

    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 110 and option==1) then
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BRAND_OF_DAWN)
        player:addKeyItem(tpz.ki.BRAND_OF_DAWN)
    end
end
