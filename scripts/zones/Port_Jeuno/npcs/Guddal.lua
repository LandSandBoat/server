-----------------------------------
-- Area: Port Jeuno
--  NPC: Guddal
-- Starts and Finishes Quest: Kazham Airship Pass (This quest does not appear in your quest log)
-- !pos -14 8 44 246
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Port_Jeuno/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:hasKeyItem(tpz.ki.AIRSHIP_PASS_FOR_KAZHAM) == false) then
        if (trade:hasItemQty(1024, 1) == true and trade:hasItemQty(1025, 1) == true and trade:hasItemQty(1026, 1) == true and
           trade:getGil() == 0 and trade:getItemCount() == 3) then
            player:startEvent(301) -- Ending quest "Kazham Airship Pass"
        else
            player:startEvent(302)
        end
    end
end

function onTrigger(player, npc)
    if (player:hasKeyItem(tpz.ki.AIRSHIP_PASS_FOR_KAZHAM) == false) then
        player:startEvent(300)
    end
end

function onEventUpdate(player, csid, option)
    if (csid == 300) then
        if (player:delGil(148000)) then
            player:addKeyItem(tpz.ki.AIRSHIP_PASS_FOR_KAZHAM)
            player:updateEvent(0, 1)
        end
    end
end

function onEventFinish(player, csid, option)
    if (csid == 300) then
        if (player:hasKeyItem(tpz.ki.AIRSHIP_PASS_FOR_KAZHAM) == true) then
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.AIRSHIP_PASS_FOR_KAZHAM)
        end
    elseif (csid == 301) then
        player:addKeyItem(tpz.ki.AIRSHIP_PASS_FOR_KAZHAM)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.AIRSHIP_PASS_FOR_KAZHAM)
        player:tradeComplete()
    end
end
