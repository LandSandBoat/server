-----------------------------------------
-- Spell: Raptor Mazurka
-- Gives party members enhanced movement
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local power = 12

    local iBoost = caster:getMod(tpz.mod.MAZURKA_EFFECT) + caster:getMod(tpz.mod.ALL_SONGS_EFFECT)

    local duration = 120

    duration = duration * ((iBoost * 0.1) + (caster:getMod(tpz.mod.SONG_DURATION_BONUS)/100) + 1)

    if (caster:hasStatusEffect(tpz.effect.SOUL_VOICE)) then
        duration = duration * 2
    elseif (caster:hasStatusEffect(tpz.effect.MARCATO)) then
        duration = duration * 1.5
    end
    caster:delStatusEffect(tpz.effect.MARCATO)

    if (caster:hasStatusEffect(tpz.effect.TROUBADOUR)) then
        duration = duration * 2
    end

    if not (target:addBardSong(caster, tpz.effect.MAZURKA, power, 0, duration, caster:getID(), 0, 1)) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.MAZURKA
end

