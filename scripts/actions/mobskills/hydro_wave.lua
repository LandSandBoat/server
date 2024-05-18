-----------------------------------
--  Hydro Wave
--  Description: Deals water damage to enemies around the caster.
--  Type: Magical (Water)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power    = math.random(1, 16)
    local resist   = xi.mobskills.applyPlayerResistance(mob, xi.effect.ENCUMBRANCE_II, target, mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT), 0, 0)
    local duration = 30 * resist

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ENCUMBRANCE_II, power, 0, duration)

    local dmgmod = 2.5
    local info   = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg(), xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)

    mob:addStatusEffect(xi.effect.STONESKIN, 0, 0, 180, 2, 1500)

    return dmg
end

return mobskillObject
