-----------------------------------
-- Area: Kazham (250)
--  NPC: Jakoh Wahcondalo
-- !pos 101 -16 -115 250
-- Starts Quests: A Question of Taste, Cloak and Dagger, Everyone's Grudging
-- Inovlved in Missions: ZM3 Kazham's Chieftainess, WM7-2 Awakening of the Gods
-- Involved in Quests: Tuning Out
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/Kazham/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local tuningOutProgress = player:getCharVar("TuningOut_Progress")

    if (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getMissionStatus(player:getNation()) == 2) then
        player:startEvent(265)
    elseif tuningOutProgress == 1 then
        player:startEvent(293) -- Ildy meets Jakoh to inquire about Shikaree Y
    elseif tuningOutProgress == 2 then
        player:startEvent(294) -- Mentions expedition that was talked about in CS 293
    else
        player:startEvent(113)
    end
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 265) then
        player:setMissionStatus(player:getNation(), 3)
    elseif csid == 293 then
        player:setCharVar("TuningOut_Progress", 2)
    end
end

return entity
