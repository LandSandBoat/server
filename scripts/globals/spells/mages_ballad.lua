-----------------------------------------
-- Spell: Mage's Ballad
-- Gradually restores target's MP.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)
    local power = 1

    local iBoost = caster:getMod(tpz.mod.BALLAD_EFFECT) + caster:getMod(tpz.mod.ALL_SONGS_EFFECT)
    power = power + iBoost

    if (caster:hasStatusEffect(tpz.effect.SOUL_VOICE)) then
        power = power * 2
    elseif (caster:hasStatusEffect(tpz.effect.MARCATO)) then
        power = power * 1.5
    end
    caster:delStatusEffect(tpz.effect.MARCATO)

    local duration = 120
    duration = duration * ((iBoost * 0.1) + (caster:getMod(tpz.mod.SONG_DURATION_BONUS)/100) + 1)

    if (caster:hasStatusEffect(tpz.effect.TROUBADOUR)) then
        duration = duration * 2
    end

    if not (target:addBardSong(caster, tpz.effect.BALLAD, power, 0, duration, caster:getID(), 0, 1)) then
        spell:setMsg(tpz.msg.basic.MAGIC_NO_EFFECT)
    end

    return tpz.effect.BALLAD
end
