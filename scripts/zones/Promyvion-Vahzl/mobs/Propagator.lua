-----------------------------------
-- Area: Promyvion - Vahzl
--   NM: Propagator
-----------------------------------
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("maxBabies", 2)
end

entity.onMobDeath = function(mob, player, isKiller)
    local momma = mob:getID()
    for i = momma + 1, momma + mob:getLocalVar("maxBabies") do
        local baby = GetMobByID(i)
        if baby:isSpawned() then
            baby:setHP(0)
        end
    end
    if player:getCurrentMission(COP) == xi.mission.id.cop.DESIRES_OF_EMPTINESS and player:getCharVar("PromathiaStatus") == 1 then
        player:setCharVar("PromathiaStatus", 2)
    end
end

return entity
