-----------------------------------
-- Area: Western Adoulin
--  NPC: Grevan
-- Involved With Quest: 'Order Up'
-- !pos 50 0 6 256
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local orderUp = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.ORDER_UP)
    local orderGrevan = utils.mask.getBit(player:getCharVar('Order_Up_NPCs'), 10)

    if orderUp == xi.questStatus.QUEST_ACCEPTED and not orderGrevan then
        -- Progresses Quest: 'Order Up'
        player:startEvent(69)
    else
        if player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.HYPOCRITICAL_OATH) == xi.questStatus.QUEST_COMPLETED then
            if player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.NOTSOCLEAN_BILL) == xi.questStatus.QUEST_COMPLETED then
                -- Standard dialogue after stamping out plague in Svenja quest line
                player:startEvent(188)
            else
                -- Standard dialogue before stamping out plague in Svenja quest line
                player:startEvent(171)
            end
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 69 then
        -- Progresses Quest: 'Order Up'
        player:setCharVar('Order_Up_NPCs', utils.mask.setBit(player:getCharVar('Order_Up_NPCs'), 10, true))
    end
end

return entity
