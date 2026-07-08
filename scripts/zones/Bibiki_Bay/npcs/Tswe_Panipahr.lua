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

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 35 then
        if option == 1 then
            player:delGil(80)
            npcUtil.giveKeyItem(player, xi.ki.MANACLIPPER_TICKET)
        elseif option == 2 then
            player:delGil(500)
            npcUtil.giveKeyItem(player, xi.ki.MANACLIPPER_MULTI_TICKET)
            player:setCharVar('Manaclipper_Ticket', 10)
        end
    end
end

return entity
