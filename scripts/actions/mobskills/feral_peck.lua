-----------------------------------
-- Feral Peck
-- Family: Amphiptere
-- Description: Deals a set amount of heavy damage (seems like ~90% of target's current HP) to a single target.
-- Notes: Used by Zirnitra and Turul
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = target:getHP()
    params.numHits        = 1
    params.fTP            = { 0.90, 0.90, 0.90 } -- TODO: Capture % of current HP this does.
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.skipFSTR       = true
    params.skipPDIF       = true
    params.skipParry      = true -- TODO: Confirm this can't be parried, guarded or blocked.
    params.skipGuard      = true
    params.skipBlock      = true

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
