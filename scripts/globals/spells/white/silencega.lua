-----------------------------------
-- Spell: Silence
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local effectType = xi.effect.SILENCE

    if target:hasStatusEffect(effectType) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
        return effectType
    end

    --Pull base stats.
    -- local dMND = (caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND))

    --Duration, including resistance.  May need more research.
    local duration = 120

    --Resist
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.MND
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = 0
    params.effect = xi.effect.SILENCE
    local resist = xi.magic.applyResistanceEffect(caster, target, spell, params)

    if resist >= 0.5 then --Do it!
        local resduration = duration * resist

        resduration = xi.magic.calculateBuildDuration(target, resduration, params.effect, caster)

        if target:addStatusEffect(effectType, 1, 0, resduration) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
            -- only increment the resbuild if successful (not on a no effect)
            xi.magic.incrementBuildDuration(target, params.effect, caster)
            xi.magic.handleBurstMsg(caster, target, spell)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return effectType
end

return spellObject
