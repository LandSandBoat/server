-----------------------------------
-- Quietus
-- Family: Humanoid Scythe Weaponskill
-- Description: Delivers a triple damage attack that ignores target's defense. Amount ignored varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 3.0, 3.0, 3.0 }
    -- params.str_wSC     = 0.4 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.mnd_wSC     = 0.4 -- TODO: Capture if mobskill weaponskills have wSC.
    params.ignoreDefense  = { 0.1, 0.3, 0.5 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
