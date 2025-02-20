-----------------------------------
-- Area: Kazham (250)
--  NPC: Jakoh Wahcondalo
-- !pos 101 -16 -115 250
-- Starts Quests: A Question of Taste, Cloak and Dagger, Everyone's Grudging
-- Inovlved in Missions: ZM3 Kazham's Chieftainess, WM7-2 Awakening of the Gods
-- Involved in Quests: Tuning Out
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local tuningOutProgress = player:getCharVar('TuningOut_Progress')

    if tuningOutProgress == 1 then
        player:startEvent(293) -- Ildy meets Jakoh to inquire about Shikaree Y
    elseif tuningOutProgress == 2 then
        player:startEvent(294) -- Mentions expedition that was talked about in CS 293
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 293 then
        player:setCharVar('TuningOut_Progress', 2)
    end
end

return entity
