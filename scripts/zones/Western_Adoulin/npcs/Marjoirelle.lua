-----------------------------------
-- Area: Western Adoulin
--  NPC: Majoirelle
--  Involved With Quest: 'Order Up'
-- !pos 127 4 -81 256
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local orderUp = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.ORDER_UP)
    local orderMarjoirelle = utils.mask.getBit(player:getCharVar('Order_Up_NPCs'), 8)

    if orderUp == xi.questStatus.QUEST_ACCEPTED and not orderMarjoirelle then
        -- Progresses Quest: 'Order Up'
        player:startEvent(68)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 68 then
        -- Progresses Quest: 'Order Up'
        player:setCharVar('Order_Up_NPCs', utils.mask.setBit(player:getCharVar('Order_Up_NPCs'), 8, true))
    end
end

return entity
