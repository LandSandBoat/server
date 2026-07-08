-----------------------------------
-- Dustvoid
-- Family: Sandworms
-- Description: Deals Wind damage to targets. Removes all equipment from targets. Additional Effect: Knockback
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage      = mob:getMainLvl() + 2
    params.fTP             = { 0.5, 0.5, 0.5 }
    params.element         = xi.element.WIND
    params.attackType      = xi.attackType.MAGICAL
    params.damageType      = xi.damageType.WIND
    params.shadowBehavior  = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    params.dStatMultiplier = 1
    -- TODO: Capture knockback

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        if target:isPC() then
            for i = xi.slot.MAIN, xi.slot.BACK do
                target:unequipItem(i)
            end
        end
    end

    return info.damage
end

return mobskillObject
