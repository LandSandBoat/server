-----------------------------------
-- Area: Port San d'Oria
--  NPC: Ceraulian
-- Involved in Quests: The Holy Crest, Knight Stalker
-- !pos 0 -8 -122 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stalkerStatus   = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.KNIGHT_STALKER)
    local stalkerProgress = player:getCharVar('KnightStalker_Progress')

    if
        player:getMainLvl() >= xi.settings.main.ADVANCED_JOB_LEVEL and
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST) == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(24)

    elseif
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.CHASING_QUOTAS) == xi.questStatus.QUEST_COMPLETED and
        stalkerStatus == xi.questStatus.QUEST_AVAILABLE
    then
        player:startEvent(16) -- Fluff text until DRG AF3

    -- Knight Stalker (DRG AF3)
    elseif stalkerStatus == xi.questStatus.QUEST_ACCEPTED and stalkerProgress == 0 then
        player:startEvent(19) -- Fetch the last Dragoon's helmet
    elseif stalkerProgress == 1 then
        if not player:hasKeyItem(xi.ki.CHALLENGE_TO_THE_ROYAL_KNIGHTS) then
            player:startEvent(23) -- Reminder to get helmet
        else
            player:startEvent(20) -- Response if you try to turn in the challenge to Ceraulian
        end
    elseif player:getCharVar('KnightStalker_Option1') == 1 then
        player:startEvent(22)
    elseif stalkerStatus == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(21)

    else
        player:startEvent(587)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 24 then
        player:setCharVar('TheHolyCrest_Event', 1)

    -- Knight Stalker (DRG AF3)
    elseif csid == 19 then
        player:setCharVar('KnightStalker_Progress', 1)
    elseif csid == 22 then
        player:setCharVar('KnightStalker_Option1', 0)
    end
end

return entity
