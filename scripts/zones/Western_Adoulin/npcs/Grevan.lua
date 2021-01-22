-----------------------------------
-- Area: Western Adoulin
--  NPC: Grevan
-- Type: Standard NPC and Quest NPC
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
    local Order_Up = player:getQuestStatus(tpz.quest.log_id.ADOULIN, tpz.quest.id.adoulin.ORDER_UP)
    local Order_Grevan = utils.mask.getBit(player:getCharVar("Order_Up_NPCs"), 10)

    if Order_Up == QUEST_ACCEPTED and not Order_Grevan then
        -- Progresses Quest: 'Order Up'
        player:startEvent(69)
    else
        if player:getQuestStatus(tpz.quest.log_id.ADOULIN, tpz.quest.id.adoulin.HYPOCRITICAL_OATH) == QUEST_COMPLETED then
            if player:getQuestStatus(tpz.quest.log_id.ADOULIN, tpz.quest.id.adoulin.NOTSOCLEAN_BILL) == QUEST_COMPLETED then
                -- Standard dialogue after stamping out plague in Svenja quest line
                player:startEvent(188)
            else
                -- Standard dialogue before stamping out plague in Svenja quest line
                player:startEvent(171)
            end
        else
            -- Standard dialogue prior to Svenja quest line
            player:startEvent(541)
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
