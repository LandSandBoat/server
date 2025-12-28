-----------------------------------
-- Ice Break
-- Deals ice damage to enemies within range. Additional Effect: "Bind."
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    --  TODO: Damage should be 1 + dINT
    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.element.ICE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.ICE, { breakBind = false })
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, math.random(120, 180))

    return damage
end

return mobskillObject
