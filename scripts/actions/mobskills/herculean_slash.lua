-----------------------------------
-- Herculean Slash
-- Family: Humanoid Great Sword Weaponskill
-- Description: Paralyzes target. Duration of effect varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}
    local duration = xi.mobskills.calculateDuration(skill:getTP(), 60, 180)

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 3.5, 3.5, 3.5 }
    -- params.vit_wSC     = 0.6 -- TODO: Capture if mobskill weaponskills have wSC.
    params.element        = xi.element.ICE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.ICE
    params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 30, 0, duration)
    end

    return info.damage
end

return mobskillObject
