-----------------------------------
-- Hexa Strike
-- Family: Humanoid Club Weaponskill
-- Description: Delivers a sixfold attack. Chance of critical hit varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 6
    params.fTP            = { 1.0, 1.0, 1.0 }
    -- params.str_wSC     = 0.2 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.mnd_wSC     = 0.2 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_6
    params.canCrit        = true
    params.criticalChance = { 0.10, 0.30, 0.50 }

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
