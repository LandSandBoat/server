-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Vampyr Wolf (Einherjar; Vampyr Jarl adds)
-- Notes: 6 copies of this mob spawns when Vampyr Jarl uses Nocturnal Servitude.
-- On spawn, they run in random directions, similar to Terror'd Promyvion bosses. They do not aggro.
-- All are immune to Bind, Gravity, Sleeps, Petrify, Stun and Terror.
-- One of the 6 is also immune to every source of damage or enfeebs.
-- This copy does not engage players, even if a direct action is performed.
-- Every mob killed removes ~6% HP from Jarl.
-- Vampyr Jarl script contains the bulk of the logic for this mob.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.STUN)

    mob:setMobMod(xi.mobMod.CHARMABLE, 0)
    mob:setMobMod(xi.mobMod.CLAIM_TYPE, xi.claimType.NON_EXCLUSIVE)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.GIL_BONUS, -100)
    mob:setMobMod(xi.mobMod.DONT_ROAM_HOME, 1)
    mob:setMobMod(xi.mobMod.ROAM_COOL, 8)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 60)
    mob:setMobMod(xi.mobMod.ROAM_RATE, 5)
    mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
    mob:setMobMod(xi.mobMod.RUN_SPEED_MULT, 150)
end

return entity
