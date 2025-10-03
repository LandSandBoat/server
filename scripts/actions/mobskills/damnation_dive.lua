-----------------------------------
-- Damnation Dive
--
-- Description: Dives into a single target. Additional effect: Knockback + Stun
-- Type: Physical
-- Utsusemi/Blink absorb: 3 shadow
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
    local numhits = 3
    local accmod = 1
    local ftp    = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.CRIT_VARIES, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
