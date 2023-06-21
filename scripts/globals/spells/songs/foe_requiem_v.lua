-----------------------------------
-- Spell: Foe Requiem V
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local effect = xi.effect.REQUIEM
    local duration = 127
    local power = 5

    -- local pCHR = caster:getStat(xi.mod.CHR)
    -- local mCHR = target:getStat(xi.mod.CHR)
    -- local dCHR = (pCHR - mCHR)
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.CHR
    params.skillType = xi.skill.SINGING
    params.bonus = 0
    params.effect = nil
    local resm = applyResistance(caster, target, spell, params)
    if resm < 0.5 then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST) -- resist message
        return 1
    end

    local iBoost = caster:getMod(xi.mod.REQUIEM_EFFECT) + caster:getMod(xi.mod.ALL_SONGS_EFFECT)
    power = power + iBoost

    -- JP Bonus
    power = power + caster:getJobPointLevel(xi.jp.REQUIEM_EFFECT) * 3

    if caster:hasStatusEffect(xi.effect.SOUL_VOICE) then
        power = power * 2
    elseif caster:hasStatusEffect(xi.effect.MARCATO) then
        power = power * 1.5
    end

    caster:delStatusEffect(xi.effect.MARCATO)

    duration = duration * ((iBoost * 0.1) + (caster:getMod(xi.mod.SONG_DURATION_BONUS) / 100) + 1)

    if caster:hasStatusEffect(xi.effect.TROUBADOUR) then
        duration = duration * 2
    end

    -- Try to overwrite weaker slow / haste
    if canOverwrite(target, effect, power) then
        -- overwrite them
        target:delStatusEffect(effect)
        target:addStatusEffect(effect, power, 3, duration)
        spell:setMsg(xi.msg.basic.MAGIC_ENFEEB)
    else
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
    end

    return effect
end

return spellObject
