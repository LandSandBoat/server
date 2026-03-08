-----------------------------------
-- Wind Shear
-- Family: Puks
-- Description: Deals Wind damage to enemies within an area of effect. Additional Effect: Knockback
-- Notes: The knockback is rather severe.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 1.25, 1.50, 1.75 } -- TODO: Capture fTP scaling
    params.element        = xi.element.WIND
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.WIND
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS -- TODO: Capture shadowBehavior.
    -- TODO: Jimmayus spreadsheet states if this is fully resisted, it misses(Knockback nullified as well?).
    -- Might want to verify if physical or magical. Spreadsheet says Wind, JP Wiki says physical.

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
