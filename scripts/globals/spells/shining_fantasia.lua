-----------------------------------
-- Spell: Shining Fantasia
-- Enhances resistance against blind for party members within the area of effect.
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

    local power = 20

    if (sLvl+iLvl > 200) then
        power = power + math.floor((sLvl+iLvl-200) / 10)
    end

    if (power >= 80) then
        power = 80
    end

    local iBoost = caster:getMod(xi.mod.ALL_SONGS_EFFECT) 
    power = power + iBoost*8

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

    if not (target:addBardSong(caster, xi.effect.FANTASIA, power, 0, duration, caster:getID(), 0, 1)) then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    return xi.effect.FANTASIA
end

return spell_object
