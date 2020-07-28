-----------------------------------------
-- Spell: Goddess's Hymnus
-- Grants Reraise.
-----------------------------------------

require("scripts/globals/status")

function onMagicCastingCheck(caster, target, spell)
    return 0
end

function onSpellCast(caster, target, spell)

        local duration = 120

        duration = duration * (caster:getMod(tpz.mod.SONG_DURATION_BONUS)/100)

        target:addBardSong(caster, tpz.effect.HYMNUS, 1, 0, duration, caster:getID(), 0, 1)

    return tpz.effect.HYMNUS
end
