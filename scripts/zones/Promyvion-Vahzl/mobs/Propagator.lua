-----------------------------------
-- Area: Promyvion - Vahzl
--   NM: Propagator
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('maxBabies', 2)
end

entity.onMobDeath = function(mob, player, optParams)
    local momma = mob:getID()

    for i = momma + 1, momma + mob:getLocalVar('maxBabies') do
        local baby = GetMobByID(i)
        if baby:isSpawned() then
            baby:setHP(0)
        end
    end
end

return entity
