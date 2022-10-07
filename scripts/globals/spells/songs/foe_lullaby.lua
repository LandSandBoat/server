-----------------------------------
-- Spell: Foe Lullaby
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/jobpoints")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local duration = 30
    -- local pCHR = caster:getStat(xi.mod.CHR)
    -- local mCHR = target:getStat(xi.mod.CHR)
    -- local dCHR = pCHR - mCHR
    local params = {}
    params.diff = nil
    params.attribute = xi.mod.CHR
    params.skillType = xi.skill.SINGING
    params.bonus = 0
    params.effect = xi.effect.LULLABY
    local resm = applyResistanceEffect(caster, target, spell, params)

    if resm < 0.5 then
        spell:setMsg(xi.msg.basic.MAGIC_RESIST) -- resist message
    else
        local iBoost = caster:getMod(xi.mod.LULLABY_EFFECT) + caster:getMod(xi.mod.ALL_SONGS_EFFECT)

        duration = duration * (iBoost * 0.1 + caster:getMod(xi.mod.SONG_DURATION_BONUS) / 100 + 1) + caster:getJobPointLevel(xi.jp.LULLABY_DURATION)

        if caster:hasStatusEffect(xi.effect.TROUBADOUR) then
            duration = duration * 2
        end

        if target:addStatusEffect(xi.effect.LULLABY, 1, 0, duration) then
            spell:setMsg(xi.msg.basic.MAGIC_ENFEEB)
        else
            spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
        end
    end

    return xi.effect.LULLABY
end

return spellObject
