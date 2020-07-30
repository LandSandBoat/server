-----------------------------------
-- Area: Escha Ru'Aun
--  Mob: Eschan Gargouille
-----------------------------------

function onMobSpawn(mob)
    mob:hideName(true)
    mob:untargetable(true)
    mob:AnimationSub(6)
end

function onMobEngaged(mob, target)
    mob:hideName(false)
    mob:untargetable(false)
    mob:AnimationSub(0)
end

function onMobDeath(mob, player, isKiller)
end
