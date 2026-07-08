-----------------------------------
-- Blade: Shun
-- Family: Humanoid Katana Weaponskill
-- Description: Delivers a fivefold attack. Attack power varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage        = mob:getWeaponDmg()
    params.numHits           = 5
    params.fTP               = { 0.6875, 0.6875, 0.6875 }
    params.fTPSubsequentHits = { 0.6875, 0.6875, 0.6875 }
    -- params.dex_wSC        = 0.85 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.SLASHING
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_5
    params.attackMultiplier  = { 1.0, 2.0, 3.0 }

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
