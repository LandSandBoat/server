-----------------------------------
-- Spell: Kaustra
-- Consumes 20% of your maximum MP. Relentless
-- dark damage slowly devours an enemy.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local skill = caster:getSkillLevel(xi.skill.DARK_MAGIC)
    local dINT = caster:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)

    if skill > 500 then
        skill = 500
    end

    if dINT > 300 then
        dINT = 300
    end

    local duration = 3 * (1 + (skill / 11))
    local base = math.floor((math.floor(0.67 * caster:getMainLvl()) / 10) * (37 + math.floor(0.67 * dINT)))
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.DARK_MAGIC
    params.bonus = 0
    params.effect = nil
    local resist = applyResistance(caster, target, spell, params)
    local dmg = base * resist
    duration = duration * resist
    dmg = addBonuses(caster, spell, target, dmg)
    dmg = adjustForTarget(target, dmg, spell:getElement())
    dmg = finalMagicAdjustments(caster, target, spell, dmg)

    target:addStatusEffect(xi.effect.KAUSTRA, math.floor(dmg / 3), 3, duration)

    return dmg
end

return spellObject
