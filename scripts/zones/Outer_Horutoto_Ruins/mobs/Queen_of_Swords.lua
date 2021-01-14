-----------------------------------
-- Area: Outer Horutoto Ruins
--   NM: Queen of Swords
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    if player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and player:getCharVar("MissionStatus") == 4 and GetMobByID(mob:getID() + 1):isDead() then
        player:setCharVar("MissionStatus", 5)
    end
end

return entity
