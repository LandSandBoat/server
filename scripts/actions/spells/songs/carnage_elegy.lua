-----------------------------------
-- Spell: Carnage Elegy
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local duration = 180
    local power = 5000

    -- local pCHR = caster:getStat(xi.mod.CHR)
    -- local mCHR = target:getStat(xi.mod.CHR)
    -- local dCHR = pCHR - mCHR
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.CHR
    params.skillType = xi.skill.SINGING
    params.bonus = 0
    params.effect = xi.effect.ELEGY
    local resm = applyResistanceEffect(caster, target, spell, params)

    if resm < 0.5 then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST) -- resist message
    else
        local iBoost = caster:getMod(xi.mod.ELEGY_EFFECT) + caster:getMod(xi.mod.ALL_SONGS_EFFECT)
        power = power + iBoost * 100

        if caster:hasStatusEffect(xi.effect.SOUL_VOICE) then
            power = power * 2
        elseif caster:hasStatusEffect(xi.effect.MARCATO) then
            power = power * 1.5
        end

        caster:delStatusEffect(xi.effect.MARCATO)

        duration = duration * (iBoost * 0.1 + caster:getMod(xi.mod.SONG_DURATION_BONUS) / 100 + 1)

        if caster:hasStatusEffect(xi.effect.TROUBADOUR) then
            duration = duration * 2
        end

        -- Ensure the reduction is capped at 50%
        power = utils.clamp(power, 0, 5000)

        -- Try to overwrite weaker elegy
        if target:addStatusEffect(xi.effect.ELEGY, power, 0, duration) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT) -- no effect
        end
    end

    return xi.effect.ELEGY
end

return spellObject
