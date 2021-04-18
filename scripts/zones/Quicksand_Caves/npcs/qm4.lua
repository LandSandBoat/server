-----------------------------------
-- Area: Quicksand Caves
--  NPC: ??? (qm4)
-- Involved in Mission: Bastok 8.1 "The Chains That Bind Us"
-- !pos
-----------------------------------
require("scripts/globals/missions")
local ID = require("scripts/zones/Quicksand_Caves/IDs")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local missionStatus = player:getMissionStatus(player:getNation())
    if (player:getCurrentMission(BASTOK) == xi.mission.id.bastok.THE_CHAINS_THAT_BIND_US) and (missionStatus == 2) then
        player:startEvent(10)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onTrade = function(player, npc, trade)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 10) then
        player:setMissionStatus(player:getNation(), 3)
    end
end

return entity
