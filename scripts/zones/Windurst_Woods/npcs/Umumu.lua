-----------------------------------
-- Area: Windurst Woods
--  NPC: Umumu
--  Involved In Quest: Making Headlines
-- !pos 32.575 -5.250 141.372 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local makingHeadlines = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.MAKING_HEADLINES)
    local lureOfTheWildcat = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT)
    local wildcatWindurst = player:getCharVar('WildcatWindurst')

    if
        lureOfTheWildcat == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 3)
    then
        player:startEvent(731)
    elseif makingHeadlines == xi.questStatus.QUEST_ACCEPTED then
        -- bitmask of progress: 0 = Kyume-Romeh, 1 = Yuyuju, 2 = Hiwom-Gomoi, 3 = Umumu, 4 = Mahogany Door
        local prog = player:getCharVar('QuestMakingHeadlines_var')

        if utils.mask.getBit(prog, 4) then
            player:startEvent(383) -- Advised to go to Naiko
        elseif not utils.mask.getBit(prog, 3) then
            player:startEvent(381) -- Get scoop and asked to validate
        else
            player:startEvent(382) -- Reminded to validate
        end
    elseif makingHeadlines == xi.questStatus.QUEST_COMPLETED then
        local rand = math.random(1, 3)

        if rand == 1 then
            player:startEvent(385) -- Conversation after quest completed
        elseif rand == 2 then
            player:startEvent(386) -- Conversation after quest completed
        elseif rand == 3 then
            player:startEvent(414) -- Standard Conversation
        end
    else
        player:startEvent(414) -- Standard Conversation
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 381 then
        npcUtil.giveKeyItem(player, xi.ki.WINDURST_WOODS_SCOOP)
        player:setCharVar('QuestMakingHeadlines_var', utils.mask.setBit(player:getCharVar('QuestMakingHeadlines_var'), 3, true))
    elseif csid == 731 then
        player:setCharVar('WildcatWindurst', utils.mask.setBit(player:getCharVar('WildcatWindurst'), 3, true))
    end
end

return entity
