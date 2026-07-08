-----------------------------------
-- Lamentation
-- Family: Seethers
-- Description: Deals Light damage to all targets in range. Additional Effect: Dia
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 1, 1, 1 } -- TODO: Capture fTPs
    params.element        = xi.element.LIGHT
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.LIGHT
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS -- TODO: Capture shadowBehavior. JP Wiki says ignores shadows, EN Wikis say it wipes them.

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DIA, 8, 3, 30, 0, 20)

        local effect1 = target:getStatusEffect(xi.effect.DIA)
        if effect1 then
            effect1:delEffectFlag(xi.effectFlag.ERASABLE)
        end
    end

    return info.damage
end

return mobskillObject
