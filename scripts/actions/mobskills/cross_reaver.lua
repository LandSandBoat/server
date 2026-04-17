-----------------------------------
-- Cross Reaver
-- Family: Humanoid (Ark Angel HM)
-- Description: Deals high damage to players in a fan-shaped area. Additional Effect: Stun
-- Notes: Special weaponskill unique to Ark Angel HM. Deals ~500-900 damage.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Can skillchain?  Unknown property.

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 2
    params.fTP            = { 4.0, 4.0, 4.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_2 -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4) -- TODO: Capture stun duration
    end

    return info.damage
end

return mobskillObject
