-----------------------------------
-- Omega Javelin
-- Pierces a single target with an ethereal javelin. Additional effect: Petrification
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local ftp    = 2 -- fTP and fTP scaling unknown. TODO: capture ftp
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT, 0, 0, 0)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PETRIFICATION, 1, 0, 45)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    mob:resetEnmity(target)
    return dmg
end

return mobskillObject
