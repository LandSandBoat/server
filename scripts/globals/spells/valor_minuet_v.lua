-----------------------------------
-- Spell: Valor Minuet V
-- Grants Attack bonus to all allies.
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local sLvl = caster:getSkillLevel(xi.skill.SINGING) -- Gets skill level of Singing
    local iLvl = caster:getWeaponSkillLevel(xi.slot.RANGED)
    local jpValue = caster:getJobPointLevel(xi.jp.MINUET_EFFECT)

    local power = 32

    if sLvl + iLvl > 500 then
        power = power + math.floor((sLvl + iLvl - 500) / 6)
    end

    if power >= 124 then
        power = 124
    end

    local iBoost = caster:getMod(xi.mod.MINUET_EFFECT) + caster:getMod(xi.mod.ALL_SONGS_EFFECT)
    if iBoost > 0 then
        power = power + iBoost * 12
    end

    power =  power + caster:getMerit(xi.merit.MINUET_EFFECT) + jpValue

    if caster:hasStatusEffect(xi.effect.SOUL_VOICE) then
        power = power * 2
    elseif caster:hasStatusEffect(xi.effect.MARCATO) then
        power = power * 1.5
    end
    caster:delStatusEffect(xi.effect.MARCATO)

    local duration = 120
    duration = duration * ((iBoost * 0.1) + (caster:getMod(xi.mod.SONG_DURATION_BONUS)/100) + 1)

    if caster:hasStatusEffect(xi.effect.TROUBADOUR) then
        duration = duration * 2
    end

    if not target:addBardSong(caster, xi.effect.MINUET, power, 0, duration, caster:getID(), 0, 5) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.MINUET
end

return spell_object
