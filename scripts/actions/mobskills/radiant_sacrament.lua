-----------------------------------
-- Radiant Sacrament
-- Family: Avatar (Alexander)
-- Description: Used at regular intervals as a ranged attack when target is out of melee range.
-- Range: 20' maximum distance, unknown smaller radial (around target)
-- Notes: Alexander generally uses this on targets out of his melee range. Accompanied by text:
--        "Offer thy worship...
--        I shall burn away...thy transgressions..."
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
    params.fTP            = { 2.0, 2.0, 2.0 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAGIC_DEF_DOWN, 20, 0, 60) -- TODO: Capture power/duration
    end

    return info.damage
end

return mobskillObject
