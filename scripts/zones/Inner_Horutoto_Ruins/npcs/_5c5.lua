-----------------------------------
-- Area: Inner Horutoto Ruins
--  NPC: Gate: Magical Gizmo
-- Involved In Mission: The Horutoto Ruins Experiment
-- !pos 419 0 -27 192
-----------------------------------
local ID = require("scripts/zones/Inner_Horutoto_Ruins/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_HORUTOTO_RUINS_EXPERIMENT and
        player:getCharVar("MissionStatus") == 1
    then
        player:startEvent(42)
    else
        player:showText(npc, ID.text.DOOR_FIRMLY_CLOSED)
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 42 then
        player:setCharVar("MissionStatus", 2)

        -- Generate a random value to use for the next part of the mission
        -- where you have to examine 6 Magical Gizmo's, each of them having
        -- a number from 1 to 6 (Remember, setting 0 deletes the var)
        local random_value = math.random(1, 6)
        player:setCharVar("MissionStatus_rv", random_value) -- 'rv' = random value
        player:setCharVar("MissionStatus_op1", 1)
        player:setCharVar("MissionStatus_op2", 1)
        player:setCharVar("MissionStatus_op3", 1)
        player:setCharVar("MissionStatus_op4", 1)
        player:setCharVar("MissionStatus_op5", 1)
        player:setCharVar("MissionStatus_op6", 1)
    end
end

return entity
