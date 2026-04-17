-----------------------------------
-- Oblivion Smash
-- Family: Shadow Lord (Dynamis Lord)
-- Description: Deals damage to players within area of effect and inflicts blind, silence, bind, and weight.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 3 -- TODO: Capture numHits
    params.fTP            = { 2.5, 2.5, 2.5 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Capture effects and effect power/duration
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 20, 0, 120)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 0, 0, 120)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 0, 0, 120)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 50, 0, 120)
    end

    return info.damage
end

return mobskillObject
