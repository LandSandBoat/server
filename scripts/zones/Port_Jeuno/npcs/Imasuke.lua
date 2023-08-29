-----------------------------------
-- Area: Port Jeuno
--  NPC: Imasuke
-- !pos -165 11 94 246
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local circleOfTime   = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_CIRCLE_OF_TIME)
    local circleProgress = player:getCharVar('circleTime')

    -- CIRCLE OF TIME
    if circleOfTime == QUEST_ACCEPTED then
        if circleProgress == 1 then
            player:startEvent(30)
        elseif circleProgress == 2 then
            player:startEvent(29)
        elseif circleProgress == 3 then
            player:startEvent(32)
        elseif circleProgress == 4 then
            player:startEvent(33)
        elseif circleProgress == 5 then
            player:startEvent(31)
        end
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    -- CIRCLE OF TIME
    if csid == 29 and option == 1 then
        player:setCharVar('circleTime', 3)
    elseif csid == 30 and option == 1 then
        player:setCharVar('circleTime', 3)
    elseif csid == 30 and option == 0 then
        player:setCharVar('circleTime', 2)
    elseif csid == 33 then
        player:setCharVar('circleTime', 5)
    end
end

return entity
