-----------------------------------
-- Exenterator
-- Family: Humanoid Dagger Weaponskill
-- Description: Delivers a fourfold attack that decreases target's accuracy. Duration of effect varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 4
    params.fTP            = { 1.0, 1.0, 1.0 }
    -- params.agi_wSC     = 0.73 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_4

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ACCURACY_DOWN, 20, 0, math.floor(45 + 45 * skill:getTP() / 1000))
    end

    return info.damage
end

return mobskillObject
