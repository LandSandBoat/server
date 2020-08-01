-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Cahaurme
-- Involved in Quest: A Knight's Test, Lost Chick
-- !pos 55.749 -8.601 -29.354 230
-------------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:hasKeyItem(tpz.ki.BOOK_OF_TASKS) and player:hasKeyItem(tpz.ki.BOOK_OF_THE_EAST) == false) then
        player:startEvent(633)
    else
        player:showText(npc, 7817) -- nothing to report

    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 633) then
        player:addKeyItem(tpz.ki.BOOK_OF_THE_EAST)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BOOK_OF_THE_EAST)
    end

end
--- for future use
    -- player:startEvent(847) --are you the chicks owner
