-----------------------------------
-- Undead Mold
-- Family: Doomed
-- Description: Releases undead spores that damages targets in front. Additional Effect: Disease
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 2.00, 2.00, 2.00 } -- TODO: Capture fTP scalings
    params.element        = xi.element.DARK
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    -- TODO: Confirm whether this is physical or magical move. Jimmayus sheet says Unaspected Physical. JP Wiki says Dark.
    -- TODO: Confirm AoE type. Jimmayus sheet says single target. JP Wiki says forward cone.

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DISEASE, 1, 0, 660)
    end

    return info.damage
end

return mobskillObject
