-----------------------------------
-- Area: Mount Zhayolm
--  NPC: Bapokk
-- Handles access to Alzadaal Ruins
-- !pos -20 -6 276 61
-----------------------------------
local ID = zones[xi.zone.MOUNT_ZHAYOLM]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:getItemCount() == 1 and
        trade:hasItemQty(xi.item.IMPERIAL_SILVER_PIECE, 1)
    then
        player:tradeComplete()
        player:startEvent(163)
    end
end

entity.onTrigger = function(player, npc)
    if player:getZPos() > 280 then
        player:startEvent(164) -- Ruins -> Zhayolm
    else
        if player:hasKeyItem(xi.ki.CAPTAIN_WILDCAT_BADGE) then -- Zhayolm -> Ruins
            player:messageSpecial(ID.text.YOU_HAVE_A_BADGE, xi.ki.CAPTAIN_WILDCAT_BADGE)
            player:startEvent(163)
        else
            player:startEvent(162)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 163 then
        player:setPos(100, -4, -675, 192, xi.zone.ALZADAAL_UNDERSEA_RUINS)
    end
end

return entity
