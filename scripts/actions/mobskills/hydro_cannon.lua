-----------------------------------
-- Hydro Cannon
-- Family: Ultima
-- Description: Deals Water damage in a conal AOE. Additional Effect : Poison
-- TODO: Figure out damage values for Ultima/Omega Master Trial
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.percentMultipier = 0.05
    params.damageCap        = mob:getMainLvl() < 65 and 490 or 750
    params.bonusDamage      = 0
    params.mAccuracyBonus   = { 0, 0, 0 }
    params.resistStat       = xi.mod.INT
    params.element          = xi.element.WATER
    params.attackType       = xi.attackType.BREATH
    params.damageType       = xi.damageType.WATER
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 50, 3, 120)

        if target:hasStatusEffect(xi.effect.ELEMENTALRES_DOWN) then
            target:delStatusEffectSilent(xi.effect.ELEMENTALRES_DOWN)
        end
    end

    mob:setLocalVar('nuclearWaste', 0) -- TODO: Migrate to mob script

    return info.damage
end

return mobskillObject
