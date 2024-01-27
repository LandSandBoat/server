-----------------------------------
-- Area: Attohwa Chasm
--  NPC: Jakaka
-- Type: ENM
-- !pos -144.711 6.246 -250.309 7
-----------------------------------
local ID = zones[xi.zone.ATTOHWA_CHASM]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Trade Parradamo Stones
    if
        trade:hasItemQty(xi.item.POUCH_OF_PARRADAMO_STONES, 1) and
        trade:getItemCount() == 1
    then
        player:tradeComplete()
        player:startEvent(12)
    end
end

entity.onTrigger = function(player, npc)
    local miasmaFilterCD = player:getCharVar('[ENM]MiasmaFilter')

    if player:hasKeyItem(xi.ki.MIASMA_FILTER) then
        player:startEvent(11)
    else
        if miasmaFilterCD >= os.time() then
            -- Both Vanadiel time and unix timestamps are based on seconds. Add the difference to the event.
            player:startEvent(14, VanadielTime() + (miasmaFilterCD - os.time()))
        else
            if
                player:hasItem(xi.item.POUCH_OF_PARRADAMO_STONES) or
                player:hasItem(xi.item.FLAXEN_POUCH)
            then
                player:startEvent(15)
            else
                player:startEvent(13)
            end
        end
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 12 then
        player:addKeyItem(xi.ki.MIASMA_FILTER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MIASMA_FILTER)
        player:setCharVar('[ENM]MiasmaFilter', os.time() + (xi.settings.main.ENM_COOLDOWN * 3600)) -- Current time + (ENM_COOLDOWN*1hr in seconds)
    elseif csid == 13 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.FLAXEN_POUCH)
            return
        else
            player:addItem(xi.item.FLAXEN_POUCH)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.FLAXEN_POUCH)
        end
    end
end

return entity
