-----------------------------------
--  Tachi: Gekko
--
--  Description:  Silences target. Damage varies with TP.
--  Type: Physical
--  Shadow per hit
--  Range: Melee
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
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.56, 1.88, 2.50)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    if not skill:hasMissMsg() then
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)
        -- About 300-400 to a DD.
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    end

    return dmg
end

return mobskillObject
