-----------------------------------
-- Shijin Spiral
-- Family: Humanoid Hand to Hand Weaponskill
-- Description: Delivers a fivefold attack that inflicts Plague.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getWeaponDmg()
    params.numHits          = 5
    params.fTP              = { 1.0625, 1.0625, 1.0625 }
    --params.dex_wSC        = 0.85 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackMultiplier = { 1.05, 1.05, 1.05 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.HTH
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_5

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local duration = xi.mobskills.calculateDuration(skill:getTP(), 18, 24)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 3, duration)
    end

    return info.damage
end

return mobskillObject
