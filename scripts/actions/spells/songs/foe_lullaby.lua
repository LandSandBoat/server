-----------------------------------
-- Spell: Foe Lullaby
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params     = {}
    params.diff      = nil
    params.attribute = xi.mod.CHR
    params.skillType = xi.skill.SINGING
    params.bonus     = 0
    params.effect    = xi.effect.SLEEP_I

    local resm     = applyResistanceEffect(caster, target, spell, params)
    local duration = 30

    if resm < 0.5 then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST) -- resist message
    else
        local iBoost = caster:getMod(xi.mod.LULLABY_EFFECT) + caster:getMod(xi.mod.ALL_SONGS_EFFECT)

        duration = duration * (iBoost * 0.1 + caster:getMod(xi.mod.SONG_DURATION_BONUS) / 100 + 1) + caster:getJobPointLevel(xi.jp.LULLABY_DURATION)

        if caster:hasStatusEffect(xi.effect.TROUBADOUR) then
            duration = duration * 2
        end

        if target:addStatusEffect(xi.effect.SLEEP_I, 1, 0, duration) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB_IS)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    end

    return xi.effect.SLEEP_I
end

return spellObject
