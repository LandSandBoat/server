-----------------------------------
-- Area: Attohwa Chasm
--  NPC: Loose sand
-----------------------------------
local ID = require("scripts/zones/Attohwa_Chasm/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local cop = player:getCurrentMission(COP)
    local moamStat = player:getCharVar("MEMORIES_OF_A_MAIDEN_Status")

    if (cop == xi.mission.id.cop.THE_ROAD_FORKS and moamStat==8 and not player:hasKeyItem(xi.ki.MIMEO_JEWEL) and (os.time() - player:getCharVar("LioumereKilled")) < 200) then
        player:setCharVar("LioumereKilled", 0)
        player:addKeyItem(xi.ki.MIMEO_JEWEL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MIMEO_JEWEL)
    elseif (cop == xi.mission.id.cop.THE_ROAD_FORKS and (moamStat==7 or moamStat==8) and not player:hasKeyItem(xi.ki.MIMEO_JEWEL)) then
        SpawnMob(ID.mob.LIOUMERE):updateClaim(player)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
        player:setCharVar("LioumereKilled", 0)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
