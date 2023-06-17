-----------------------------------
-- Area: Bibiki Bay
--  NPC: Tswe Panipahr
-- Type: Manaclipper
-- !pos 484.604 -4.035 729.671 4
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local curentticket = 0
    if  player:hasKeyItem(xi.ki.MANACLIPPER_TICKET) then
        curentticket = xi.ki.MANACLIPPER_TICKET
    elseif player:hasKeyItem(xi.ki.MANACLIPPER_MULTI_TICKET) then
        curentticket = xi.ki.MANACLIPPER_MULTI_TICKET
    end

    if curentticket ~= 0 then
        player:messageSpecial(ID.text.HAVE_BILLET, curentticket)
    else
        local gil = player:getGil()
        player:startEvent(35, xi.ki.MANACLIPPER_TICKET, xi.ki.MANACLIPPER_MULTI_TICKET , 80, gil, 0, 500)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 35 then
        if option == 1 then
            player:delGil(80)
            player:addKeyItem(xi.ki.MANACLIPPER_TICKET)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MANACLIPPER_TICKET)
        elseif option == 2 then
            player:delGil(500)
            player:addKeyItem(xi.ki.MANACLIPPER_MULTI_TICKET)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MANACLIPPER_MULTI_TICKET)
            player:setCharVar("Manaclipper_Ticket", 10)
        end
    end
end

return entity
