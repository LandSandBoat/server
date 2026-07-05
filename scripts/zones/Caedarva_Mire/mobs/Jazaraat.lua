-----------------------------------
-- Area: Caedarva Mire
--  Mob: Jazaraat
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGEN, 10)
    mob:setMod(xi.mod.CRITHITRATE, 50) -- TODO: More accurate crit rate value
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.mobSkill.WILD_CARD, hpp = math.randomInt(25, 35) },
        },
    })
end

entity.onMobMobskillChoose = function(mob, target)
    local tpList =
    {
        xi.mobSkill.AEGIS_SCHISM_1,
        xi.mobSkill.BARBED_CRESCENT_1,
        xi.mobSkill.DANCING_CHAINS_1,
        xi.mobSkill.FOXFIRE,
        xi.mobSkill.NETHERSPIKES_1,
    }

    return tpList[math.randomInt(1, #tpList)]
end

return entity
