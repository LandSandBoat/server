-----------------------------------
--  Shield Strike
--
--  Description: Attempts to Shield Bash players.  Additional effect: Stun
--  Type: Physical
--  1 shadow?
--  Range: Melee front arc
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- TODO: Knockback

    local numhits = 1
    local accmod = 1
    local ftp    = 0.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    -- <100 damage to pretty much anything, except on rare occasions.
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
