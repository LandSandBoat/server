-----------------------------------
-- Walk the Plank (Lion)
-- AoE Damage, Bind, Knockback, dispel
-- Type: Physical (AoE)
-- Skillchain Properties: Light/Distortion
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 2
    local ftp    = 0.3
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, mob:getWeaponDmg() * ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    target:dispelStatusEffect()
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 1, 0, 20)

    return dmg
end

return mobskillObject
