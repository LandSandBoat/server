-----------------------------------
-- Resolution
-- Family: Humanoid Great Sword Weaponskill
-- Description: Delivers a fivefold attack.
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
    params.fTP               = { 0.71875, 0.84375, 0.96875 }
    params.fTPSubsequentHits = { 0.71875, 0.84375, 0.96875 }
    -- params.str_wSC        = 0.85 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.SLASHING
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_5
    params.attackMultiplier  = { 0.85, 0.85, 0.85 }

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
