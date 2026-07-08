-----------------------------------
-- Area: Port Jeuno
--  NPC: Guddal
-- Starts and Finishes Quest: Kazham Airship Pass (This quest does not appear in your quest log) -- Becouse it isn't.
-- !pos -14 8 44 246
-----------------------------------
local ID = zones[xi.zone.PORT_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if not player:hasKeyItem(xi.ki.AIRSHIP_PASS_FOR_KAZHAM) then
        if
            trade:hasItemQty(xi.item.GHELSBA_CHEST_KEY, 1) and
            trade:hasItemQty(xi.item.PALBOROUGH_CHEST_KEY, 1) and
            trade:hasItemQty(xi.item.GIDDEUS_CHEST_KEY, 1) and
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
    if not player:hasKeyItem(xi.ki.AIRSHIP_PASS_FOR_KAZHAM) then
        player:startEvent(300)
    else
        player:startEvent(300, 0, 0, 0, 0, 0, 6)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 300 and option == 99 then
        if player:delGil(148000) then
            player:addKeyItem(xi.ki.AIRSHIP_PASS_FOR_KAZHAM)
            player:updateEvent(0, 1)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 300 and option == 33 and
        player:hasKeyItem(xi.ki.AIRSHIP_PASS_FOR_KAZHAM)
    then
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.AIRSHIP_PASS_FOR_KAZHAM)
    elseif csid == 301 then
        npcUtil.giveKeyItem(player, xi.ki.AIRSHIP_PASS_FOR_KAZHAM)
        player:tradeComplete()
    end
end

return entity
