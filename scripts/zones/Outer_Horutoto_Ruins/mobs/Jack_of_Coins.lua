-----------------------------------
-- Area: Outer Horutoto Ruins
--   NM: Jack of Coins
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("popTime", os.time())
end

entity.onMobRoam = function(mob)
    if os.time() - mob:getLocalVar("popTime") > 180 then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    if player:getCurrentMission(WINDURST) == xi.mission.id.windurst.FULL_MOON_FOUNTAIN and player:getMissionStatus(player:getNation()) == 1 then
        player:setMissionStatus(player:getNation(), 2)
    end
end

return entity
