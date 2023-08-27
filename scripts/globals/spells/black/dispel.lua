-----------------------------------
-- Spell: Dispel
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    if target:hasImmunity(xi.immunity.DISPEL) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return
    end

    local params = {}
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.ENFEEBLING_MAGIC
    params.bonus = 175

    local resist = xi.magic.applyResistance(caster, target, spell, params)
    local effect = xi.effect.NONE

    if resist > 0.0625 then
        spell:setMsg(xi.msg.basic.MAGIC_ERASE)
        effect = target:dispelStatusEffect()
        if effect == xi.effect.NONE then
            -- no effect
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    if target:hasImmunity(xi.immunity.DISPEL) then --dispel immunity enum needed as core immunity only looks at effects and not spell land
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        return 0
    end

    return effect
end

return spellObject
