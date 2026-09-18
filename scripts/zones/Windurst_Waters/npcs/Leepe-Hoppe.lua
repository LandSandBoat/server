-----------------------------------
-- Area: Windurst Waters
--  NPC: Leepe-Hoppe
-- Involved in Mission 1-3, Mission 7-2
-- !pos 13 -9 -197 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, { 1696, 1697, 1698 }) and -- Magicked Steel Ingot, Spruce Lumber, Extra-fine File
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TUNING_IN) == xi.questStatus.QUEST_ACCEPTED
    then
        player:startEvent(886)
    end
end

entity.onTrigger = function(player, npc)
    local tuningIn = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TUNING_IN)
    local tuningOut = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TUNING_OUT)

    -- Tuning In
    if
        tuningIn == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.WINDURST) >= 4 and
        (player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.DISTANT_BELIEFS or player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LAST_VERSE))
    then
        player:startEvent(884, 0, 1696, 1697, 1698) -- Magicked Steel Ingot, Spruce Lumber, Extra-fine File

    -- Tuning Out
    elseif
        tuningIn == xi.questStatus.QUEST_COMPLETED and
        tuningOut == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(888) -- Starting dialogue

    elseif
        tuningOut == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('TuningOut_Progress') == 8
    then
        player:startEvent(897) -- Finishing dialogue

    elseif tuningIn == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(885, 0, 1696, 1697, 1698) -- Reminder to bring Magicked Steel Ingot, Spruce Lumber, Extra-fine File
    elseif tuningOut == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(889) -- Reminder to go help Ildy in Kazham
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- Tuning In
    if csid == 884 then
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.TUNING_IN)

    elseif
        csid == 886 and
        npcUtil.completeQuest(player, xi.questLog.WINDURST, xi.quest.id.windurst.TUNING_IN, {
            gil = 4000,
            title = xi.title.FINE_TUNER,
        })
    then
        player:tradeComplete()

    -- Tuning Out
    elseif csid == 888 then
        player:setCharVar('TuningOut_Progress', 1)
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.TUNING_OUT)

    elseif
        csid == 897 and
        npcUtil.completeQuest(player, xi.questLog.WINDURST, xi.quest.id.windurst.TUNING_OUT, {
            item = xi.item.CACHE_NEZ, -- Cache-Nez
            title = xi.title.FRIEND_OF_THE_HELMED,
            fame = 40,
            fameArea = xi.fameArea.WINDURST,
        })
    then
        player:setCharVar('TuningOut_Progress', 0) -- zero when quest is done
    end
end

return entity
