-----------------------------------
-- Vortex
-- Creates a vortex that damages targets in an area of effect. Additional effect: Terror
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local ftp    = 1.5 -- fTP and fTP scaling unknown. TODO: capture ftp
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT, 0, 0, 0)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.TERROR, 1, 0, 9)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 1, 0, 30)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)

    if not target:isTrust() then
        mob:resetEnmity(target)
    end

    return dmg
end

return mobskillObject
