-----------------------------------
-- Touchdown
-- Family: Bahamut
-- Description: Deals magical damage to enemies in an area of effect.
-- Further Notes: Bahamut can use this as a regular move at will.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    -- TODO: Jimmayus spreadsheet says this is physical. Handle in mobPhysicalMove() PR
    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 1.50, 1.50, 1.50 }
    params.element        = xi.element.NONE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.NONE
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
