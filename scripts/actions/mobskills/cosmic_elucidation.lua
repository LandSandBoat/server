-----------------------------------
-- Cosmic Elucidation
-- Family: Tenzen
-- Description: Cosmic Elucidation inflicts heavy AOE damage to everyone in the battle.
-- Notes: Ejects all combatants from the battlefield, resulting in a failure.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 1 -- Only scripted use
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 14, 14, 14 }
    params.element        = xi.element.LIGHT
    params.attackType     = xi.attackType.SPECIAL
    params.damageType     = xi.damageType.ELEMENTAL
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        skill:setMsg(xi.msg.basic.SKILLCHAIN_COSMIC_ELUCIDATION)
    end

    return info.damage
end

return mobskillObject
