-----------------------------------
-- Area: Port Windurst
--  NPC: Gomada-Vulmada
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

end

entity.onTrigger = function(player, npc)

TruthJusticeOnionWay = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TRUTH_JUSTICE_AND_THE_ONION_WAY)
KnowOnesOnions       = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.KNOW_ONE_S_ONIONS)
InspectorsGadget     = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.INSPECTOR_S_GADGET)
OnionRings           = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ONION_RINGS)
CryingOverOnions     = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CRYING_OVER_ONIONS)
ThePromise = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PROMISE)

    if (ThePromise == QUEST_COMPLETED) then
        Message = math.random(0, 1)

        if (Message == 1) then
            player:startEvent(528)
        else
            player:startEvent(540)
        end
    elseif (ThePromise == QUEST_ACCEPTED) then
        player:startEvent(518)
    elseif (CryingOverOnions == QUEST_COMPLETED) then
        player:startEvent(507)
    elseif (CryingOverOnions == QUEST_ACCEPTED) then
        player:startEvent(500)
    elseif (OnionRings == QUEST_COMPLETED) then
        player:startEvent(442)
    elseif (OnionRings == QUEST_ACCEPTED ) then
        player:startEvent(435)
    elseif (InspectorsGadget == QUEST_COMPLETED) then
        player:startEvent(425)
    elseif (InspectorsGadget == QUEST_ACCEPTED) then
        player:startEvent(417)
    elseif (KnowOnesOnions == QUEST_COMPLETED) then
        player:startEvent(405)
    elseif (KnowOnesOnions == QUEST_ACCEPTED) then
        KnowOnesOnionsVar  = player:getCharVar("KnowOnesOnions")

        if (KnowOnesOnionsVar == 2) then
            player:startEvent(404)
        else
            player:startEvent(394)
        end
    elseif (TruthJusticeOnionWay == QUEST_COMPLETED) then
        player:startEvent(381)
    elseif (TruthJusticeOnionWay == QUEST_ACCEPTED) then
        player:startEvent(373)
    else
        player:startEvent(363)
    end

end

entity.onEventUpdate = function(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)

end

entity.onEventFinish = function(player, csid, option)

end

return entity
