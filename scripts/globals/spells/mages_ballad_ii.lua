-----------------------------------
-- Spell: Mage's Ballad II
-- Gradually restores target's MP.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local power = 2

    local iBoost = caster:getMod(xi.mod.BALLAD_EFFECT) + caster:getMod(xi.mod.ALL_SONGS_EFFECT)
    power = power + iBoost

    if (caster:hasStatusEffect(xi.effect.SOUL_VOICE)) then
        power = power * 2
    elseif (caster:hasStatusEffect(xi.effect.MARCATO)) then
        power = power * 1.5
    end
    caster:delStatusEffect(xi.effect.MARCATO)

    local duration = 120
    duration = duration * ((iBoost * 0.1) + (caster:getMod(xi.mod.SONG_DURATION_BONUS)/100) + 1)

    if (caster:hasStatusEffect(xi.effect.TROUBADOUR)) then
        duration = duration * 2
    end

    if not (target:addBardSong(caster, xi.effect.BALLAD, power, 0, duration, caster:getID(), 0, 2)) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.BALLAD
end

return spell_object
