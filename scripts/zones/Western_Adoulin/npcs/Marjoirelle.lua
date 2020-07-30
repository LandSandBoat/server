-----------------------------------
-- Area: Western Adoulin
--  NPC: Majoirelle
-- Type: Standard NPC and Quest NPC
--  Involved With Quest: 'Order Up'
-- !pos 127 4 -81 256
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local Order_Up = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.ORDER_UP)
    local Order_Marjoirelle = player:getMaskBit(player:getCharVar("Order_Up_NPCs"), 8)

    if ((Order_Up == QUEST_ACCEPTED) and (not Order_Marjoirelle)) then
        -- Progresses Quest: 'Order Up'
        player:startEvent(68)
    else
        -- Standard Dialogue
        player:startEvent(538)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 68) then
        -- Progresses Quest: 'Order Up'
        player:setMaskBit("Order_Up_NPCs", 8, true)
    end
end
