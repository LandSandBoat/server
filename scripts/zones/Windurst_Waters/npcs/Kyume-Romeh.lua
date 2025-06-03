-----------------------------------
-- Area: Windurst Waters
--  NPC: Kyume-Romeh
--  Involved In Quest: Making Headlines, Hat in Hand
-- !pos -58 -4 23 238
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local makingHeadlines = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.MAKING_HEADLINES)
    local lureOfTheWildcat = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT)
    local wildcatWindurst = player:getCharVar('WildcatWindurst')

    if
        lureOfTheWildcat == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatWindurst, 14)
    then
        player:startEvent(939)
    elseif
        player:hasKeyItem(xi.ki.NEW_MODEL_HAT) and
        not utils.mask.getBit(player:getCharVar('QuestHatInHand_var'), 4)
    then
        player:messageSpecial(ID.text.YOU_SHOW_OFF_THE, 0, xi.ki.NEW_MODEL_HAT)
        player:startEvent(60)
    elseif makingHeadlines == xi.questStatus.QUEST_ACCEPTED then
        -- bitmask of progress: 0 = Kyume-Romeh, 1 = Yuyuju, 2 = Hiwom-Gomoi, 3 = Umumu, 4 = Mahogany Door
        local prog = player:getCharVar('QuestMakingHeadlines_var')

        if not utils.mask.getBit(prog, 0) then
            player:startEvent(668) -- Quest progress
        else
            player:startEvent(669) -- Quest not furthered
        end
    else
        if math.random(1, 100) <= 50 then
            player:startEvent(604) -- Standard Conversation
        else
            player:startEvent(393) -- Standard Conversation
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 668 then
        npcUtil.giveKeyItem(player, xi.ki.WINDURST_WATERS_SCOOP)
        player:setCharVar('QuestMakingHeadlines_var', utils.mask.setBit(player:getCharVar('QuestMakingHeadlines_var'), 0, true))
    elseif csid == 60 then
        player:setCharVar('QuestHatInHand_var', utils.mask.setBit(player:getCharVar('QuestHatInHand_var'), 4, true))
        player:incrementCharVar('QuestHatInHand_count', 1)
    elseif csid == 939 then
        player:setCharVar('WildcatWindurst', utils.mask.setBit(player:getCharVar('WildcatWindurst'), 14, true))
    end
end

return entity
