-----------------------------------
-- Stardiver
-- Family: Humanoid Polearm Weaponskill
-- Description: Delivers a fourfold attack. Damage varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits           = 4
    params.fTP               = { 0.75, 1.25, 1.75 }
    params.fTPSubsequentHits = { 0.75, 1.25, 1.75 }
    -- params.str_wSC        = 0.85 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.PIERCING
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_4

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CRIT_HIT_EVASION_DOWN, 5, 0, 60)
    end

    return info.damage
end

return mobskillObject
