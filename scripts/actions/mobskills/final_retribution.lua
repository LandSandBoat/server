-----------------------------------
-- Final Retribution
-- Family: Corse
-- Description: Damages enemies in an area of effect. Additional Effect: Stun
-- Notes: Only used by some notorious monsters like Xolotl.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Jimmayus spreadsheet says this does fire damage but online sources say it can be absorbed by shadows.
    --       We should probably recapture this skill before changing anything.

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 3.2, 3.2, 3.2 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4) -- TODO: Capture stun duration
    end

    return info.damage
end

return mobskillObject
