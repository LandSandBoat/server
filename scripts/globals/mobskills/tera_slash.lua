-----------------------------------
--  Tera Slash
--
--  Description: Deals high damage to players within a fan-shaped area of effect.
--  Type: Physical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown cone
--  Notes:
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmg = 0
    if mob:getHPP() <= 25 and math.random() > 0.50 then
        dmg = target:getHP()
        target:setHP(0)
        return dmg
    end

    local numhits = 1
    local accmod = 2
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 1.5, 2)
    dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
