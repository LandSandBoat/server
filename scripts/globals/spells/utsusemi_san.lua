-----------------------------------
-- Spell: Utsusemi: San
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local effect = target:getStatusEffect(tpz.effect.COPY_IMAGE)

    -- Get extras shadows
    local numShadows = 5 + target:getMod(tpz.mod.UTSUSEMI_BONUS)

    if (effect == nil or effect:getPower() <= 3) then
        target:addStatusEffectEx(tpz.effect.COPY_IMAGE, tpz.effect.COPY_IMAGE_4, numShadows, 0, 900, 0, numShadows)
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.COPY_IMAGE
end

return spell_object
