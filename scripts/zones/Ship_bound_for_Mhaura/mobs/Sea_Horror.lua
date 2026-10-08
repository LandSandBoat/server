-----------------------------------
-- Area: Ship Bound for Mhaura
--   NM: Sea Horror
-- One of the deck lottery slots.
-- xi.ferry boards it and times its fade.
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.mobSkill.HUNDRED_FISTS_1 },
        },
    })
end

return entity
