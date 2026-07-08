-----------------------------------
-- Megaflare
-- Family: Bahamut
-- Description: Deals heavy Fire damage to enemies within a fan-shaped area.
-- Notes: Used by Bahamut every 10% of its HP (except at 10%), but can use at will when under 10%.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage      = mob:getMainLvl()
    params.fTP             = { 10, 10, 10 }
    params.element         = xi.element.FIRE
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.FIRE
    params.shadowBehavior  = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    params.dStatMultiplier = 1.5

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    -- Targets that are not the primary target take 300 less damage.
    if
        target:getID() ~= skill:getPrimaryTargetID() and
        info.damage > 0 -- Damage was not nullified or absorbed.
    then
        info.damage = math.max(0, info.damage - 300)
    end

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
