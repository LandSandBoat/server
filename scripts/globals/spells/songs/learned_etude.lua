-----------------------------------
-- Spell: Learned Etude
-- Static INT Boost, BRD 26
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spell_object.onSpellCast = function(caster, target, spell)
    local sLvl = caster:getSkillLevel(xi.skill.SINGING) -- Gets skill level of Singing
    local iLvl = caster:getWeaponSkillLevel(xi.slot.RANGED)

    local power = 0

    if (sLvl+iLvl <= 181) then
        power = 3
    elseif ((sLvl+iLvl >= 182) and (sLvl+iLvl <= 235)) then
        power = 4
    elseif ((sLvl+iLvl >= 236) and (sLvl+iLvl <= 288)) then
        power = 5
    elseif ((sLvl+iLvl >= 289) and (sLvl+iLvl <= 342)) then
        power = 6
    elseif ((sLvl+iLvl >= 343) and (sLvl+iLvl <= 396)) then
        power = 7
    elseif ((sLvl+iLvl >= 397) and (sLvl+iLvl <= 449)) then
        power = 8
    elseif (sLvl+iLvl >= 450) then
        power = 9
    end

    local iBoost = caster:getMod(xi.mod.ETUDE_EFFECT) + caster:getMod(xi.mod.ALL_SONGS_EFFECT)
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

    if not (target:addBardSong(caster, xi.effect.ETUDE, power, 0, duration, caster:getID(), xi.mod.INT, 1)) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.ETUDE
end

return spell_object
