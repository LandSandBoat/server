-----------------------------------
-- Overthrow
-- Family: Troll
-- Description: Throws a target backward.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- Do not use if still holding a weapon
    if mob:getAnimationSub() == 0 then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: JPWiki says this may scale based on mob's current HP and may be affected by Quake Stomp.
    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 1.0, 1.0, 1.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.HTH
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
