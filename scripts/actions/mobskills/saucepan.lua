-----------------------------------
-- Saucepan
-- Family: Goblin
-- Description: Force feeds an unsavory dish.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 0.8, 0.8, 0.8 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        if target:hasStatusEffect(xi.effect.FOOD) then
            target:delStatusEffectSilent(xi.effect.FOOD)
        end

        target:addStatusEffect(xi.effect.FOOD, { power = 255, duration = 1800, origin = mob, sourceType = xi.effectSourceType.FOOD })
    end

    return info.damage
end

return mobskillObject
