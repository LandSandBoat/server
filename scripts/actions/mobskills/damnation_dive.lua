-----------------------------------
-- Damnation Dive
-- Description: Deals physical damage to targets in a fan-shaped area of effect. Additional effect: Stun
-- Notorious Monster / Nightmare version can critically strike and is handled in damnation_dive_nm.lua
-- Type: Physical (Slashing)
-- Utsusemi/Blink absorb: 3 shadows
-- Range: Melee
-- Notes: Used instead of Gliding Spike by certain notorious monsters.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

-----------------------------------
-- onMobSkillCheck
-- Check for Ghrah family bird form.
-- If not in Bird form, then ignore.
-----------------------------------
mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getFamily() == 122 and
        mob:getAnimationSub() ~= 3
    then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod  = 1
    local ftp     = 2
    local info    = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT, 0, 0, 0)
    local dmg     = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 15)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
