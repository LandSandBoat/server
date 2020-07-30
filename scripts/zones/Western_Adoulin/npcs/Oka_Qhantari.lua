-----------------------------------
-- Area: Western Adoulin
--  NPC: Oka Qhantari
-- Type: Standard NPC and Quest NPC
--  Involved With Quest: 'Order Up'
-- !pos -30 3 -6 256
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local Order_Up = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.ORDER_UP)
    local Order_Oka_Qhantari = player:getMaskBit(player:getCharVar("Order_Up_NPCs"), 9)

    if ((Order_Up == QUEST_ACCEPTED) and (not Order_Oka_Qhantari)) then
        -- Progresses Quest: 'Order Up'
        player:startEvent(71)
    else
        -- Standard Dialogue
        player:startEvent(511)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 71) then
        -- Progresses Quest: 'Order Up'
        player:setMaskBit("Order_Up_NPCs", 9, true)
    end
end
