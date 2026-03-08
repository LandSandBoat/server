-----------------------------------
-- Saucepan
-- Force feeds an unsavory dish.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local numhits = 1
    local accmod = 1
    local ftp    = 0.8
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)
    if target:hasStatusEffect(xi.effect.FOOD) then
        target:delStatusEffectSilent(xi.effect.FOOD)
    end

    target:addStatusEffect(xi.effect.FOOD, { power = 255, duration = 1800, origin = mob, sourceType = xi.effectSourceType.FOOD })
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
