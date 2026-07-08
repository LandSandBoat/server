-----------------------------------
-- Viper Bite
-- Family: Humanoid Dagger Weaponskill
-- Description: Strikes with twice the attack power. Poisons target. Duration of effect varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage       = mob:getWeaponDmg()
    params.numHits          = 1
    params.fTP              = { 1.0, 1.0, 1.0 }
    params.attackMultiplier = { 2.0, 2.0, 2.0 }
    -- params.dex_wSC       = 1.0 -- TODO: Capture if mobskill weaponskills have wSC.
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.PIERCING
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 3, 3, math.floor(30 + 6 * skill:getTP() / 100))
    end

    return info.damage
end

return mobskillObject
