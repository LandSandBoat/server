-----------------------------------
--  Hydro Wave
--  Description: Deals water damage to enemies around the caster.
--  Type: Magical (Water)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage   = mob:getWeaponDmg()
    local power    = math.random(1, 16)
    local duration = math.floor(30 * xi.mobskills.applyPlayerResistance(mob, xi.effect.ENCUMBRANCE_II, target, mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT), 0, 0))

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WATER, 2.5, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    mob:addStatusEffect(xi.effect.STONESKIN, 0, 0, 180, 2, 1500)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ENCUMBRANCE_II, power, 0, duration)

    return damage
end

return mobskillObject
