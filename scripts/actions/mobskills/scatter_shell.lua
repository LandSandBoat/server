-----------------------------------
-- Scatter Shell
-- Family: Orc Warmachine
-- Description: Deals 1000 physical damage divided among targets in an area of effect.
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
    params.damageType         = xi.damageType.BLUNT
    params.shadowBehavior     = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    params.skipPDIF           = true

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
