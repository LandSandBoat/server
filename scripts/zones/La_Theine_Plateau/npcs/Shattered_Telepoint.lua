-----------------------------------
-- Area: La_Theine Plateau
--  NPC: Shattered Telepoint
-- !pos 334 19 -60 102
-----------------------------------
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local copMission = player:getCurrentMission(COP)

    -- CoP Missions
    if copMission == xi.mission.id.cop.BELOW_THE_ARKS and player:getCharVar("PromathiaStatus") == 1 then
        player:startEvent(202, 0, 0, 1) -- first time in promy -> have you made your preparations cs
    elseif
        copMission == xi.mission.id.cop.THE_MOTHERCRYSTALS and
        (
            player:hasKeyItem(xi.ki.LIGHT_OF_MEA) or
            player:hasKeyItem(xi.ki.LIGHT_OF_DEM)
        )
    then
        if player:getCharVar("cspromy2") == 1 then
            player:startEvent(201) -- cs you get nearing second promyvion
        else
            player:startEvent(202)
        end
    elseif
        copMission > xi.mission.id.cop.THE_MOTHERCRYSTALS or
        player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LAST_VERSE) or
        (
            copMission == xi.mission.id.cop.BELOW_THE_ARKS and
            player:getCharVar("PromathiaStatus") > 1
        )
    then
        player:startEvent(202) -- normal cs (third promyvion and each entrance after having that promyvion visited or mission completed)

    -- Default Message
    else
        player:messageSpecial(ID.text.TELEPOINT_HAS_BEEN_SHATTERED)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- CoP Missions
    if csid == 201 then
        player:setCharVar("cspromy2", 0)
        player:setCharVar("cs2ndpromy", 1)
        player:setPos(92.033, 0, 80.380, 255, 16) -- To Promyvion Holla
    elseif csid == 202 and option == 0 then
        player:setPos(-266.76, -0.635, 280.058, 0, 14) -- To Hall of Transference {R}
    end
end

return entity
