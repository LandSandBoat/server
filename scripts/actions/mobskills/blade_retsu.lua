-----------------------------------
-- Blade: Retsu
-- Family: Humanoid Katana Weaponskill
-- Description: Delivers a twofold attack that paralyzes target. Duration of paralysis varies with TP.
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
    -- params.str_wSC     = 0.2 -- TODO: Capture if mobskill weaponskills have wSC.
    -- params.dex_wSC     = 0.2 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_2

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        local power = utils.clamp(30 + 3 * (mob:getMainLvl() - target:getMainLvl()), 5, 35)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, power, 0, xi.mobskills.calculateDuration(skill:getTP(), 30, 120))
    end

    return info.damage
end

return mobskillObject
