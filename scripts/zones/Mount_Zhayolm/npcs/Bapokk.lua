-----------------------------------
-- Area: Mount Zhayolm
--  NPC: Bapokk
-- Handles access to Alzadaal Ruins
-- !pos -20 -6 276 61
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.item.IMPERIAL_SILVER_PIECE) then
        player:startEvent(163)
    end
end

entity.onTrigger = function(player, npc)
    if player:getZPos() > -280 then
        player:startEvent(164) -- Ruins -> Zhayolm
    else
        player:startEvent(162) -- Zhayolm -> Ruins
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 163 then
        player:confirmTrade()
        player:setPos(-20, -6, 0, 192) -- using the pos method until the problem below is fixed
    end
end

return entity
