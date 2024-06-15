-----------------------------------
-- Zone: RuLude_Gardens (243)
-----------------------------------
local ID = zones[xi.zone.RULUDE_GARDENS]
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1, -16, 2, 32, 16, 4, 86) -- Palace entrance. Ends at back exit. Needs retail confirmaton for the back entrance.
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    -- MOG HOUSE EXIT
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        local position = math.random(1, 5) + 45
        player:setPos(position, 10, -73, 192)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local triggerAreaID = triggerArea:GetTriggerAreaID()

    if triggerAreaID == 1 then
        if
            player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.DAWN and
            xi.mission.getVar(player, xi.mission.log_id.COP, xi.mission.id.cop.DAWN, 'Status') == 8
        then
            if
                player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) and
                player:getCurrentMission(xi.mission.log_id.ZILART) == xi.mission.id.zilart.AWAKENING and
                player:getMissionStatus(xi.mission.log_id.ZILART) == 3 and
                player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED) == xi.questStatus.QUEST_AVAILABLE and
                player:getCharVar('StormsOfFateWait') <= os.time()
            then
                player:startEvent(161)
            elseif
                player:hasKeyItem(xi.ki.PROMYVION_HOLLA_SLIVER) and
                player:hasKeyItem(xi.ki.PROMYVION_MEA_SLIVER) and
                player:hasKeyItem(xi.ki.PROMYVION_DEM_SLIVER)
            then
                player:startEvent(162)
            elseif
                player:hasCompletedQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED) and
                player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) == xi.questStatus.QUEST_AVAILABLE and
                player:getLocalVar('ANZONE') == 0 and
                player:getCharVar('ApocNighWait') <= os.time()
            then
                player:startEvent(123)
            end
        end
    end
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 161 then
        npcUtil.giveKeyItem(player, xi.ki.NOTE_WRITTEN_BY_ESHANTARL)
        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED)
        player:setCharVar('StormsOfFateWait', 0)
    elseif csid == 162 then
        player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED)
        player:delKeyItem(xi.ki.PROMYVION_HOLLA_SLIVER)
        player:delKeyItem(xi.ki.PROMYVION_DEM_SLIVER)
        player:delKeyItem(xi.ki.PROMYVION_MEA_SLIVER)
        player:messageSpecial(ID.text.YOU_HAND_THE_THREE_SLIVERS)
        player:setLocalVar('ANZONE', 1)
        player:setCharVar('ApocNighWait', getVanaMidnight())
    elseif csid == 123 then
        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH)
        player:setCharVar('ApocalypseNigh', 1)
        player:setCharVar('ApocNighWait', 0)
    end
end

return zoneObject
