-----------------------------------
-- Flash Nova
-- Family: Humanoid Club Weaponskill
-- Description: Deals light damage to a target. Additional effect: Flash.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getMainLvl() + 2
    params.fTP              = { 3.0, 3.0, 3.0 }
    -- params.str_wSC       = 0.3 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.mnd_wSC       = 0.3 -- TODO: Capture if mobskill weaponskills have wSC.
    params.element          = xi.element.LIGHT
    params.attackType       = xi.attackType.MAGICAL
    params.damageType       = xi.damageType.LIGHT
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.dStatMultiplier  = 1
    params.dStatAttackerMod = xi.mod.MND
    params.dStatDefenderMod = xi.mod.MND

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FLASH, 1, 0, 15)
    end

    return info.damage
end

return mobskillObject
