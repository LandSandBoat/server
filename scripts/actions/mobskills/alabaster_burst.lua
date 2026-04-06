-----------------------------------
-- Alabaster Burst
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local numhits = 2
    local accmod  = 3
    local dmgmod  = 4
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg     = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    local duration = (skill:getTP() / 100) / 6 -- 2 sec min, 5 sec max
    if duration < 2 then
        duration = 2
    end

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FLASH, 1, 0, duration)

    return dmg
end

return mobskillObject
