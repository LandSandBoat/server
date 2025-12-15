-----------------------------------
-- Area: Spire of Dem
--  Mob: Ingester
-----------------------------------
mixins =
{
    require('scripts/mixins/families/empty_terroanima'),
    require('scripts/mixins/families/gorger_nm'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.REGAIN, 150)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
end

entity.onMobMobskillChoose = function(mob, target)
    -- 20% chance to prefer Fission
    if
        math.random(1, 100) <= 20 and
        xi.mix.gorger.canUseFission(mob)
    then
        return xi.mobSkill.FISSION
    end

    -- Otherwise use a random skill from the normal list
    local skillList =
    {
        xi.mobSkill.QUADRATIC_CONTINUUM_2,
        xi.mobSkill.SPIRIT_ABSORPTION_2,
        xi.mobSkill.VANITY_DRIVE_2,
        xi.mobSkill.STYGIAN_FLATUS_1,
        xi.mobSkill.PROMYVION_BARRIER_2,
    }

    return skillList[math.random(1, #skillList)]
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.MP_DRAIN, { chance = 100, power = math.random(1, 4) })
end

return entity
