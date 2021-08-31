-----------------------------------
-- Area: Western Adoulin
--  NPC: Terwok
-- Type: Standard NPC and Quest NPC
--  Involved With Quest: 'Order Up'
-- !pos 127 4 -81 256
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local Order_Up = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.ORDER_UP)
    local Order_Terwok = utils.mask.getBit(player:getCharVar("Order_Up_NPCs"), 7)

    if Order_Up == QUEST_ACCEPTED and not Order_Terwok then
        -- Progresses Quest: 'Order Up'
        player:startEvent(67)
    else
        -- Standard Dialogue
        player:startEvent(532)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 67 then
        -- Progresses Quest: 'Order Up'
        player:setCharVar("Order_Up_NPCs", utils.mask.setBit(player:getCharVar("Order_Up_NPCs"), 7, true))
    end
end

return entity
