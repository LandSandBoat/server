-----------------------------------
-- Area: Bibiki Bay
--  NPC: Tswe Panipahr
-- Type: Manaclipper
-- !pos 484.604 -4.035 729.671 4
-----------------------------------
local ID = zones[xi.zone.BIBIKI_BAY]
-----------------------------------
---@type TNpcEntity
local entity = {}

local singlePrice      = 80
local multiPrice       = 500
local multiTicketRides = 10

-- Rides left on the player's multi-ticket, or -1 when they don't own one.
local function ridesRemaining(player)
    if player:hasKeyItem(xi.ki.MANACLIPPER_MULTI_TICKET) then
        return player:getCharVar('Manaclipper_Ticket')
    end

    return -1
end

entity.onTrigger = function(player, npc)
    player:startEvent(35, xi.ki.MANACLIPPER_TICKET, xi.ki.MANACLIPPER_MULTI_TICKET, singlePrice, player:getGil(), ridesRemaining(player), multiPrice)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid ~= 35 then
        return
    end

    local ownedTickets = bit.bor(
        player:hasKeyItem(xi.ki.MANACLIPPER_TICKET) and 0x01 or 0,        -- bit 0: owns a single ticket
        player:hasKeyItem(xi.ki.MANACLIPPER_MULTI_TICKET) and 0x02 or 0)  -- bit 1: owns a multi-ticket

    player:updateEvent(xi.ki.MANACLIPPER_TICKET, xi.ki.MANACLIPPER_MULTI_TICKET, ownedTickets, player:getGil(), ridesRemaining(player), multiPrice)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid ~= 35 then
        return
    end

    if option == 1 then -- single ticket
        if
            not player:hasKeyItem(xi.ki.MANACLIPPER_TICKET) and
            player:getGil() >= singlePrice
        then
            player:delGil(singlePrice)
            npcUtil.giveKeyItem(player, xi.ki.MANACLIPPER_TICKET)
        end

    elseif option == 2 then -- multi-ticket
        if
            player:getGil() >= multiPrice and
            ridesRemaining(player) < multiTicketRides
        then
            player:delGil(multiPrice)

            if player:hasKeyItem(xi.ki.MANACLIPPER_MULTI_TICKET) then
                player:setCharVar('Manaclipper_Ticket', multiTicketRides)
                player:messageSpecial(ID.text.NUM_TICKETS_ADDED_TO_MULTI, xi.ki.MANACLIPPER_MULTI_TICKET, multiTicketRides)
            else
                npcUtil.giveKeyItem(player, xi.ki.MANACLIPPER_MULTI_TICKET)
                player:setCharVar('Manaclipper_Ticket', multiTicketRides)
            end
        end
    end
end

return entity
