-----------------------------------
-- Area: Western Adoulin
--  NPC: Grevan
-- Type: Standard NPC and Quest NPC
-- Involved With Quest: 'Order Up'
-- !pos 50 0 6 256
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local Order_Up = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.ORDER_UP)
    local Order_Grevan = player:getMaskBit(player:getCharVar("Order_Up_NPCs"), 10)

    if ((Order_Up == QUEST_ACCEPTED) and (not Order_Grevan)) then
        -- Progresses Quest: 'Order Up'
        player:startEvent(69)
    else
        if (player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.HYPOCRITICAL_OATH) == QUEST_COMPLETED) then
            if (player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.NOTSOCLEAN_BILL) == QUEST_COMPLETED) then
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

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 69) then
        -- Progresses Quest: 'Order Up'
        player:setMaskBit("Order_Up_NPCs", 10, true)
    end
end
