-----------------------------------
-- No Quarter
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setFinalAnimationSub(0)
    local numhits = 3
    local accmod  = 3
    local dmgmod  = mob:getWeaponDmg() * 0.35
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg     = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    mob:setMod(xi.mod.DMGPHYS, 0) -- Remove the Phyisical damage taken effect
    mob:setLocalVar('DaybreakEndTime', GetSystemTime())

    return dmg
end

return mobskillObject
