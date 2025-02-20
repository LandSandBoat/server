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
    local inAStew = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.IN_A_STEW)
    local inAStewCS = player:getCharVar('IASvar')
    local chocobilious = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CHOCOBILIOUS)

    -- IN A STEW
    if
        inAStew == xi.questStatus.QUEST_AVAILABLE and
        chocobilious == xi.questStatus.QUEST_COMPLETED and
        player:getFameLevel(xi.fameArea.WINDURST) >= 3
    then
        if player:needToZone() then
            player:startEvent(232) -- Post quest dialog from Chocobilious
        else
            player:startEvent(235) -- IAS start
        end
    elseif inAStewCS == 4 and player:hasKeyItem(xi.ki.RANPI_MONPIS_SPECIAL_STEW) then
        player:startEvent(239) -- IAS turn in
    elseif inAStew == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(236) -- reminder dialog
    -- Uncomment once conquest tally in place
    --elseif inAStew == xi.questStatus.QUEST_COMPLETED then
        --player:startEvent(240) -- new dialog between repeats
    elseif inAStew == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(234) -- start repeat

    -- CHOCOBILIOUS
    elseif
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

    -- STANDARD DIALOG
    else
        player:startEvent(222)
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

    -- IN A STEW
    elseif csid == 235 then
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.IN_A_STEW)
        player:setCharVar('IASvar', 1)
    elseif
        csid == 239 and
        npcUtil.completeQuest(player, xi.questLog.WINDURST, xi.quest.id.windurst.IN_A_STEW, { fame = 50, gil = 900, var = 'IASvar' })
    then
        player:delKeyItem(xi.ki.RANPI_MONPIS_SPECIAL_STEW)
    elseif csid == 234 and option == 1 then -- start repeat
        player:setCharVar('IASvar', 3)
    end
end

return entity
