-----------------------------------
-- Area: Kazham
--  NPC: Rauteinot
-- Starts and Finishes Quest: Missionary Man
-- !pos -42 -10 -89 250
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('MissionaryManVar') == 1 and
        trade:hasItemQty(xi.item.SLAB_OF_ELSHIMO_MARBLE, 1) and
        trade:getItemCount() == 1
    then
        player:startEvent(139) -- Trading elshimo marble
    end
end

entity.onTrigger = function(player, npc)
    local missionaryMan = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.MISSIONARY_MAN)
    local missionaryManVar = player:getCharVar('MissionaryManVar')

    if
        missionaryMan == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.WINDURST) >= 3
    then
        player:startEvent(137, 0, xi.item.SLAB_OF_ELSHIMO_MARBLE) -- Start quest "Missionary Man"
    elseif missionaryMan == xi.questStatus.QUEST_ACCEPTED and missionaryManVar == 1 then
        player:startEvent(138, 0, xi.item.SLAB_OF_ELSHIMO_MARBLE) -- During quest (before trade marble) "Missionary Man"
    elseif
        missionaryMan == xi.questStatus.QUEST_ACCEPTED and
        (missionaryManVar == 2 or missionaryManVar == 3)
    then
        player:startEvent(140) -- During quest (after trade marble) "Missionary Man"
    elseif missionaryMan == xi.questStatus.QUEST_ACCEPTED and missionaryManVar == 4 then
        player:startEvent(141) -- Finish quest "Missionary Man"
    elseif missionaryMan == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(142) -- New standard dialog
    else
        player:startEvent(136) -- Standard dialog
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 137 and option == 1 then
        player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.MISSIONARY_MAN)
        player:setCharVar('MissionaryManVar', 1)
    elseif csid == 139 then
        player:setCharVar('MissionaryManVar', 2)
        npcUtil.giveKeyItem(player, xi.ki.RAUTEINOTS_PARCEL)
        player:tradeComplete()
    elseif csid == 141 then
        if npcUtil.giveItem(player, xi.item.SCROLL_OF_TELEPORT_YHOAT) then
            player:setCharVar('MissionaryManVar', 0)
            player:delKeyItem(xi.ki.SUBLIME_STATUE_OF_THE_GODDESS)
            player:addFame(xi.fameArea.WINDURST, 30)
            player:completeQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.MISSIONARY_MAN)
        end
    end
end

return entity
