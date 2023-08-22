-----------------------------------
--  Stone Throw
--
--  Description: Damages a single target. Additional effect: Paralysis
--  Type: Physical
--  Utsusemi/Blink absorb: 1 shadow
--  Range: Melee
--  Notes:
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.RANGED, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.BLUNT, info.hitslanded)

    -- 50% chance
    if math.random(1, 2) == 1 then
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PARALYSIS, 20, 0, 60)
    end

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.BLUNT)
    end

    return dmg
end

return mobskillObject
