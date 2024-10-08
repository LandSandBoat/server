-----------------------------------
-- Sonic Buffet
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = math.floor(mob:getWeaponDmg() * 2.5)

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WIND, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    for i = 1, math.random(2, 3) do
        target:dispelStatusEffect(xi.effectFlag.DISPELABLE)
    end

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    return damage
end

return mobskillObject
