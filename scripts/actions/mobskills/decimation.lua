-----------------------------------
-- Decimation
-- Family: Humanoid Axe Weaponskill
-- Description: Delivers a threefold attack. Accuracy varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage        = mob:getWeaponDmg()
    params.numHits           = 3
    params.fTP               = { 1.25, 1.25, 1.25 }
    -- params.str_wSC        = 0.5 -- TODO: Capture if mobskill weaponskills have wSC.
    params.accuracyModifier  = { 0, 30, 60 }
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.SLASHING
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_3

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
