-----------------------------------
-- Area: Spire of Dem
--  Mob: Progenerator
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("maxBabies", 4)
end

entity.onMobEngaged = function(mob, target)
end

entity.onMobWeaponSkill = function(target, mob, skill)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, isKiller)
    local momma = mob:getID()
    for i = momma + 1, momma + mob:getLocalVar("maxBabies") do
        local baby = GetMobByID(i)
        if baby:isSpawned() then
            baby:setHP(0)
        end
    end
end

return entity
