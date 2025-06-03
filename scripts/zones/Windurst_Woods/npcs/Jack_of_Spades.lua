-----------------------------------
-- Area: Windurst Woods
--  NPC: Jack of Spades
-- Adventurer's Assistant
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.item.ADVENTURER_COUPON) then -- adventurer coupon
        player:startEvent(10010, xi.settings.main.GIL_RATE * 50)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(10009, 0, 4)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10010 then
        player:confirmTrade()
        player:addGil(xi.settings.main.GIL_RATE * 50)
    end
end

return entity
