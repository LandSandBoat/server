-----------------------------------
-- Area: Windurst Woods
--  NPC: Matata
-- Involved in quest: In a Stew
-- !pos 131 -5 -109 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local inAStew      = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.IN_A_STEW)
    local iasVar       = player:getCharVar('IASvar')
    local chocobilious = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CHOCOBILIOUS)

    -- IN A STEW
    if inAStew == xi.questStatus.QUEST_ACCEPTED and iasVar == 1 then
        player:startEvent(233, 0, 0, 4545) -- In a Stew in progress
    elseif inAStew == xi.questStatus.QUEST_ACCEPTED and iasVar == 2 then
        player:startEvent(237) -- In a Stew reminder
    elseif inAStew == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(241) -- new dialog after In a Stew

    -- CHOCOBILIOUS
    elseif chocobilious == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(226) -- Chocobilious complete

    -- STANDARD DIALOG
    else
        player:startEvent(223)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- IN A STEW
    if csid == 233 then
        player:setCharVar('IASvar', 2)
    end
end

return entity
