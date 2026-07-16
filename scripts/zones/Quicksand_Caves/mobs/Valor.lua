-----------------------------------
-- Area: Quicksand Caves
--  Mob: Valor
-- Coming of Age (San dOria Mission 8-1)
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 8)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.ACC, 150)

    -- Valor uses Hundred Fists despite the WAR main job, so force it rather than the job 2hr.
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.mobSkill.HUNDRED_FISTS_1 },
        },
    })
end

return entity
