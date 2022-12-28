-----------------------------------
-- Area: Western Adoulin
--  NPC: Majoirelle
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
    local orderUp = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.ORDER_UP)
    local orderMarjoirelle = utils.mask.getBit(player:getCharVar("Order_Up_NPCs"), 8)

    if orderUp == QUEST_ACCEPTED and not orderMarjoirelle then
        -- Progresses Quest: 'Order Up'
        player:startEvent(68)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 68 then
        -- Progresses Quest: 'Order Up'
        player:setCharVar("Order_Up_NPCs", utils.mask.setBit(player:getCharVar("Order_Up_NPCs"), 8, true))
    end
end

return entity
