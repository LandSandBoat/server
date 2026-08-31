-----------------------------------
-- Spell: Foe Requiem IV
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local songPlus = caster:getMod(xi.mod.REQUIEM_EFFECT) + caster:getMod(xi.mod.ALL_SONGS_EFFECT)

    local params =
    {
        effectId       = xi.effect.REQUIEM,
        power          = 5 + utils.clamp(songPlus - 1, 0, 6),
        duration       = 112,
        tier           = 4 + songPlus,
        powerBonus     = caster:getJobPointLevel(xi.jp.REQUIEM_EFFECT) * 3,
        magicalElement = xi.element.LIGHT,
        actorStat      = xi.mod.CHR,
        skillType      = xi.skill.SINGING,
        spellGroup     = xi.magic.spellGroup.SONG,
        bonusMacc      = 0,
        songPlus       = songPlus,
        soulVoicePower = true,
        message        = xi.msg.basic.MAGIC_ENFEEB,
        messageBurst   = xi.msg.basic.MAGIC_BURST_ENFEEB,
    }

    return xi.combat.action.executeSpellEnfeeblement(caster, target, spell, params)
end

return spellObject
