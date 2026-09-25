-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Novv the Whitehearted
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.NOVV_THE_WHITEHEARTED - 1] = ID.mob.NOVV_THE_WHITEHEARTED, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMobMod(xi.mobMod.GIL_MIN, 4800)
    mob:setMobMod(xi.mobMod.GIL_MAX, 4800)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGEN, 50)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDespawn = function(mob)
end

return entity
