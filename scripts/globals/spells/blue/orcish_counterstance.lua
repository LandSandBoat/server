-----------------------------------
-- Spell: O. Counterstance
-- Increases the caster's chance of countering.
-- Spell cost: 18 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Fire)
-- Blue Magic Points: 5
-- Stat Bonus: HP+10 STR+3 VIT+3 DEX-2 AGI-2
-- Level: 98
-- Casting Time: 4.5 seconds
-- Recast Time: 120 seconds
-- Duration: 180 seconds
-----------------------------------
-- Combos: None
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local typeEffect = xi.effect.COUNTERSTANCE
    local power = 10 -- Percentage, not amount.
    local duration = 180

    if (caster:hasStatusEffect(xi.effect.DIFFUSION)) then
        local diffMerit = caster:getMerit(xi.merit.DIFFUSION)

        if (diffMerit > 0) then
            duration = duration + (duration/100)* diffMerit
        end

        caster:delStatusEffect(xi.effect.DIFFUSION)
    end

    if (target:addStatusEffect(typeEffect, power, 0, duration) == false) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return typeEffect
end

return spell_object
