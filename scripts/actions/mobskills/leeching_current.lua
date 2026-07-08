-----------------------------------
-- Leeching Current
-- Family: Orobons
-- Description: Deal Water? damage spread evenly among targets in range. Additional Effect: HP Drain
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- We use a var here so that mobs can use different values
    local base = mob:getLocalVar('leechingCurrent')

    if base == 0 then
        base = 1000
    end

    params.baseDamage           = base / skill:getTotalTargets()
    params.fTP                  = { 1, 1, 1 }
    params.element              = xi.element.NONE -- TODO: Capture if element is Water or Dark or None.
    params.attackType           = xi.attackType.MAGICAL
    params.damageType           = xi.damageType.NONE
    params.shadowBehavior       = xi.mobskills.shadowBehavior.WIPE_SHADOWS -- TODO: Capture shadowBehavior
    params.skipMagicBonusDiff   = true

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.HP, info.damage)
    end

    return info.damage
end

return mobskillObject
