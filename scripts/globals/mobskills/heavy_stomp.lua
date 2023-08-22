-----------------------------------
--  Heavy Stomp
--
--  Description: Deals heavy damage to targets within an area of effect. Additional effect: Paralysis
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: Unknown radial
--  Notes: Paralysis effect has a very long duration.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_VARIES, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    local typeEffect = xi.effect.PARALYSIS
    local duration = 360
    local power = 30

    if mob:getPool() == 3575 then
        duration = 960
        power    = 70
    end

    mob:lookAt(target:getPos())

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, typeEffect, power, 0, duration)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end

return mobskillObject
