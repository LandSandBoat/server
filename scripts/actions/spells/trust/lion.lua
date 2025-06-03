-----------------------------------
-- Trust: Lion
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell, xi.magic.spell.LION_II)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    -- TODO: Trust Synergy (Aldo/Lion/Zeid)
    -- https://www.bg-wiki.com/ffxi/Cipher:_Lion

    local kGrapeshot = 3198

    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.ZEID] = xi.trust.messageOffset.TEAMWORK_1,
        [xi.magic.spell.ALDO] = xi.trust.messageOffset.TEAMWORK_2,
        [xi.magic.spell.GILGAMESH] = xi.trust.messageOffset.TEAMWORK_3,
    })

    -- Stun all the things!
    mob:addGambit(ai.t.TARGET, { ai.c.READYING_WS, 0 }, { ai.r.WS, ai.s.SPECIFIC, kGrapeshot })
    mob:addGambit(ai.t.TARGET, { ai.c.READYING_MS, 0 }, { ai.r.WS, ai.s.SPECIFIC, kGrapeshot })
    mob:addGambit(ai.t.TARGET, { ai.c.READYING_JA, 0 }, { ai.r.WS, ai.s.SPECIFIC, kGrapeshot })
    mob:addGambit(ai.t.TARGET, { ai.c.CASTING_MA,  0 }, { ai.r.WS, ai.s.SPECIFIC, kGrapeshot })

    mob:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.RANDOM)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
