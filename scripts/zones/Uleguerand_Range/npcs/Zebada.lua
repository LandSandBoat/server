-----------------------------------
-- Area: Uleguerand Range
--  NPC: Zebada
-- Type: ENM Quest Activator
-- !pos -308.112 -42.137 -570.096 5
-----------------------------------
local ID = require("scripts/zones/Uleguerand_Range/IDs")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Trade Chamnaet Ice
    if trade:hasItemQty(1780, 1) and trade:getItemCount() == 1 then
        player:tradeComplete()
        player:startEvent(13)
    end
end

entity.onTrigger = function(player, npc)
    local zephyrFanCD = player:getCharVar("[ENM]ZephyrFan")

    if player:hasKeyItem(xi.ki.ZEPHYR_FAN) then
        player:startEvent(12)
    else
        if zephyrFanCD >= os.time() then
            -- Both Vanadiel time and unix timestamps are based on seconds. Add the difference to the event.
            player:startEvent(15, VanadielTime() + (zephyrFanCD - os.time()))
        else
            if player:hasItem(1780) or player:hasItem(1779) then -- Chamnaet Ice -- Cotton Pouch
                player:startEvent(16)
            else
                player:startEvent(14)
            end
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 13 then
        player:addKeyItem(xi.ki.ZEPHYR_FAN)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.ZEPHYR_FAN)
        player:setCharVar("[ENM]ZephyrFan", os.time() + (xi.settings.main.ENM_COOLDOWN * 3600)) -- Current time + (ENM_COOLDOWN*1hr in seconds)
    elseif csid == 14 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1779) -- Cotton Pouch
            return
        else
            player:addItem(1779)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1779) -- Cotton Pouch
        end
    end
end

return entity
