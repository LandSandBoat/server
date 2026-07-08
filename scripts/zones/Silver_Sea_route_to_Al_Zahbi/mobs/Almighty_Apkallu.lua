-----------------------------------
-- Area: Silver Sea route to Al Zahbi
--   NM: Almighty Apkallu
-- !pos -9.036 -7.163 12.610 59
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.PARALYZE)

    -- Spawn already in the hidden pose so it never flickers into view first.
    mob:setMobMod(xi.mobMod.SPAWN_ANIMATIONSUB, 6)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGAIN, 300)
    mob:setMod(xi.mod.DMGMAGIC, -2500)

    -- Emerge onto the ferry: hidden (sub 6) and untargetable, then surface into
    -- the resting pose (sub 5) and become visible and targetable.
    mob:hideName(true)
    mob:setUntargetable(true)
    mob:setAnimationSub(6)
    mob:stun(3000)

    mob:timer(3000, function(mobArg)
        mobArg:setAnimationSub(5)
        mobArg:hideName(false)
        mobArg:setUntargetable(false)
    end)
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar('respawn', GetSystemTime() + 300) -- 5 minutes
end

return entity
