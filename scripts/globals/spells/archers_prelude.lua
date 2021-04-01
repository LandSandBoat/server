-----------------------------------
-- Spell: Archer's Prelude
-- Enhances ranged attack for party members within area of effect.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local sLvl = caster:getSkillLevel(xi.skill.SINGING) -- Gets skill level of Singing
    local iLvl = caster:getWeaponSkillLevel(xi.slot.RANGED)

    local power = 20

    if sLvl+iLvl > 130 then
        power = power + math.floor((sLvl+iLvl - 130) / 18)
    end

    if power > 60 then
        power = 60
    end

    local iBoost = caster:getMod(xi.mod.PRELUDE_EFFECT) + caster:getMod(xi.mod.ALL_SONGS_EFFECT)
    if (iBoost > 0) then
        power = power + iBoost*6
    end


    if caster:hasStatusEffect(xi.effect.SOUL_VOICE) then
        power = power * 2
    elseif caster:hasStatusEffect(xi.effect.MARCATO) then
        power = power * 1.5
    end
    caster:delStatusEffect(xi.effect.MARCATO)

    local duration = 120
    duration = duration * ((iBoost * 0.1) + (caster:getMod(xi.mod.SONG_DURATION_BONUS) / 100) + 1)

    if caster:hasStatusEffect(xi.effect.TROUBADOUR) then
        duration = duration * 2
    end

    if not target:addBardSong(caster, xi.effect.PRELUDE, power, 0, duration, caster:getID(), 0, 2) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.PRELUDE
end

return spell_object
