-----------------------------------
-- Shockwave
-- Family: Humanoid Great Sword Weaponskill
-- Description: Delivers an area of effect attack. Sleeps enemies. Duration varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}
    local duration = xi.mobskills.calculateDuration(skill:getTP(), 60, 180)

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 1.0, 1.0, 1.0 }
    -- params.str_wSC     = 0.3 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.mnd_wSC     = 0.3 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, duration)
    end

    return info.damage
end

return mobskillObject
