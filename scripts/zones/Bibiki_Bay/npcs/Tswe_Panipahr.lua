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

entity.onTrigger = function(player, npc)
    player:startEvent(35, xi.ki.MANACLIPPER_TICKET, xi.ki.MANACLIPPER_MULTI_TICKET, 80, player:getGil(), 0, 500)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid ~= 35 then
        return
    end

    local playerGil = player:getGil()

    -- Buy single.
    if option == 1 then
        if player:hasKeyItem(xi.ki.MANACLIPPER_TICKET) then
            player:messageSpecial(ID.text.HAVE_BILLET, xi.ki.MANACLIPPER_TICKET)
            return
        end

        if playerGil >= 80 then
            player:delGil(80)
            npcUtil.giveKeyItem(player, xi.ki.MANACLIPPER_TICKET)
        end

    -- Buy multi.
    elseif option == 2 then
        if player:hasKeyItem(xi.ki.MANACLIPPER_MULTI_TICKET) then
            local manaclipperTicketAmount = player:getCharVar('Manaclipper_Ticket')
            if manaclipperTicketAmount == 10 then
                player:messageSpecial(ID.text.NO_NEED_TO_PURCHASE)
                return
            end

            if playerGil >= 500 then
                player:delGil(500)
                player:messageSpecial(ID.text.NUM_TICKETS_ADDED_TO_MULTI, xi.ki.MANACLIPPER_MULTI_TICKET, 10 - manaclipperTicketAmount)
                player:setCharVar('Manaclipper_Ticket', 10)
            end
        else
            if playerGil >= 500 then
                player:delGil(500)
                npcUtil.giveKeyItem(player, xi.ki.MANACLIPPER_MULTI_TICKET)
                player:setCharVar('Manaclipper_Ticket', 10)
            end
        end
    end
end

return entity
