-----------------------------------
-- Area: Kazham
--  NPC: Magriffon
-- Involved in Quest: Gullible's Travels, Even More Gullible's Travels,
-- Location: (I-7)
-----------------------------------
local ID = zones[xi.zone.KAZHAM]
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = 60.600, y = -12.000, z = -33.913, wait = 3000 },
    { z = -38.151, wait = 3000 },
}

entity.onSpawn = function(npc)
    -- Ensure that the correct Magriffon is given pathing information.
    if npc:getID() == ID.npc.MAGRIFFON then
        npc:initNpcAi()
        npc:setPos(xi.path.first(pathNodes))
        npc:pathThrough(pathNodes, xi.path.flag.PATROL)
    end
end

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.GULLIBLES_TRAVELS) == xi.questStatus.QUEST_ACCEPTED then
        if trade:getGil() >= player:getCharVar('MAGRIFFON_GIL_REQUEST') then
            player:startEvent(146)
        end
    elseif
        player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.EVEN_MORE_GULLIBLES_TRAVELS) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('EVEN_MORE_GULLIBLES_PROGRESS') == 0
    then
        if trade:getGil() >= 35000 then
            player:startEvent(150, 0, 256)
        end
    end
end

entity.onTrigger = function(player, npc)
    local gulliblesTravelsStatus = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.GULLIBLES_TRAVELS)
    local evenmoreTravelsStatus = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.EVEN_MORE_GULLIBLES_TRAVELS)

    if gulliblesTravelsStatus == xi.questStatus.QUEST_ACCEPTED then
        local magriffonGilRequest = player:getCharVar('MAGRIFFON_GIL_REQUEST')
        player:startEvent(145, 0, magriffonGilRequest)
    elseif
        gulliblesTravelsStatus == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.WINDURST) >= 6
    then
        local gil = math.random(10, 30) * 1000
        player:setCharVar('MAGRIFFON_GIL_REQUEST', gil)
        player:startEvent(144, 0, gil)
    elseif
        evenmoreTravelsStatus == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('EVEN_MORE_GULLIBLES_PROGRESS') == 0
    then
        player:startEvent(149, 0, 256, 0, 0, 0, 35000)
    elseif
        evenmoreTravelsStatus == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('EVEN_MORE_GULLIBLES_PROGRESS') == 1
    then
        player:startEvent(151)
    elseif
        evenmoreTravelsStatus == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('EVEN_MORE_GULLIBLES_PROGRESS') == 2
    then
        player:startEvent(152, 0, 1144, 256)
    elseif gulliblesTravelsStatus == xi.questStatus.QUEST_COMPLETED then
        if
            evenmoreTravelsStatus == xi.questStatus.QUEST_AVAILABLE and
            player:getFameLevel(xi.fameArea.WINDURST) >= 7 and
            not player:needToZone()
        then
            player:startEvent(148, 0, 256, 0, 0, 35000)
        else
            player:startEvent(147)
        end

    else
        player:startEvent(143)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 144 and option == 1 then                     -- Gullible's Travels: First CS
        player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.GULLIBLES_TRAVELS)
    elseif csid == 146 then                                  -- Gullible's Travels: Final CS
        player:confirmTrade()
        player:delGil(player:getCharVar('MAGRIFFON_GIL_REQUEST'))
        player:setCharVar('MAGRIFFON_GIL_REQUEST', 0)
        player:addFame(xi.fameArea.WINDURST, 30)
        player:setTitle(xi.title.GULLIBLES_TRAVELS)
        player:completeQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.GULLIBLES_TRAVELS)
        player:needToZone(true)
    elseif csid == 148 and option == 1 then                  -- Even More Guillible's Travels First CS
        player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.EVEN_MORE_GULLIBLES_TRAVELS)
    elseif csid == 150 then                                  -- Even More Guillible's Travels Second CS
        player:confirmTrade()
        player:delGil(35000)
        player:setCharVar('EVEN_MORE_GULLIBLES_PROGRESS', 1)
        player:setTitle(xi.title.EVEN_MORE_GULLIBLES_TRAVELS)
        npcUtil.giveKeyItem(player, xi.ki.TREASURE_MAP)
    elseif csid == 152 then
        player:setCharVar('EVEN_MORE_GULLIBLES_PROGRESS', 0)
        player:addFame(xi.fameArea.WINDURST, 30)
        player:completeQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.EVEN_MORE_GULLIBLES_TRAVELS)
    end
end

return entity
