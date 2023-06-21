-----------------------------------
-- Heavy Stomp
--
-- Description: Deals heavy damage to targets within an area of effect. Additional effect: Paralysis
-- Type: Physical
-- Utsusemi/Blink absorb: 2-3 shadows
-- Range: Unknown radial
-- Notes: Paralysis effect has a very long duration.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local mobSkin = mob:getModelId()

    if mobSkin == 421 then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = math.random(2, 3)
    local accmod = 1
    local dmgmod = .7
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)
    local typeEffect = xi.effect.PARALYSIS

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 15, 0, 360)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)

    return dmg
end

return mobskillObject
