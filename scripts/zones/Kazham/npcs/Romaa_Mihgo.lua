-----------------------------------
-- Area: Kazham
--  NPC: Romaa Mihgo
-- Type: Standard NPC
-- !pos 29.000 -13.023 -176.500 250
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local tuningOutProgress = player:getCharVar("TuningOut_Progress")

    if (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getMissionStatus(player:getNation()) == 2) then
        player:startEvent(266)
    elseif (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.AWAKENING_OF_THE_GODS and player:getMissionStatus(player:getNation()) == 3) then
        player:startEvent(267)

    elseif tuningOutProgress == 2 then
        player:startEvent(295) -- Ildy meets Romaa. Romaa tells player to go to waterfall
    elseif tuningOutProgress == 3 or tuningOutProgress == 4 then
        player:startEvent(296) -- Repeats hint to go to waterfall
    elseif tuningOutProgress == 5 then
        player:startEvent(297, 0, 1695, 4297, 4506) -- After fight with the Nasus. Mentions guard needs Habaneros, Black Curry, Mutton Tortilla
    elseif tuningOutProgress == 6 then
        player:startEvent(298, 0, 1695, 4297, 4506) -- Repeats guard need for Habaneros, Black Curry, Mutton Tortilla

    else
        player:startEvent(263)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 266) then
        player:setMissionStatus(player:getNation(), 3)

    elseif csid == 295 then
        player:setCharVar("TuningOut_Progress", 3)
    elseif csid == 297 then
        player:setCharVar("TuningOut_Progress", 6)
    end

end

return entity
