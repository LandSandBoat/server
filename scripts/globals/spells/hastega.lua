-----------------------------------
-- Spell: Haste
-- Composure increases duration 3x
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local duration = 180

    if caster:hasStatusEffect(xi.effect.COMPOSURE) and caster:getID() == target:getID() then
       duration = duration * 3
    end

    local power = 1465 -- 150/1024 ~14.65%

    if not target:addStatusEffect(xi.effect.HASTE, power, 0, duration) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.HASTE
end

return spell_object
