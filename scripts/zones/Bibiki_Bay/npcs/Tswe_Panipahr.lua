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

    player:setCharVar("[manaclipper]currentticket", 0) -- Set ticket to 0 in case something breaks
    if (player:hasKeyItem(xi.ki.MANACLIPPER_TICKET)) and (player:hasKeyItem(xi.ki.MANACLIPPER_MULTI_TICKET)) then
        player:setCharVar("[manaclipper]currentticket", 3)
    elseif  (player:hasKeyItem(xi.ki.MANACLIPPER_MULTI_TICKET)) then
        player:setCharVar("[manaclipper]currentticket", 2)
    elseif (player:hasKeyItem(xi.ki.MANACLIPPER_TICKET)) then
        player:setCharVar("[manaclipper]currentticket", 1)
    else
        player:setCharVar("[manaclipper]currentticket", 0)
    end

    player:startEvent(35, xi.ki.MANACLIPPER_TICKET, xi.ki.MANACLIPPER_MULTI_TICKET , 80, player:getGil(), player:getCharVar("Manaclipper_Ticket"), 500) -- Start event

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local currentticket = player:getCharVar("[manaclipper]currentticket")
    local numberticket = player:getCharVar("Manaclipper_Ticket")

    -- Option 1: MANACLIPPER_TICKET
    -- Option 2: MANACLIPPER_MULTI_TICKET
    if option == 1 and (currentticket == 1 or currentticket == 3) then -- If you have MANACLIPPER_TICKET
        player:messageSpecial(ID.text.HAVE_BILLET, xi.ki.MANACLIPPER_TICKET)
    elseif option == 1 and (player:getGil() >= 80) then
            player:delGil(80)
            player:addKeyItem(xi.ki.MANACLIPPER_TICKET)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MANACLIPPER_TICKET)
    elseif option == 2 and (currentticket == 2 or currentticket == 3) and numberticket <= 9 then -- If you have multi ticket with less than 9
        player:delGil(500)
        player:messageSpecial(ID.text.MTICKET_ADDED, xi.ki.MANACLIPPER_MULTI_TICKET, 10)
        player:setCharVar("Manaclipper_Ticket", 10)
    elseif option == 2 and (currentticket == 2 or currentticket == 3) then
        player:messageSpecial(ID.text.HAVE_BILLET, xi.ki.MANACLIPPER_MULTI_TICKET)
    elseif option == 2 and player:getGil() >= 500 then
        player:delGil(500)
        player:addKeyItem(xi.ki.MANACLIPPER_MULTI_TICKET)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MANACLIPPER_MULTI_TICKET)
        player:setCharVar("Manaclipper_Ticket", 10)
    else
        -- Say nothing as fail safe
    end

end

return entity
