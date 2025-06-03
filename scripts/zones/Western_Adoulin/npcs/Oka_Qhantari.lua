-----------------------------------
-- Area: Western Adoulin
--  NPC: Oka Qhantari
--  Involved With Quest: 'Order Up'
-- !pos -30 3 -6 256
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local orderUp = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.ORDER_UP)
    local orderOkaQhantari = utils.mask.getBit(player:getCharVar('Order_Up_NPCs'), 9)

    if orderUp == xi.questStatus.QUEST_ACCEPTED and not orderOkaQhantari then
        -- Progresses Quest: 'Order Up'
        player:startEvent(71)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 71 then
        -- Progresses Quest: 'Order Up'
        player:setCharVar('Order_Up_NPCs', utils.mask.setBit(player:getCharVar('Order_Up_NPCs'), 9, true))
    end
end

return entity
