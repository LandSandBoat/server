-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Elysia
-- Starts Quest: Unforgiven
-- !pos -50.410 -22.204 -41.640 26
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local unforgiven = player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.UNFORGIVEN)

    if unforgiven == QUEST_AVAILABLE then
        player:startEvent(200) -- start quest
    elseif unforgiven == QUEST_ACCEPTED and player:getCharVar("UnforgivenVar") == 1 then
        player:startEvent(203) -- player hasn't talked to Pradiulot (2nd stage of Quest)
    elseif
        unforgiven == QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.ALABASTER_HAIRPIN)
    then
        player:startEvent(201) -- player doesn't have keyitem
    elseif unforgiven == QUEST_ACCEPTED then
        player:startEvent(202) -- player has keyitem (1st stage of Quest)
    else
        player:startEvent(190)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 200 then
        player:addQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.UNFORGIVEN)
    elseif csid == 202 then
        player:setCharVar("UnforgivenVar", 1)
    end
end

return entity
