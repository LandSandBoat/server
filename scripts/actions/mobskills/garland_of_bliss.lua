-----------------------------------
-- Garland of Bliss
-- Family: Humanoid Staff Weaponskill
-- Description: Lowers target's defense. Duration of effect varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getMainLvl() + 2
    params.fTP              = { 2.0, 2.0, 2.0 }
    -- params.mnd_wSC       = 0.4 -- TODO: Capture if mobskill weaponskills have wSC.
    params.element          = xi.element.LIGHT
    params.attackType       = xi.attackType.MAGICAL
    params.damageType       = xi.damageType.LIGHT
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.dStatMultiplier  = 2
    params.dStatAttackerMod = xi.mod.MND
    params.dStatDefenderMod = xi.mod.MND

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 12.5, 0, math.floor(6 * skill:getTP() / 100))
    end

    return info.damage
end

return mobskillObject
