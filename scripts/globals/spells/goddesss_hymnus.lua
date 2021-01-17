-----------------------------------
-- Spell: Goddess's Hymnus
-- Grants Reraise.
-----------------------------------
local spell_object = {}

require("scripts/globals/status")

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)

        local duration = 120

        duration = duration * (caster:getMod(tpz.mod.SONG_DURATION_BONUS)/100)

        target:addBardSong(caster, tpz.effect.HYMNUS, 1, 0, duration, caster:getID(), 0, 1)

    return tpz.effect.HYMNUS
end

return spell_object
