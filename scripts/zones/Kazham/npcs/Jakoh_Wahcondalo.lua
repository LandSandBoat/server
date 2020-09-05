-----------------------------------
-- Area: Kazham (250)
-- NPC: Jakoh Wahcondalo
-- !pos 101 -16 -115 250
-- Starts Quests: A Question of Taste, Cloak and Dagger, Everyone's Grudging
-- Inovlved in Missions: ZM3 Kazham's Chieftainess, WM7-2 Awakening of the Gods
-- Involved in Quests: Tuning Out
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/wsquest")
local ID = require("scripts/zones/Kazham/IDs")

local wsQuest = tpz.wsquest.evisceration

function onTrade(player, npc, trade)
    local wsQuestEvent = tpz.wsquest.getTradeEvent(wsQuest, player, trade)

    if (wsQuestEvent ~= nil) then
        player:startEvent(wsQuestEvent)
    end
end

function onTrigger(player, npc)
    local wsQuestEvent = tpz.wsquest.getTriggerEvent(wsQuest, player)
    local tuningOutProgress = player:getCharVar("TuningOut_Progress")

    if (player:getCurrentMission(ZILART) == tpz.mission.id.zilart.KAZAMS_CHIEFTAINESS) then
        player:startEvent(114)
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getCharVar("MissionStatus") == 2) then
        player:startEvent(265)
    elseif tuningOutProgress == 1 then
        player:startEvent(293) -- Ildy meets Jakoh to inquire about Shikaree Y

    elseif (wsQuestEvent ~= nil) then
        player:startEvent(wsQuestEvent)
    elseif (player:getCurrentMission(ZILART) == tpz.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH) then
        player:startEvent(115)

    elseif tuningOutProgress == 2 then
        player:startEvent(294) -- Mentions expedition that was talked about in CS 293
    else
        player:startEvent(113)
    end

end

function onEventFinish(player, csid, option)
    if (csid == 114) then
        player:addKeyItem(tpz.ki.SACRIFICIAL_CHAMBER_KEY)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SACRIFICIAL_CHAMBER_KEY)
        player:completeMission(ZILART, tpz.mission.id.zilart.KAZAMS_CHIEFTAINESS)
        player:addMission(ZILART, tpz.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH)
    elseif (csid == 265) then
        player:setCharVar("MissionStatus", 3)
    elseif csid == 293 then
        player:setCharVar("TuningOut_Progress", 2)
    else
        tpz.wsquest.handleEventFinish(wsQuest, player, csid, option, ID.text.EVISCERATION_LEARNED)
    end

end
