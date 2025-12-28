-----------------------------------
-- Area: Windurst Woods
--  NPC: Kuoh Rhel
-- Starts quests: Chocobilious, In a Stew
-- !pos 131.437 -6 -102.723 241
--  Note: In a Stew should only repeat once per conquest tally. The tally is not implemented at time of
--        writing this quest. Once it is working please feel free to add it in ^^
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local chocobilious = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CHOCOBILIOUS)

    -- CHOCOBILIOUS
    if
        chocobilious == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.WINDURST) >= 2
    then
        player:startEvent(224) -- Start quest
    elseif chocobilious == xi.questStatus.QUEST_COMPLETED and player:needToZone() then
        player:startEvent(232) -- Quest complete
    elseif
        chocobilious == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('ChocobiliousQuest') == 2
    then
        player:startEvent(231) -- Talked to Tapoh
    elseif chocobilious == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(225) -- Post quest accepted
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- CHOCOBILIOUS
    if csid == 224 and option == 1 then
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.CHOCOBILIOUS)
    elseif
        csid == 231 and
        npcUtil.completeQuest(player, xi.questLog.WINDURST, xi.quest.id.windurst.CHOCOBILIOUS, { fame = 220, gil = 1500, var = 'ChocobiliousQuest' })
    then
        player:needToZone(true)
    end
end

return entity
