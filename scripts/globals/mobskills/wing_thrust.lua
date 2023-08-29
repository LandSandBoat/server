-----------------------------------
--  Wing Thrust
--  Family: Aern
--  Type: Physical
--  Can be dispelled: N/A
--  Utsusemi/Blink absorb: 4 Shadows
--  Range: Single Target 7.0'
-----------------------------------
require("scripts/globals/mobskills")

-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 4
    local accmod = 1

    -- https://docs.google.com/spreadsheets/d/1YBoveP-weMdidrirY-vPDzHyxbEI2ryECINlfCnFkLI/edit#gid=57955395&range=A967
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, 1, xi.mobskills.physicalTpBonus.DMG_BONUS, 0.5, 0.5, 0.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.NONE, info.hitslanded)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.SLOW, 1250, 0, 60)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.NONE)
    end

    return dmg
end

return mobskillObject
