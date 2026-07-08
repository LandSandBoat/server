-----------------------------------
-- Drakesbane
-- Family: Humanoid Polearm Weaponskill
-- Description: Delivers a fourfold attack. Chance of critical hit varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getWeaponDmg()
    params.numHits          = 4
    params.fTP              = { 1.0, 1.0, 1.0 }
    -- params.str_wSC       = 0.5 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.PIERCING
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_4
    params.canCrit          = true
    params.criticalChance   = { 0.1, 0.3, 0.5 }
    params.attackMultiplier = { 0.8125, 0.8125, 0.8125 }

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
