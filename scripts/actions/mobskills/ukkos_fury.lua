-----------------------------------
-- Ukko's Fury
-- Family: Humanoid Great Axe Weaponskill
-- Description: Delivers a twofold attack that slows target. Chance of critical hit varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage        = mob:getWeaponDmg()
    params.numHits           = 2
    params.fTP               = { 2.0, 2.0, 2.0 }
    -- params.str_wSC        = 0.6 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.SLASHING
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_2
    params.canCrit           = true
    params.criticalChance    = { 0.2, 0.35, 0.55 }

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1500, 0, 60)
    end

    return info.damage
end

return mobskillObject
