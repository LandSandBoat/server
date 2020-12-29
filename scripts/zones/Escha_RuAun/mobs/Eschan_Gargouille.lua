-----------------------------------
-- Area: Escha Ru'Aun
--  Mob: Eschan Gargouille
-----------------------------------

function onMobSpawn(mob)
    mob:hideName(true)
    mob:untargetable(true)
    mob:setAnimationSub(6)
end

function onMobEngaged(mob, target)
    mob:hideName(false)
    mob:untargetable(false)
    mob:setAnimationSub(0)
end

function onMobDeath(mob, player, isKiller)
end
