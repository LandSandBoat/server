-----------------------------------
-- Area: Port Windurst
--  NPC: Tokaka
-- Starts & Finishes Repeatable Quest: Something Fishy
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local TokakaSpokenTo = player:getCharVar("TokakaSpokenTo")
    local NeedToZone     = player:needToZone()

    if (TokakaSpokenTo == 1 and NeedToZone == false) then
        local count = trade:getItemCount()
        local BastoreSardine = trade:hasItemQty(4360, 1)

        if (BastoreSardine == true and count == 1) then
            player:startEvent(210, GIL_RATE*70, 4360)
        end
    end
end

entity.onTrigger = function(player, npc)
    local SomethingFishy = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SOMETHING_FISHY)
    if (player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLAST_FROM_THE_PAST) == QUEST_ACCEPTED and player:getCharVar("BlastFromThePast_Prog") == 0) then
        player:startEvent(318)
        player:setCharVar("BlastFromThePast_Prog", 1)
    elseif (SomethingFishy >= QUEST_ACCEPTED) then
        if (player:needToZone()) then
            player:startEvent(211)
        else
            player:startEvent(209, 0, 4360)
        end
    elseif (SomethingFishy == QUEST_AVAILABLE) then
        player:startEvent(208, 0, 4360)
    elseif (player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLAST_FROM_THE_PAST) == QUEST_ACCEPTED and player:getCharVar("BlastFromThePast_Prog") == 0) then
        player:startEvent(318)
        player:setCharVar("BlastFromThePast_Prog", 1)
    else
        player:startEvent(207)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 208) then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SOMETHING_FISHY)
        player:setCharVar("TokakaSpokenTo", 1)
    elseif (csid == 210) then
        local SomethingFishy = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SOMETHING_FISHY)

        if (SomethingFishy == QUEST_ACCEPTED) then
            player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SOMETHING_FISHY)
            player:addFame(WINDURST, 60)
        else
            player:addFame(WINDURST, 10)
        end

        player:tradeComplete()
        player:addGil(GIL_RATE*70)
        player:setCharVar("TokakaSpokenTo", 0)
        player:needToZone(true)
    elseif (csid == 209) then
        player:setCharVar("TokakaSpokenTo", 1)
    end
end
return entity
