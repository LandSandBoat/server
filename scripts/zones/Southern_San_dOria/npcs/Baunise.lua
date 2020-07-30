-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Baunise
-- Involved in Quest: A Knight's Test
-- !pos -55 -8 -32 230
-------------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:hasKeyItem(tpz.ki.BOOK_OF_TASKS) and player:hasKeyItem(tpz.ki.BOOK_OF_THE_WEST) == false) then
        player:startEvent(634)
    else
        player:showText(npc, 7817)-- nothing to report
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 634) then
        player:addKeyItem(tpz.ki.BOOK_OF_THE_WEST)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BOOK_OF_THE_WEST)
    end

end
