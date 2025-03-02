-----------------------------------
-- Sudden Lunge
-- Knockback damage and Stun effect. Ignores Utsusemi, reduces Ladybug's HP by 5%-15% whether it hits or not.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local ftp    = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, 0)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    local currentHP = mob:getHP()
    local newHP = currentHP - (currentHP * (math.random(5, 15) / 100))
    mob:setHP(newHP)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)

    return dmg
end

return mobskillObject
