-----------------------------------
-- Area: Western Adoulin
--  NPC: Chanteillie
-- Involved with Quests: 'Do Not Go Into the Light'
--                       'Vegetable Vegetable Crisis'
-- !pos 89 0 -75 256
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local dngitl = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.DO_NOT_GO_INTO_THE_LIGHT)
    local vvc = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.VEGETABLE_VEGETABLE_CRISIS)

    -- DO NOT GO INTO THE LIGHT (Urunday Lumber, Damascus Ingot, Fire Crystal)
    if
        dngitl == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('DNGITL_Status') == 3 and
        npcUtil.tradeHas(trade, { 3927, 658, 4096 })
    then
        player:startEvent(5076)

    -- VEGETABLE VEGETABLE CRISIS (Urunday Lumber, Midrium Ingot, Raaz Leather)
    elseif
        vvc == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('VVC_Status') == 1 and
        npcUtil.tradeHas(trade, { 3927, 3919, 8708 })
    then
        player:startEvent(5089)
    end
end

entity.onTrigger = function(player, npc)
    local dngitl = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.DO_NOT_GO_INTO_THE_LIGHT)
    local vvc = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.VEGETABLE_VEGETABLE_CRISIS)

    -- DO NOT GO INTO THE LIGHT
    if
        dngitl == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.INVENTORS_COALITION_PICKAXE)
    then
        player:startEvent(5077)

    -- VEGETABLE VEGETABLE CRISIS
    elseif vvc == xi.questStatus.QUEST_ACCEPTED and player:getCharVar('VVC_Status') == 1 then
        player:startEvent(5088)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- DO NOT GO INTO THE LIGHT
    if csid == 5076 then
        player:confirmTrade()
        npcUtil.giveKeyItem(player, xi.ki.INVENTORS_COALITION_PICKAXE)
        player:setCharVar('DNGITL_Status', 0)

    -- VEGETABLE VEGETABLE CRISIS
    elseif csid == 5089 then
        player:confirmTrade()
        player:setCharVar('VVC_Status', 2)
        player:setCharVar('VVC_Gameday_Wait', VanadielUniqueDay())
    end
end

return entity
