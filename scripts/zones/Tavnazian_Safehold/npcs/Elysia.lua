-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Elysia
-- Starts Quest: Unforgiven
-- !pos -50.410 -22.204 -41.640 26
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local unforgiven = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNFORGIVEN)

    if unforgiven == QUEST_AVAILABLE then
        player:startEvent(200) -- start quest
    elseif unforgiven == QUEST_ACCEPTED and player:getCharVar("UnforgivenVar") == 1 then
        player:startEvent(203) -- player hasn't talked to Pradiulot (2nd stage of Quest)
    elseif unforgiven == QUEST_ACCEPTED and not player:hasKeyItem(tpz.ki.ALABASTER_HAIRPIN) then
        player:startEvent(201) -- player doesn't have keyitem
    elseif unforgiven == QUEST_ACCEPTED then
        player:startEvent(202) -- player has keyitem (1st stage of Quest)
    else
        player:startEvent(190)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 200 then
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.UNFORGIVEN)
    elseif csid == 202 then
        player:setCharVar("UnforgivenVar", 1)
    end
end
