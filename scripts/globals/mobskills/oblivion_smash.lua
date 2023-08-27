-----------------------------------
-- Oblivion Smash
--
-- Description: Deals damage to players within area of effect and inflicts blind, silence, bind, and weight.
-- Type: Physical
-- Utsusemi/Blink absorb:  2-3 shadows
-- Range: Unknown radial
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmg = 0

    if mob:getHPP() <= 25 then
        dmg = target:getHP()
        target:setHP(0)
        return dmg
    end

    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BLINDNESS, 20, 0, 120)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SILENCE, 0, 0, 120)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.BIND, 0, 0, 120)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.WEIGHT, 50, 0, 120)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end

return mobskillObject
