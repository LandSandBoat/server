-----------------------------------
-- Lux Arrow
-- Trust: Semih Lafihna
-- Fragmentation/Distortion skillchain properties
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = math.floor(mob:getWeaponDmg() * 2.5)

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.LIGHT, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, 1)

    target:takeDamage(damage, mob, xi.attackType.RANGED, xi.damageType.PIERCING)

    return damage
end

return mobskillObject
