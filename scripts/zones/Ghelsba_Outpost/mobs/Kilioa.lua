-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Kilioa
-- BCNM: Petrifying Pair
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1) -- lock from moving
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobEngaged = function(mob, target)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0) -- unlock mob
    mob:useMobAbility(373) -- secretion
end

entity.onMobWeaponSkill = function(mob, target, skill)
    if math.random() < 0.5 then
        return 370 -- favor baleful gaze
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
