-----------------------------------
-- Stormwind
-- Family: Rocs
-- Description: Creates a whirlwind that deals Wind damage to targets in an area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 3.00, 3.00, 3.00 }
    params.element        = xi.element.WIND
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.WIND
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    if mob:getPool() == xi.mobPool.KREUTZET then
        local stormwindDamage = mob:getLocalVar('stormwindDamage') -- TODO: Maybe change name of localVar to stormwindCounter for clarity.

        if stormwindDamage == 2 then
            params.fTP = { 3.25, 3.25, 3.25 }
        elseif stormwindDamage == 3 then
            params.fTP = { 3.60, 3.60, 3.60 }
        end
    end

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Nightmare Rocs apply Silence.
    end

    return info.damage
end

return mobskillObject
