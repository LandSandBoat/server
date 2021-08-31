-----------------------------------
-- Spell: Death
-- Consumes all MP. Has a chance to knock out the target. If Death fails to knock out the target, it
-- will instead deal darkness damage. Ineffective against undead.
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    spell:setFlag(xi.magic.spellFlag.IGNORE_SHADOWS)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    if target:isUndead() or target:hasStatusEffect(xi.effect.MAGIC_SHIELD) or math.random(0, 99) < target:getMod(xi.mod.DEATHRES) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return 0
    end

    target:setHP(0)
    return 0
end

return spell_object
