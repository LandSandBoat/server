-----------------------------------
-- Spell: MP Drainkiss
-- Steals an enemy's MP. Ineffective against undead
-- Spell cost: 20 MP
-- Monster Type: Amorphs
-- Spell Type: Magical (Dark)
-- Blue Magic Points: 4
-- Stat Bonus: MP+5
-- Level: 42
-- Casting Time: 4 seconds
-- Recast Time: 90 seconds
-- Magic Bursts on: Compression, Gravitation, Darkness
-- Combos: None
-- Notes:
-- Affected by Blue Magic Skill and Magic Accuracy.
-- Soft cap at 165MP before Magic Bursts / Day and Weather/Elemental Affinity effects.
-- Elemental Affinity and Elemental Obis affect both accuracy and amount of MP drained.
-- Magic Burst affects both accuracy and amount of MP drained.
-- INT increases Magic Accuracy in general, but is not a modifier of this spell.
-- Unlike Magic Hammer, MP drained is not enhanced by Magic Attack Bonus.
-- A positive Monster Correlation (vs Birds) or a negative Monster Correlation (vs Aquans), affects both accuracy and potency.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.AMORPH
    params.attackType = xi.attackType.MAGICAL
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.bonus = 1.0

    local dmg = utils.clamp(5 + 0.375 * caster:getSkillLevel(xi.skill.BLUE_MAGIC), 0, 165)
    local resist = applyResistance(caster, target, spell, params)
    dmg = dmg * resist
    dmg = addBonuses(caster, spell, target, dmg)
    dmg = adjustForTarget(target, dmg, spell:getElement())

    if dmg < 0 then dmg = 0 end

    dmg = dmg * xi.settings.main.BLUE_POWER

    if target:isUndead() then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- No effect
        return dmg
    end

    if target:getMP() > dmg then
        caster:addMP(dmg)
        target:delMP(dmg)
    else
        dmg = target:getMP()
        caster:addMP(dmg)
        target:delMP(dmg)
    end

    return dmg
end

return spellObject
