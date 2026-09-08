-----------------------------------
-- Vitriolic Barrage
-- Family: Yovra
-- Description: Deals 1000 physical damage divided between all targets in range. Additional Effect: Poison
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage         = 1000 / skill:getTotalTargets()
    params.numHits            = 1
    params.fTP                = { 1.0, 1.0, 1.0 }
    params.attackType         = xi.attackType.PHYSICAL
    params.damageType         = xi.damageType.PIERCING
    params.shadowBehavior     = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    params.guaranteedFirstHit = true
    params.skipPDIF           = true
    params.skipFSTR           = true
    params.skipParry          = true
    params.skipGuard          = true
    params.skipBlock          = true

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 18, 3, 180)
    end

    return info.damage
end

return mobskillObject
