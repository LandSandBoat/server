-----------------------------------
-- Area: Port Windurst
--  NPC: Pyo Nzon
-----------------------------------
require("scripts/globals/quests")
require("scripts/settings/main")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

end

entity.onTrigger = function(player, npc)

    local TruthJusticeOnionWay = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TRUTH_JUSTICE_AND_THE_ONION_WAY)
    local KnowOnesOnions       = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.KNOW_ONE_S_ONIONS)
    local InspectorsGadget     = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.INSPECTOR_S_GADGET)
    local OnionRings           = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ONION_RINGS)
    local CryingOverOnions     = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS)
    local ThePromise = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PROMISE)

    if (ThePromise == QUEST_COMPLETED) then
        local Message = math.random(0, 1)

        if (Message == 1) then
            player:startEvent(539)
        else
            player:startEvent(527)
        end
    elseif (ThePromise == QUEST_ACCEPTED) then
        player:startEvent(517)
    elseif (CryingOverOnions == QUEST_COMPLETED) then
        player:startEvent(510)
    elseif (CryingOverOnions == QUEST_ACCEPTED) then
        player:startEvent(502)
    elseif (OnionRings == QUEST_COMPLETED) then
        player:startEvent(443)
    elseif (OnionRings == QUEST_ACCEPTED ) then
        player:startEvent(437)
    elseif (InspectorsGadget == QUEST_COMPLETED) then
        player:startEvent(426)
    elseif (InspectorsGadget == QUEST_ACCEPTED) then
        player:startEvent(418)
    elseif (KnowOnesOnions == QUEST_COMPLETED) then
        player:startEvent(409)
    elseif (KnowOnesOnions == QUEST_ACCEPTED) then
        local KnowOnesOnionsVar  = player:getCharVar("KnowOnesOnions")

        if (KnowOnesOnionsVar == 2) then
            player:startEvent(408)
        else
            player:startEvent(396)
        end
    elseif (TruthJusticeOnionWay == QUEST_COMPLETED) then
        player:startEvent(382)
    elseif (TruthJusticeOnionWay == QUEST_ACCEPTED) then
        player:startEvent(375)
    else
        player:startEvent(366)
    end

end

entity.onEventUpdate = function(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)

end

entity.onEventFinish = function(player, csid, option)

end

return entity
