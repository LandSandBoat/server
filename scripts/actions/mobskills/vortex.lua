-----------------------------------
-- Vortex
-- Family: Ealdnarche
-- Description: Creates a vortex that damages targets in an area of effect. Additional Effect: Terror
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
    params.fTP            = { 1.5, 1.5, 1.5 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior (JP Wiki says Ignores shadows)

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture duration of effects
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.TERROR, 1, 0, 9)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 30)

        -- TODO: Capture hate reset type (Enmity wipe vs enmity turned off)
        -- See Antica skill "Sand Trap" for reference
        mob:resetEnmity(target)
    end

    return info.damage
end

return mobskillObject
