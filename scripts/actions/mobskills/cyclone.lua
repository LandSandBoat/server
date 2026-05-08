-----------------------------------
-- Cyclone
-- Family: Humanoid Dagger Weaponskill
-- Description: Delivers an area of effect wind elemental attack. Damage varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getMainLvl() + 2
    params.fTP              = { 1.0, 2.375, 2.875 }
    -- params.dex_wSC       = 0.3  -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.int_wSC       = 0.25 -- TODO: Capture if mobskill weaponskills have wSC.
    params.element          = xi.element.WIND
    params.attackType       = xi.attackType.MAGICAL
    params.damageType       = xi.damageType.WIND
    params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.dStatMultiplier  = 1
    params.dStatAttackerMod = xi.mod.INT
    params.dStatDefenderMod = xi.mod.INT

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
