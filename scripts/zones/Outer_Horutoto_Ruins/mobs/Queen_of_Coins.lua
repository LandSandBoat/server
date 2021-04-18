-----------------------------------
-- Area: Outer Horutoto Ruins
--   NM: Queen of Coins
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    if player:getCurrentMission(WINDURST) == xi.mission.id.windurst.THE_JESTER_WHO_D_BE_KING and player:getMissionStatus(player:getNation()) == 4 and GetMobByID(mob:getID() - 1):isDead() then
        player:setMissionStatus(player:getNation(), 5)
    end
end

return entity
