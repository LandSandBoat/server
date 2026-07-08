-----------------------------------
-- 10000 Needles
-- Family: Cactuar
-- Description: Shoots multiple needles at enemies within range. Damage is distributed even among all targets hit.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage         = 10000 / skill:getTotalTargets()
    params.numHits            = 1
    params.fTP                = { 1.0, 1.0, 1.0 }
    params.attackType         = xi.attackType.PHYSICAL
    params.damageType         = xi.damageType.PIERCING
    params.shadowBehavior     = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    params.guaranteedFirstHit = true
    params.skipPDIF           = true

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
