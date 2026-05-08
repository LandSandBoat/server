-----------------------------------
-- Shoulder Tackle
-- Family: Humanoid Hand to Hand Weaponskill
-- Description: Delivers a twofold attack that stuns target.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 2
    params.fTP            = { 1.0, 1.0, 1.0 }
    --params.vit_wSC      = 0.3 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.HTH
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_2

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local duration = xi.mobskills.calculateDuration(skill:getTP(), 2, 6)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, duration)
    end

    return info.damage
end

return mobskillObject
