-----------------------------------
-- Spell: Repose
-----------------------------------
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    -- local dMND = (caster:getStat(xi.mod.MND) - target:getStat(xi.mod.MND))
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.MND
    params.skillType = xi.skill.DIVINE_MAGIC
    params.bonus = 0
    params.effect = xi.effect.SLEEP_II
    local resist = xi.magic.applyResistanceEffect(caster, target, spell, params)
    if resist < 0.5 then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST) -- Resist
        return xi.effect.SLEEP_II
    end

    if target:addStatusEffect(xi.effect.SLEEP_II, 2, 0, 90 * resist) then
        spell:setMsg(xi.msg.basic.MAGIC_ENFEEB)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- No effect
    end

    return xi.effect.SLEEP_II
end

return spellObject
