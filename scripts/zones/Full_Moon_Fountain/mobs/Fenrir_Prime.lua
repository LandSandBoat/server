-----------------------------------
-- Area: Full Moon Fountain
-- Mob: Fenrir Pime
-- Quest: The Moonlit Path
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)

    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 30)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 30)
    mob:setMobMod(xi.mobMod.MAGIC_RANGE, 30)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = 839, hpp = math.random(30, 55) }, -- Uses Howling Moon once while near 50% HPP.
        },
    })

    mob:setMod(xi.mod.ACC, 327)
    mob:setMod(xi.mod.REGAIN, 150)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 250)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skills =
    {
        xi.mobSkill.MOONLIT_CHARGE,
        xi.mobSkill.CRESCENT_FANG,
        xi.mobSkill.LUNAR_CRY,
        xi.mobSkill.LUNAR_ROAR,
        xi.mobSkill.ECLIPSE_BITE
    }

    return skills[math.random(1, #skills)]
end

return entity
