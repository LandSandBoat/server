-----------------------------------
-- Area: Inner Horutoto Ruins
--  NPC: _5ct (Magical Gizmo) #5
-- Involved In Mission: The Horutoto Ruins Experiment
-----------------------------------
local ID = require("scripts/zones/Inner_Horutoto_Ruins/IDs")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- The Magical Gizmo Number, this number will be compared to the random
    -- value created by the mission The Horutoto Ruins Experiment, when you
    -- reach the Gizmo Door and have the cutscene
    local magical_gizmo_no = 5 -- of the 6

    -- Check if we are on Windurst Mission 1-1
    if
        player:getCurrentMission(WINDURST) == xi.mission.id.windurst.THE_HORUTOTO_RUINS_EXPERIMENT and
        player:getMissionStatus(player:getNation()) == 2
    then
        -- Check if we found the correct Magical Gizmo or not
        if player:getCharVar("MissionStatus_rv") == magical_gizmo_no then
            player:startEvent(56)
        else
            if player:getCharVar("MissionStatus_op5") == 2 then
                player:messageSpecial(ID.text.EXAMINED_RECEPTACLE) -- We've already examined this
            else
                player:startEvent(57) -- Opened the wrong one
            end
        end
    end

    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- If we just finished the cutscene for Windurst Mission 1-1
    -- The cutscene that we opened the correct Magical Gizmo
    if csid == 56 then
        player:setMissionStatus(player:getNation(), 3)
        player:setCharVar("MissionStatus_rv", 0)
        player:addKeyItem(xi.ki.CRACKED_MANA_ORBS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.CRACKED_MANA_ORBS)
    elseif csid == 57 then
        -- Opened the wrong one
        player:setCharVar("MissionStatus_op5", 2)
        -- Give the message that thsi orb is not broken
        player:messageSpecial(ID.text.NOT_BROKEN_ORB)
    end
end

return entity
