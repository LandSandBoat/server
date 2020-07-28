-----------------------------------------
-- Spell: Utsusemi: Ichi
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local effect = target:getStatusEffect(tpz.effect.COPY_IMAGE)

    -- Get extras shadows
    local numShadows = 3 + target:getMod(tpz.mod.UTSUSEMI_BONUS)
    local icon = tpz.effect.COPY_IMAGE_3
    if (numShadows > 3) then
        icon = tpz.effect.COPY_IMAGE_4
    end

    if (effect == nil or effect:getPower() <= 1) then
        target:addStatusEffectEx(tpz.effect.COPY_IMAGE, icon, 1, 0, 900, 0, numShadows)
        spell:setMsg(tpz.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.COPY_IMAGE
end
