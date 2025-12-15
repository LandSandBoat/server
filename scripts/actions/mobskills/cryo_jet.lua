-----------------------------------
--  Cryo_Jet
--  Description:
--  Type: Magical
--  additional effect : Paralyze
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local params = {}

    params.percentMultipier  = 0.05
    params.element           = xi.element.ICE
    params.damageCap         = 490
    params.bonusDamage       = 0
    params.mAccuracyBonus    = { 0, 0, 0 }
    params.resistStat        = xi.mod.INT

    local damage = xi.mobskills.mobBreathMove(mob, target, skill, params)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.BREATH, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS, 1)

    if not xi.mobskills.hasMissMessage(mob, target, skill, damage) then
        target:takeDamage(damage, mob, xi.attackType.BREATH, xi.damageType.ICE)
    end

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.PARALYSIS, 15, 3, 120)

    if target:hasStatusEffect(xi.effect.ELEMENTALRES_DOWN) then
        target:delStatusEffectSilent(xi.effect.ELEMENTALRES_DOWN)
    end

    mob:setLocalVar('nuclearWaste', 0)

    return damage
end

return mobskillObject
