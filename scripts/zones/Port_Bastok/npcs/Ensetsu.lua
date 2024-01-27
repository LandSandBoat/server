-----------------------------------
-- Area: Port Bastok
--  NPC: Ensetsu
-- Involved in Quest: 20 in Pirate Years, I'll Take the Big Box
-- !pos 33 -6 67 236
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local ayameAndKaede = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.AYAME_AND_KAEDE)

    if
        ayameAndKaede == QUEST_COMPLETED and
        player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TWENTY_IN_PIRATE_YEARS) == QUEST_AVAILABLE
    then
        player:startEvent(247)
    elseif player:getCharVar('twentyInPirateYearsCS') == 2 then
        player:startEvent(262)
    elseif player:getCharVar('twentyInPirateYearsCS') == 4 then
        player:startEvent(263)
    elseif
        player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX) == QUEST_ACCEPTED and
        player:getCharVar('illTakeTheBigBoxCS') == 0
    then
        player:startEvent(264)
    elseif player:getCharVar('illTakeTheBigBoxCS') == 1 then
        player:startEvent(265)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 262 then
        player:setCharVar('twentyInPirateYearsCS', 3)
    elseif csid == 264 then
        player:setCharVar('illTakeTheBigBoxCS', 1)
    end
end

return entity
