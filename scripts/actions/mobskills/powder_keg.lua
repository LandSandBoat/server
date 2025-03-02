-----------------------------------
-- Powder Keg (Lion)
-- Conal damage, knock back, defense down, and magic defense down.
-- Type: Physical
-- Skillchain Properties: Fusion/Compression
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

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 20, 0, 60)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.MAGIC_DEF_DOWN, 20, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

    return dmg
end

return mobskillObject
