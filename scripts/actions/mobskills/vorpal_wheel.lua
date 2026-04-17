-----------------------------------
-- Vorpal Wheel
-- Family: Mamool Ja
-- Description: Throws a slicing wheel at a single target.
-- Notes: Used by Gulool Ja Ja, and will use it as a counterattack to any spells cast on him. Damage increases as his health drops. Can be Shield Blocked.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- Increase damage as health drops
    local fTP = (1 - (mob:getHP() / mob:getMaxHP())) * 6

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { fTP, fTP, fTP } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
