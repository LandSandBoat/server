-----------------------------------
-- Area: Western Adoulin
--  NPC: Terwok
--  Involved With Quest: 'Order Up'
-- !pos 127 4 -81 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local orderUp = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.ORDER_UP)
    local orderTerwok = utils.mask.getBit(player:getCharVar('Order_Up_NPCs'), 7)

    if orderUp == QUEST_ACCEPTED and not orderTerwok then
        -- Progresses Quest: 'Order Up'
        player:startEvent(67)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 67 then
        -- Progresses Quest: 'Order Up'
        player:setCharVar('Order_Up_NPCs', utils.mask.setBit(player:getCharVar('Order_Up_NPCs'), 7, true))
    end
end

return entity
