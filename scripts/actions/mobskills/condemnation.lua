-----------------------------------
-- Condemnation
-- Family: Demon (Kindred)
-- Description: Deals conal physical damage to targets in front of mob. Additional Effect: Stun
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- TODO: Set proper skill lists
    local zone = mob:getZoneID()

    if
        mob:isInDynamis() or
        zone == xi.zone.ULEGUERAND_RANGE
    then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 3
    params.fTP            = { 3, 3, 3 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3
    -- TODO: Seemed to be rather inaccurate during captures as a Lv 75 WHM vs Lv 82 Demon.
    -- params.accuracyModifier = { -xx, -xx, -xx }

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture stun duration
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 12)
    end

    return info.damage
end

return mobskillObject
