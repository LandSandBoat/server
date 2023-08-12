-----------------------------------
-- Spell: Anemohelix
-- Deals wind damage that gradually reduces
-- a target's HP. Damage dealt is greatly affected by the weather.
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- get helix acc/att merits
    local merit = caster:getMerit(xi.merit.HELIX_MAGIC_ACC_ATT)

    local params = {}
    params.dmg = 35
    params.multiplier = 1
    params.skillType = xi.skill.ELEMENTAL_MAGIC
    params.attribute = xi.mod.INT
    params.hasMultipleTargetReduction = false
    params.diff = caster:getStat(xi.mod.INT)-target:getStat(xi.mod.INT)
    params.bonus = merit * 3

    -- calculate raw damage
    local dmg = calculateMagicDamage(caster, target, spell, params)
    dmg = dmg + caster:getMod(xi.mod.HELIX_EFFECT)
    -- get resist multiplier (1x if no resist)
    local resist = applyResistance(caster, target, spell, params)
    -- get the resisted damage
    dmg = dmg * resist
    -- add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    dmg = addBonuses(caster, spell, target, dmg, params)
    -- add in target adjustment
    dmg = adjustForTarget(target, dmg, spell:getElement())
    -- helix MAB merits are actually a percentage increase
    dmg = dmg * ((100 + merit * 2) / 100)
    local dot = dmg
    -- add in final adjustments
    dmg = finalMagicAdjustments(caster, target, spell, dmg)
    -- calculate Damage over time
    dot = target:magicDmgTaken(dot, spell:getElement())

    local duration = getHelixDuration(caster) + caster:getMod(xi.mod.HELIX_DURATION)

    duration = duration * (resist / 2)

    if dot > 0 then
        target:addStatusEffect(xi.effect.HELIX, dot, 3, duration)
    end

    return dmg
end

return spellObject
