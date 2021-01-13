-----------------------------------
-- Area: Outer Horutoto Ruins
--   NM: Jack of Cups
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/missions")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    mob:setLocalVar("popTime", os.time())
end

entity.onMobRoam = function(mob)
    if os.time() - mob:getLocalVar("popTime") > 180 then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    if player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.FULL_MOON_FOUNTAIN and player:getCharVar("MissionStatus") == 1 then
        player:setCharVar("MissionStatus", 2)
    end
end

return entity
