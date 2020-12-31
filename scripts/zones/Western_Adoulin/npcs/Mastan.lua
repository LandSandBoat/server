-----------------------------------
-- Area: Western Adoulin
--  NPC: Virsaint
-- Type: Standard NPC and Quest NPC
--  Involved with Quests: 'Order Up'
--                        'The Curious Case of Melvien'
-- !pos -9 0 67 256
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local TCCOM = player:getQuestStatus(tpz.quest.log_id.ADOULIN, tpz.quest.id.adoulin.THE_CURIOUS_CASE_OF_MELVIEN)
    local TCCOM_Need_KI = player:hasKeyItem(tpz.ki.MELVIENS_TURN) and not player:hasKeyItem(tpz.ki.MELVIENS_DEATH)
    local Order_Up = player:getQuestStatus(tpz.quest.log_id.ADOULIN, tpz.quest.id.adoulin.ORDER_UP)
    local Order_Mastan = utils.mask.getBit(player:getCharVar("Order_Up_NPCs"), 11)

    if Order_Up == QUEST_ACCEPTED and not Order_Mastan then
        -- Progresses Quest: 'Order Up'
        player:startEvent(70)
    elseif TCCOM == QUEST_ACCEPTED and TCCOM_Need_KI then
        -- Progresses Quest: 'The Curious Case of Melvien'
        player:startEvent(184)
    else
        -- Standard Dialogue
        player:startEvent(525)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 70 then
        -- Progresses Quest: 'Order Up'
        player:setCharVar("Order_Up_NPCs", utils.mask.setBit(player:getCharVar("Order_Up_NPCs"), 11, true))
    elseif csid == 184 and option == 1 then
        -- Progresses Quest: 'The Curious Case of Melvien'
        player:addKeyItem(tpz.ki.MELVIENS_DEATH)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MELVIENS_DEATH)
    end
end
