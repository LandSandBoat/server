-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Worr the Clawfisted
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.WORR_THE_CLAWFISTED - 3] = ID.mob.WORR_THE_CLAWFISTED, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)

    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMobMod(xi.mobMod.GIL_MIN, 4800)
    mob:setMobMod(xi.mobMod.GIL_MAX, 4800)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.VIT, 50)  -- Captures show this NM has a huge vit boost
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 381)
end

entity.onMobDespawn = function(mob)
end

return entity
