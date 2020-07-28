-----------------------------------
-- Area: Spire of Dem
--  Mob: Progenerator
-----------------------------------

function onMobInitialize(mob)
end

function onMobSpawn(mob)
    mob:setLocalVar("maxBabies", 4)
end

function onMobEngaged(mob, target)
end

function onMobWeaponSkill(target, mob, skill)
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller)
    local momma = mob:getID()
    for i = momma + 1, momma + mob:getLocalVar("maxBabies") do
        local baby = GetMobByID(i)
        if baby:isSpawned() then
            baby:setHP(0)
        end
    end
end
