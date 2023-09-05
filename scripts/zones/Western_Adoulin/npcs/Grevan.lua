-----------------------------------
-- Area: Western Adoulin
--  NPC: Grevan
-- Involved With Quest: 'Order Up'
-- !pos 50 0 6 256
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local orderUp = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.ORDER_UP)
    local orderGrevan = utils.mask.getBit(player:getCharVar("Order_Up_NPCs"), 10)

    if orderUp == QUEST_ACCEPTED and not orderGrevan then
        -- Progresses Quest: 'Order Up'
        player:startEvent(69)
    else
        if player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.HYPOCRITICAL_OATH) == QUEST_COMPLETED then
            if player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.NOTSOCLEAN_BILL) == QUEST_COMPLETED then
                -- Standard dialogue after stamping out plague in Svenja quest line
                player:startEvent(188)
            else
                -- Standard dialogue before stamping out plague in Svenja quest line
                player:startEvent(171)
            end
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 69 then
        -- Progresses Quest: 'Order Up'
        player:setCharVar("Order_Up_NPCs", utils.mask.setBit(player:getCharVar("Order_Up_NPCs"), 10, true))
    end
end

return entity
