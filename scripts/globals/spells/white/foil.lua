-----------------------------------
-- Spell: Foil
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

-- TODO: determine mechanics of how Foil's "Special Attack" evasion works.
-- Martel has a post about it here: https://www.bluegartr.com/threads/115399-Rune-Fencer-Findings?p=5665305&viewfull=1#post5665305
-- More testing is required (such as determining accuracy of the target used for testing)
spell_object.onSpellCast = function(caster, target, spell)

    if target:addStatusEffect(xi.effect.FOIL, 0, 0, 30) then -- power set to 0 because true mechanics are unknown as of now. The primary use of Foil is for enmity anyway.
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.FOIL
end

return spell_object
