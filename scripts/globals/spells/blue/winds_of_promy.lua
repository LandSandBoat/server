-----------------------------------
-- Spell: Winds of Promy.
-- Removes one detrimental magic effect for party members within area of effect.
-- Spell cost: 36 MP
-- Monster Type: Empty
-- Spell Type: Magical (Light)
-- Blue Magic Points: 5
-- Stat Bonus: MND+3 CHR-2
-- Level: 89
-- Casting Time: 3 seconds
-- Recast Time: 20 seconds
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local effect = target:eraseStatusEffect()

    if (effect == xi.effect.NONE) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
    else
        spell:setMsg(xi.msg.basic.MAGIC_ERASE)
    end

    return effect
end

return spell_object
