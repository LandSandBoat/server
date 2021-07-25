-----------------------------------
-- Area: Port Jeuno
--  NPC: Guddal
-- Starts and Finishes Quest: Kazham Airship Pass (This quest does not appear in your quest log)
-- !pos -14 8 44 246
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Port_Jeuno/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if (player:hasKeyItem(xi.ki.AIRSHIP_PASS_FOR_KAZHAM) == false) then
        if
            trade:hasItemQty(1024, 1) == true and
            trade:hasItemQty(1025, 1) == true and
            trade:hasItemQty(1026, 1) == true and
            trade:getGil() == 0 and
            trade:getItemCount() == 3
        then
            player:startEvent(301) -- Ending quest "Kazham Airship Pass"
        else
            player:startEvent(302)
        end
    end
end

entity.onTrigger = function(player, npc)
    if (player:hasKeyItem(xi.ki.AIRSHIP_PASS_FOR_KAZHAM) == false) then
        player:startEvent(300)
    else
        player:startEvent(300, 0, 0, 0, 0, 0, 6)
    end
end

entity.onEventUpdate = function(player, csid, option)
    if (csid == 300 and option == 99) then
        if (player:delGil(148000)) then
            player:addKeyItem(xi.ki.AIRSHIP_PASS_FOR_KAZHAM)
            player:updateEvent(0, 1)
        end
    end
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 300 and option == 33) then
        if (player:hasKeyItem(xi.ki.AIRSHIP_PASS_FOR_KAZHAM) == true) then
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.AIRSHIP_PASS_FOR_KAZHAM)
        end
    elseif (csid == 301) then
        player:addKeyItem(xi.ki.AIRSHIP_PASS_FOR_KAZHAM)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.AIRSHIP_PASS_FOR_KAZHAM)
        player:tradeComplete()
    end
end

return entity
