-----------------------------------
-- Spell: Carcharian Verve
-- Enhances attack and magic attack. Reduces spell interruption rate.
-- Spell Type: Magical (Water)
-- Casting Time: 1 seconds
-- Recast Time: 60 seconds
-----------------------------------
-- Combos: None
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local atk_bonus = xi.effect.ATTACK_BOOST
    local matk_bonus = xi.effect.MAGIC_ATK_BOOST
    local aquaveil = xi.effect.AQUAVEIL
    local power = 20
    local duration = 60
    local aquaveil_duration = 1800

    if (caster:hasStatusEffect(xi.effect.DIFFUSION)) then
        local diffMerit = caster:getMerit(xi.merit.DIFFUSION)

        if (diffMerit > 0) then
            duration = duration + (duration/100) * diffMerit
        end

        caster:delStatusEffect(xi.effect.DIFFUSION)
    end

    target:addStatusEffect(atk_bonus, power, 3, duration)
    target:addStatusEffect(matk_bonus, power, 3, duration)
    target:addStatusEffect(aquaveil, 10, 3, aquaveil_duration)

    return aquaveil
end

return spell_object
