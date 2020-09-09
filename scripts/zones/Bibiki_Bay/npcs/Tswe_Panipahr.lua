-----------------------------------
-- Area: Bibiki Bay
--  NPC: Tswe Panipahr
-- Type: Manaclipper
-- !pos 484.604 -4.035 729.671 4
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local curentticket=0
    if  (player:hasKeyItem(tpz.ki.MANACLIPPER_TICKET)) then
        curentticket=tpz.ki.MANACLIPPER_TICKET
    elseif (player:hasKeyItem(tpz.ki.MANACLIPPER_MULTITICKET)) then
        curentticket=tpz.ki.MANACLIPPER_MULTITICKET
    end

    if ( curentticket ~= 0 ) then
        player:messageSpecial(ID.text.HAVE_BILLET, curentticket)
    else
        local gils=player:getGil()
        player:startEvent(35, tpz.ki.MANACLIPPER_TICKET, tpz.ki.MANACLIPPER_MULTITICKET , 80, gils, 0, 500)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 35) then
        if (option==1) then
            player:delGil(80)
            player:addKeyItem(tpz.ki.MANACLIPPER_TICKET)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MANACLIPPER_TICKET)
        elseif (option==2) then
            player:delGil(500)
            player:addKeyItem(tpz.ki.MANACLIPPER_MULTITICKET)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MANACLIPPER_MULTITICKET)
            player:setCharVar("Manaclipper_Ticket", 10)
        end
    end
end
