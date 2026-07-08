-----------------------------------
-- Empty Salvation
-- Family: Promathia
-- Description: Damages all targets in range with the salvation of emptiness. Additional Effect: Dispels 3 effects
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 2, 2, 2 } -- TODO: Capture fTPs
    params.element        = xi.element.DARK
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    -- TODO: Capture shadowBehavior
    -- TODO: There are two entries for this skill with different animations.
    -- Check to see if there are any differences between them.

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    -- Dispel 3 status effects
    for i = 1, 3 do
        if not target:dispelStatusEffect(xi.effectFlag.DISPELABLE) then
            break
        end
    end

    return info.damage
end

return mobskillObject
