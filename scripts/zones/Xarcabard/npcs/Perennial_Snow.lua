-----------------------------------
-- Area: Xarcabard
--  NPC: Perennial Snow
-- Involved in Quests: The Circle of Time
-- !pos 339 0 -379 112
-----------------------------------
local ID = zones[xi.zone.XARCABARD]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local circleOfTime = player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.THE_CIRCLE_OF_TIME)

    -- CIRCLE OF TIME (Bard AF3)
    if
        circleOfTime == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('circleTime') == 3
    then
        if player:getCharVar('star_ringburied') == 0 then
            player:startEvent(3)
        elseif os.time() > player:getCharVar('star_ringburied') then
            player:startEvent(2)
        else
            player:messageSpecial(ID.text.PERENNIAL_SNOW_WAIT, 225)
        end

    -- DEFAULT DIALOG
    else
        player:messageSpecial(ID.text.PERENNIAL_SNOW_DEFAULT)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 3 then
        player:setCharVar('star_ringburied', os.time() + 60) -- wait 1 minute
    elseif csid == 2 then
        player:setCharVar('star_ringburied', 0)
        player:setCharVar('circleTime', 4)
    end
end

return entity
