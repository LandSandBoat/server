-----------------------------------
-- Starburst
-- Family: Humanoid Staff Weaponskill
-- Description: Deals light or darkness elemental damage. Damage varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getMainLvl() + 2
    params.fTP              = { 1.0, 2.0, 2.5 }
    -- params.str_wSC       = 0.4 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.mnd_wSC       = 0.4 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType       = xi.attackType.MAGICAL

    if math.random(1, 100) <= 50 then
        params.element      = xi.element.LIGHT
        params.damageType   = xi.damageType.LIGHT
    else
        params.element      = xi.element.DARK
        params.damageType   = xi.damageType.DARK
    end

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
