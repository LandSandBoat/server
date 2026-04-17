-----------------------------------
-- Gnash
-- Family: Orobon
-- Description: Chews on a single target, reducing HP to one half.
-- Notes: Retail testing shows this is more like 45% to 55% of the targets current HP
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    local fTP = (math.random(45, 55) / 100) -- TODO: Is it random or does something influence it?

    params.baseDamage     = target:getHP()
    params.numHits        = 1
    params.fTP            = { fTP, fTP, fTP } -- TODO: Capture % of current HP this does.
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
