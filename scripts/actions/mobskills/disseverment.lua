-----------------------------------
-- Disseverment
-- Family: Aern
-- Description: Delivers a fivefold attack. Additional Effect: Poison. Accuracy varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 5
    params.fTP            = { 1.0, 1.0, 1.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_5
    -- TODO: Possible accuracy modifier

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 19, 3, 180)
    end

    return info.damage
end

return mobskillObject
