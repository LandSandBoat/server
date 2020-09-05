-----------------------------------------
-- Spell: Magic Finale
--
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    -- Pull base stats.
    local dCHR = (caster:getStat(tpz.mod.CHR) - target:getStat(tpz.mod.CHR))

    local params = {}

    params.diff = nil

    params.attribute = tpz.mod.CHR

    params.skillType = tpz.skill.SINGING

    params.bonus = caster:getMod(tpz.mod.FINALE_EFFECT) + caster:getMod(tpz.mod.ALL_SONGS_EFFECT)

    params.effect = nil

    local resist = applyResistance(caster, target, spell, params)
    local effect = tpz.effect.NONE

    if (resist > 0.0625) then
        spell:setMsg(tpz.msg.basic.MAGIC_ERASE)
        effect = target:dispelStatusEffect()
        if (effect == tpz.effect.NONE) then
            -- no effect
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    else
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST)
    end

    return effect
end
