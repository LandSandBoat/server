-----------------------------------------
-- Spell: Horde Lullaby II
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local duration = 30
    local pCHR = caster:getStat(tpz.mod.CHR)
    local mCHR = target:getStat(tpz.mod.CHR)
    local dCHR = pCHR - mCHR
    local params = {}
    params.diff = nil
    params.attribute = tpz.mod.CHR
    params.skillType = tpz.skill.SINGING
    params.bonus = 0
    params.effect = tpz.effect.LULLABY
    resm = applyResistanceEffect(caster, target, spell, params)

    if resm < 0.5 then
        spell:setMsg(tpz.msg.basic.MAGIC_RESIST) -- resist message
    else
        local iBoost = caster:getMod(tpz.mod.LULLABY_EFFECT) + caster:getMod(tpz.mod.ALL_SONGS_EFFECT)

        duration = duration * (iBoost * 0.1 + caster:getMod(tpz.mod.SONG_DURATION_BONUS) / 100 + 1)

        if caster:hasStatusEffect(tpz.effect.TROUBADOUR) then
            duration = duration * 2
        end

        if target:addStatusEffect(tpz.effect.LULLABY, 1, 0, duration) then
            spell:setMsg(tpz.msg.basic.MAGIC_ENFEEB)
        else
            spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
        end
    end

    return tpz.effect.LULLABY
end
