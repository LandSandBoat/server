-----------------------------------
-- Spell: Doom
-- Gives you 30 seconds to live.
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local effect = xi.effect.DOOM
    if not target:hasStatusEffect(effect) then
        spell:setMsg(xi.msg.basic.MAGIC_ENFEEB) -- gains effect
        target:addStatusEffect(effect, 10, 3, 30)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
    end

    return effect
end

return spellObject
