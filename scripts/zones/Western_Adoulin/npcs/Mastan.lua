-----------------------------------
-- Area: Western Adoulin
--  NPC: Mastan
--  Involved with Quests: 'Order Up'
--                        'The Curious Case of Melvien'
-- !pos -9 0 67 256
-----------------------------------
local ID = require("scripts/zones/Western_Adoulin/IDs")
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local tccom = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.THE_CURIOUS_CASE_OF_MELVIEN)
    local tccomNeedKI = player:hasKeyItem(xi.ki.MELVIENS_TURN) and not player:hasKeyItem(xi.ki.MELVIENS_DEATH)
    local orderUp = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.ORDER_UP)
    local orderMastan = utils.mask.getBit(player:getCharVar("Order_Up_NPCs"), 11)

    if orderUp == QUEST_ACCEPTED and not orderMastan then
        -- Progresses Quest: 'Order Up'
        player:startEvent(70)
    elseif tccom == QUEST_ACCEPTED and tccomNeedKI then
        -- Progresses Quest: 'The Curious Case of Melvien'
        player:startEvent(184)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 70 then
        -- Progresses Quest: 'Order Up'
        player:setCharVar("Order_Up_NPCs", utils.mask.setBit(player:getCharVar("Order_Up_NPCs"), 11, true))
    elseif csid == 184 and option == 1 then
        -- Progresses Quest: 'The Curious Case of Melvien'
        player:addKeyItem(xi.ki.MELVIENS_DEATH)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MELVIENS_DEATH)
    end
end

return entity
