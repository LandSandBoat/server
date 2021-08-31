-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Lioumere
-----------------------------------
mixins = {require("scripts/mixins/families/antlion_ambush")}
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    if (player:getCurrentMission(COP) == xi.mission.id.cop.THE_ROAD_FORKS and player:getCharVar("MEMORIES_OF_A_MAIDEN_Status") >= 7 and not player:hasKeyItem(xi.ki.MIMEO_JEWEL)) then
        player:setCharVar("MEMORIES_OF_A_MAIDEN_Status", 8)
        player:setCharVar("LioumereKilled", os.time())
    end
end

return entity
