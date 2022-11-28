-----------------------------------
-- Saucepan
-- Force feeds an unsavory dish.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 0.8
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)
    if target:hasStatusEffect(xi.effect.FOOD) then
        target:delStatusEffectSilent(xi.effect.FOOD)
    elseif target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        target:delStatusEffectSilent(xi.effect.FIELD_SUPPORT_FOOD)
    end

    target:addStatusEffectEx(xi.effect.FIELD_SUPPORT_FOOD, xi.effect.FOOD, 255, 0, 1800)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
