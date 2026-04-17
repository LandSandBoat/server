-----------------------------------
-- Impalement
-- Family: Craver
-- Description: Deals damage to a single target reducing their HP to 5%. Resets enmity.
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
    params.fTP            = { 0.95, 0.95, 0.95 } -- TODO: Capture % of current HP this does.
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

        -- TODO: Capture hate reset type (Enmity wipe vs enmity turned off)
        -- See Antica skill "Sand Trap" for reference
        mob:resetEnmity(target)
    end

    return info.damage
end

return mobskillObject
