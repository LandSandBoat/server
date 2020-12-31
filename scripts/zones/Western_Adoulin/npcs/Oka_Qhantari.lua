-----------------------------------
-- Area: Western Adoulin
--  NPC: Oka Qhantari
-- Type: Standard NPC and Quest NPC
--  Involved With Quest: 'Order Up'
-- !pos -30 3 -6 256
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local Order_Up = player:getQuestStatus(tpz.quest.log_id.ADOULIN, tpz.quest.id.adoulin.ORDER_UP)
    local Order_Oka_Qhantari = utils.mask.getBit(player:getCharVar("Order_Up_NPCs"), 9)

    if Order_Up == QUEST_ACCEPTED and not Order_Oka_Qhantari then
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
    if csid == 71 then
        -- Progresses Quest: 'Order Up'
        player:setCharVar("Order_Up_NPCs", utils.mask.setBit(player:getCharVar("Order_Up_NPCs"), 9, true))
    end
end
