-----------------------------------
-- Pile Pitch
-- Family: Omega
-- Description:  Reduces target's HP to 5% of its maximum value. Additional Effect: Bind
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
        target:takeDamage(info.damage, mob, info.attackType, info.damageType, { breakBind = false })

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 30)
        mob:resetEnmity(target) -- TODO: Check hate reset type (Aggro pause vs full enmity reset.)
    end

    return info.damage
end

return mobskillObject
