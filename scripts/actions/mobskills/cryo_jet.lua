-----------------------------------
-- Cryo Jet
-- Family: Ultima
-- Description: Deals Ice breath damage to targets in front of mob. Additional Effect: Paralysis
--  additional effect : Paralyze
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill, action)
    local params = {}

    params.percentMultipier  = 0.05 -- TODO: Capture HP multiplier/threshhold.
    params.element           = xi.element.ICE
    params.damageCap         = 490
    params.bonusDamage       = 0
    params.mAccuracyBonus    = { 0, 0, 0 }
    params.resistStat        = xi.mod.INT
    params.resistStat        = xi.mod.INT

    local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 15, 3, 120)

        if target:hasStatusEffect(xi.effect.ELEMENTALRES_DOWN) then
            target:delStatusEffectSilent(xi.effect.ELEMENTALRES_DOWN)
        end
    end

    mob:setLocalVar('nuclearWaste', 0) -- TODO: Migrate logic to mob script.

    return info.damage
end

return mobskillObject
