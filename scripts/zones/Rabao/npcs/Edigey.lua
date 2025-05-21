-----------------------------------
-- Area: Rabao
--  NPC: Edigey
-- Starts and Ends Quest: Don't Forget the Antidote
-----------------------------------
local ID = zones[xi.zone.RABAO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local forgetTheAntidote = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.DONT_FORGET_THE_ANTIDOTE)

    if
        (forgetTheAntidote == xi.questStatus.QUEST_ACCEPTED or forgetTheAntidote == xi.questStatus.QUEST_COMPLETED) and
        trade:hasItemQty(xi.item.VIAL_OF_DESERT_VENOM, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(4, 0, xi.item.VIAL_OF_DESERT_VENOM)
    end
end

entity.onTrigger = function(player, npc)
    local forgetTheAntidote = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.DONT_FORGET_THE_ANTIDOTE)

    if
        forgetTheAntidote == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.SELBINA_RABAO) >= 4
    then
        player:startEvent(2, 0, xi.item.VIAL_OF_DESERT_VENOM)
    elseif forgetTheAntidote == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(3, 0, xi.item.VIAL_OF_DESERT_VENOM)
    elseif forgetTheAntidote == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(5, 0, xi.item.VIAL_OF_DESERT_VENOM)
    else
        player:startEvent(50)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 2 and option == 1 then
        player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.DONT_FORGET_THE_ANTIDOTE)
        player:setCharVar('DontForgetAntidoteVar', 1)
    elseif csid == 4 and player:getCharVar('DontForgetAntidoteVar') == 1 then --If completing for the first time
        player:setCharVar('DontForgetAntidoteVar', 0)
        player:tradeComplete()
        player:addTitle(xi.title.DESERT_HUNTER)
        player:addItem(xi.item.DOTANUKI) -- Dotanuki
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.DOTANUKI)
        player:completeQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.DONT_FORGET_THE_ANTIDOTE)
        player:addFame(xi.fameArea.SELBINA_RABAO, 60)
    elseif csid == 4 then --Subsequent completions
        player:tradeComplete()
        npcUtil.giveCurrency(player, 'gil', 1800)
        player:addFame(xi.fameArea.SELBINA_RABAO, 30)
    end
end

return entity
