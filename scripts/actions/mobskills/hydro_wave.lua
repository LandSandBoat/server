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
    -- water aura that provides special stoneskin that absorbs only magical/breath/non-elemental damage
    skill:setFinalAnimationSub(2)
    mob:delStatusEffectSilent(xi.effect.STONESKIN)
    mob:addStatusEffect(xi.effect.STONESKIN, 0, 0, 180, 2, 1500)

    local damage     = mob:getWeaponDmg()
    local power      = math.random(1, 16)
    local resistRate = xi.combat.magicHitRate.calculateResistRate(mob, target, 0, 0, 0, xi.element.WATER, xi.mod.INT, xi.effect.ENCUMBRANCE_II, 0)
    local duration   = math.floor(30 * resistRate)

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WATER, 2.5, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ENCUMBRANCE_II, power, 0, duration)

    return damage
end

return mobskillObject
