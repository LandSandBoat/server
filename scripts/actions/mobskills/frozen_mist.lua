-----------------------------------
--  Frozen Mist
--  Description: Deals ice damage to enemies around the caster. Additional effect: Terror
--  Type: Magical (Ice)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage   = mob:getWeaponDmg()
    local duration = math.floor(30 * xi.mobskills.applyPlayerResistance(mob, xi.effect.TERROR, target, mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT), 0, 0))

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.ICE, 1.5, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.TERROR, 30, 0, duration)

    return damage
end

return mobskillObject
