-----------------------------------
-- Area: Port Windurst
--  NPC: Ohruru
-- Starts & Finishes Repeatable Quest: Catch me if you can
-- Involved in Quest: Wonder Wands
-- Note: Animation for his "Cure" is not functioning. Unable to capture option 1, so if the user says no, he heals them anyways.
-- !pos -108 -5 94 240
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local catch = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CATCH_IT_IF_YOU_CAN)
    local wonderWands = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.WONDER_WANDS)

    if wonderWands == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(258, 0, 17053)
    elseif catch == 0 then
        local prog = player:getCharVar('QuestCatchItIfYouCan_var')
        if prog == 0 then
            player:startEvent(230) -- CATCH IT IF YOU CAN: Before Quest 1
            player:setCharVar('QuestCatchItIfYouCan_var', 1)
        elseif prog == 1 then
            player:startEvent(253) -- CATCH IT IF YOU CAN: Before Start
            player:setCharVar('QuestCatchItIfYouCan_var', 2)
        elseif prog == 2 then
            player:startEvent(231) -- CATCH IT IF YOU CAN: Before Quest 2
        end

    elseif
        catch >= 1 and
        (
            player:hasStatusEffect(xi.effect.MUTE) or
            player:hasStatusEffect(xi.effect.BANE) or
            player:hasStatusEffect(xi.effect.PLAGUE)
        )
    then
        player:startEvent(246) -- CATCH IT IF YOU CAN: Quest Turn In 1
    elseif catch >= 1 and player:needToZone() then
        player:startEvent(255) -- CATCH IT IF YOU CAN: After Quest
    elseif
        catch == 1 and
        not player:hasStatusEffect(xi.effect.MUTE) and
        not player:hasStatusEffect(xi.effect.BANE) and
        not player:hasStatusEffect(xi.effect.PLAGUE)
    then
        local rand = math.random(1, 2)
        if rand == 1 then
            player:startEvent(248) -- CATCH IT IF YOU CAN: During Quest 1
        else
            player:startEvent(251) -- CATCH IT IF YOU CAN: During Quest 2
        end
    elseif wonderWands == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(265)
    else
        player:startEvent(230) -- STANDARD CONVERSATION
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 231 then
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.CATCH_IT_IF_YOU_CAN)
    elseif csid == 246 and option == 0 then
        player:needToZone(true)
        if player:hasStatusEffect(xi.effect.MUTE) then
            player:delStatusEffect(xi.effect.MUTE)
            npcUtil.giveCurrency(player, 'gil', 1000)
        elseif player:hasStatusEffect(xi.effect.BANE) then
            player:delStatusEffect(xi.effect.BANE)
            npcUtil.giveCurrency(player, 'gil', 1200)
        elseif player:hasStatusEffect(xi.effect.PLAGUE) then
            player:delStatusEffect(xi.effect.PLAGUE)
            npcUtil.giveCurrency(player, 'gil', 1500)
        end

        player:setCharVar('QuestCatchItIfYouCan_var', 0)

        if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CATCH_IT_IF_YOU_CAN) == xi.questStatus.QUEST_ACCEPTED then
            player:completeQuest(xi.questLog.WINDURST, xi.quest.id.windurst.CATCH_IT_IF_YOU_CAN)
            player:addFame(xi.fameArea.WINDURST, 75)
        else
            player:addFame(xi.fameArea.WINDURST, 8)
        end
    end
end

return entity
