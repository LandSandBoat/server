-----------------------------------
-- Stifling Tantara
--
-- Description: Inflicts silence in an area of effect and deals damage.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Strips shadows
-- Range: 10' as well as single target outside of 10'
-- Notes: Doesn't use this if its horn is broken. Used only by certain Imp NMs, in place of Deafening Tantara.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 1 and mob:getFamily() == 165 then -- Imps without horn
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local ftp    = 3.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SILENCE, 1, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)
    return dmg
end

return mobskillObject
