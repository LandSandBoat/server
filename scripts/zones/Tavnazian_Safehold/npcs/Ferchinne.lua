-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Ferchinne
-- Note: Involved in quest: "Fly High"
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    local flyHigh = player:getQuestStatus(tpz.quest.log_id.OTHER_AREAS, tpz.quest.id.otherAreas.FLY_HIGH)

    if flyHigh == QUEST_ACCEPTED and npcUtil.tradeHas(trade, {{1690, 2}}) then -- 2x Hippogryph Tailfeather
        player:startEvent(243)
    elseif flyHigh == QUEST_COMPLETED and npcUtil.tradeHas(trade, {{1690, 2}}) then -- 2x Hippogryph Tailfeather
        player:startEvent(245)
    end
end

function onTrigger(player, npc)
    if player:getCurrentMission(COP) == tpz.mission.id.cop.THE_SAVAGE or player:hasCompletedMission(COP, tpz.mission.id.cop.THE_SAVAGE) then
        local flyHigh = player:getQuestStatus(tpz.quest.log_id.OTHER_AREAS, tpz.quest.id.otherAreas.FLY_HIGH)

        if flyHigh == QUEST_AVAILABLE then
            player:startEvent(241)
        elseif flyHigh == QUEST_ACCEPTED then
            player:startEvent(242)
        elseif flyHigh == QUEST_COMPLETED then
            player:startEvent(244)
        end
    else
        player:startEvent(240)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 241 then
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.FLY_HIGH)
    elseif csid == 243 and npcUtil.completeQuest(player, OTHER_AREAS_LOG, tpz.quest.id.otherAreas.FLY_HIGH, {item = 5265, fame_area = TAVNAZIA}) then -- Mistmelt
        player:confirmTrade()
    elseif csid == 245 and npcUtil.giveItem(player, 5265) then -- Mistmelt
        player:confirmTrade()
    end
end
