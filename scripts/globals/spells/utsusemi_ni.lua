-----------------------------------
-- Spell: Utsusemi: Ni
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    if target:hasStatusEffect(xi.effect.THIRD_EYE) then
        -- Third Eye and Utsusemi don't stack. Utsusemi removes Third Eye.
        target:delStatusEffect(xi.effect.THIRD_EYE)
    end

    local effect = target:getStatusEffect(xi.effect.COPY_IMAGE)

    -- Get extras shadows
    local numShadows = 3
    local icon = xi.effect.COPY_IMAGE_3

    if caster:getMainJob() == xi.job.NIN then
        numShadows = 4 + target:getMod(xi.mod.UTSUSEMI_BONUS)
        icon = xi.effect.COPY_IMAGE_4
    end

    if effect == nil or effect:getPower() <= 2 then
        target:addStatusEffectEx(xi.effect.COPY_IMAGE, icon, 2, 0, 900, 0, numShadows)
        spell:setMsg(xi.msg.basic.MAGIC_GAIN_EFFECT)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.COPY_IMAGE
end

return spell_object
