-----------------------------------
-- Havoc Spiral
-- Family: Humanoid (Ark Angel MR)
-- Description: Deals damage to players in an area of effect. Additional Effect: Sleep
-- Notes: Special weaponskill unique to Ark Angel MR. Deals ~100-300 damage.
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
    params.fTP            = { 3.0, 3.0, 3.0 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_2 -- TODO: Capture shadowBehavior
    -- TODO: Can skillchain?  Unknown property

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, math.random(30, 60)) -- TODO: Capture effect power/duration
    end

    return info.damage
end

return mobskillObject
