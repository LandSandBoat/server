-----------------------------------
-- Area: Western Adoulin
--  NPC: Terwok
--  Involved With Quest: 'Order Up'
-- !pos 127 4 -81 256
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local orderUp = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.ORDER_UP)
    local orderTerwok = utils.mask.getBit(player:getCharVar('Order_Up_NPCs'), 7)

    if orderUp == xi.questStatus.QUEST_ACCEPTED and not orderTerwok then
        -- Progresses Quest: 'Order Up'
        player:startEvent(67)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 67 then
        -- Progresses Quest: 'Order Up'
        player:setCharVar('Order_Up_NPCs', utils.mask.setBit(player:getCharVar('Order_Up_NPCs'), 7, true))
    end
end

return entity
