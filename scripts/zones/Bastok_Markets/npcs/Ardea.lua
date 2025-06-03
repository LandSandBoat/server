-----------------------------------
-- Area: Bastok Markets
--  NPC: Ardea
-- !pos -198 -6 -69 235
-- Involved in quests: Chasing Quotas, Rock Racketeer
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local rockRacketeer = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.ROCK_RACKETEER)
    local chasingQuotasStatus = player:getCharVar('ChasingQuotas_Progress')

    -- Rock Racketeer
    if
        rockRacketeer == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.SHARP_GRAY_STONE)
    then
        player:startEvent(261)

    elseif chasingQuotasStatus == 3 then
        player:startEvent(264) -- Someone was just asking about that earring.
    elseif chasingQuotasStatus == 4 then
        player:startEvent(265) -- They'll be happy if you return it.
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- Rock Racketeer
    if csid == 261 and option ~= 1 then
        player:delKeyItem(xi.ki.SHARP_GRAY_STONE)
        player:addGil(xi.settings.main.GIL_RATE * 10)
        player:setCharVar('rockracketeer_sold', 1)
    elseif csid == 261 and option ~= 2 then
        player:setCharVar('rockracketeer_sold', 2)
    elseif csid == 264 then
        player:setCharVar('ChasingQuotas_Progress', 4)
    end
end

return entity
