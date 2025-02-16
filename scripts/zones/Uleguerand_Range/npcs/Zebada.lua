-----------------------------------
-- Area: Uleguerand Range
--  NPC: Zebada
-- Type: ENM Quest Activator
-- !pos -308.112 -42.137 -570.096 5
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Trade Chamnaet Ice
    if
        trade:hasItemQty(xi.item.HANDFUL_OF_CHAMNAET_ICE, 1) and
        trade:getItemCount() == 1
    then
        player:tradeComplete()
        player:startEvent(13)
    end
end

entity.onTrigger = function(player, npc)
    local zephyrFanCD = player:getCharVar('[ENM]ZephyrFan')

    if player:hasKeyItem(xi.ki.ZEPHYR_FAN) then
        player:startEvent(12)
    else
        if zephyrFanCD >= os.time() then
            -- Both Vanadiel time and unix timestamps are based on seconds. Add the difference to the event.
            player:startEvent(15, VanadielTime() + (zephyrFanCD - os.time()))
        else
            if
                player:hasItem(xi.item.HANDFUL_OF_CHAMNAET_ICE) or
                player:hasItem(xi.item.COTTON_POUCH)
            then
                player:startEvent(16)
            else
                player:startEvent(14)
            end
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 13 then
        npcUtil.giveKeyItem(player, xi.ki.ZEPHYR_FAN)
        player:setCharVar('[ENM]ZephyrFan', os.time() + (xi.settings.main.ENM_COOLDOWN * 3600)) -- Current time + (ENM_COOLDOWN*1hr in seconds)
    elseif csid == 14 then
        npcUtil.giveItem(player, xi.item.COTTON_POUCH)
    end
end

return entity
