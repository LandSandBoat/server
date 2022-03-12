-----------------------------------
-- Area: Konschtat Highlands
--  NPC: Shattered telepoint
-- !pos 135 19 220 108
-----------------------------------
local ID = require("scripts/zones/Konschtat_Highlands/IDs")
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
    if
        copMission == xi.mission.id.cop.THE_MOTHERCRYSTALS and
        (
            player:hasKeyItem(xi.ki.LIGHT_OF_HOLLA) or
            player:hasKeyItem(xi.ki.LIGHT_OF_MEA)
        )
    then
        if player:getCharVar("cspromy2") == 1 then
            player:startEvent(912)  -- cs you get nearing second promyvion
        else
            player:startEvent(913)
        end
    elseif
        copMission > xi.mission.id.cop.THE_MOTHERCRYSTALS or
        player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LAST_VERSE)
    then
        player:startEvent(913) -- normal cs (third promyvion and each entrance after having that promyvion visited or mission completed)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- CoP Missions
    if csid == 912 then
        player:setCharVar("cspromy2", 0)
        player:setCharVar("cs2ndpromy", 1)
        player:setPos(185.891, 0, -52.331, 128, 18) -- To Promyvion Dem
    elseif csid == 913 and option == 0 then
        player:setPos(-267.194, -40.634, -280.019, 0, 14) -- To Hall of Transference {R}
    end
end

return entity
