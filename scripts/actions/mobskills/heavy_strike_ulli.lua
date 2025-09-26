-----------------------------------
-- Heavy Strike (Ullikummi)
-- Damage varies with TP. Resets enmity if damage is dealt. Always knocks back players even if it misses.
-- 0% TP: 2.25 / 150% TP: 3.50 / 300% TP: 4.75
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod  = 1
    local ftp     = 3
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    if dmg > 0 then
        mob:resetEnmity(target)
    end

    return dmg
end

return mobskillObject
