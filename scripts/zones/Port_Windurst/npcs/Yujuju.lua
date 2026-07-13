-----------------------------------
-- Area: Port Windurst
--  NPC: Yujuju
--  Involved In Quest: Making Headlines
-- !pos 201.523 -4.785 138.978 240
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local makingHeadlines = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.MAKING_HEADLINES)

    if makingHeadlines == xi.questStatus.QUEST_ACCEPTED then
        -- bitmask of progress: 0 = Kyume-Romeh, 1 = Yuyuju, 2 = Hiwom-Gomoi, 3 = Umumu, 4 = Mahogany Door
        local prog = player:getCharVar('QuestMakingHeadlines_var')

        if not utils.mask.getBit(prog, 1) then
            player:startEvent(314) -- Get Scoop
        else
            player:startEvent(315) -- After receiving scoop
        end
    else
        player:startEvent(340) -- Standard Conversation
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 314 then
        npcUtil.giveKeyItem(player, xi.ki.PORT_WINDURST_SCOOP)
        player:setCharVar('QuestMakingHeadlines_var', utils.mask.setBit(player:getCharVar('QuestMakingHeadlines_var'), 1, true))
    end
end

return entity
