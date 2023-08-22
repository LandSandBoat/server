-----------------------------------
-- Sulfurous_Breath
-- Deals Fire damage to enemies within a fan-shaped area.
-- Breath Attack
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if target:isBehind(mob, 48) then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local ftp100 = 2.0
    local ftp200 = 2.5
    local ftp300 = 3.0

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, ftp100, ftp200, ftp300)
    local conaldmg = utils.conalDamageAdjustment(mob, target, skill, info.dmg, 0.2)
    local dmg = xi.mobskills.mobFinalAdjustments(conaldmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded * math.random(1, 2))

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    end

    return dmg
end

return mobskillObject
