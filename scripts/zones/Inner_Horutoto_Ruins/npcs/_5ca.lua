-----------------------------------
-- Area: Inner Horutoto Ruins
--  NPC: Mahogany Door
-- Involved In Quest: Making Headlines
-- Involved in Mission 2-1
-- !pos -11 0 20 192
-----------------------------------
local ID = zones[xi.zone.INNER_HORUTOTO_RUINS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local makingHeadlines = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.MAKING_HEADLINES)

    -- bitmask of progress: 0 = Kyume-Romeh, 1 = Yuyuju, 2 = Hiwom-Gomoi, 3 = Umumu, 4 = Mahogany Door
    local prog = player:getCharVar('QuestMakingHeadlines_var')

    if
        makingHeadlines == xi.questStatus.QUEST_ACCEPTED and
        utils.mask.isFull(prog, 4) and
        not utils.mask.getBit(prog, 4)
    then
        player:messageSpecial(ID.text.CAT_BURGLARS_HIDEOUT, 1, xi.ki.WINDURST_WOODS_SCOOP) -- Confirm Story
        player:setCharVar('QuestMakingHeadlines_var', utils.mask.setBit(prog, 4, true))
    end
end

return entity
