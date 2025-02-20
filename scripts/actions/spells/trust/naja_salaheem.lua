-----------------------------------
-- Trust: Naja Salaheem
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell, xi.magic.spell.NAJA_UC)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.GESSHO] = xi.trust.messageOffset.TEAMWORK_1,
        [xi.magic.spell.RONGELOUTS] = xi.trust.messageOffset.TEAMWORK_2,
        [xi.magic.spell.ABQUHBAH] = xi.trust.messageOffset.TEAMWORK_3,
    })

    mob:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.RANDOM)

    mob:addListener('WEAPONSKILL_USE', 'NAJA_WEAPONSKILL_USE', function(mobArg, target, wsid, tp, action)
        if wsid == 3215 then -- Peacebreaker
            --  Cha-ching! Thirty gold coins!
            xi.trust.message(mobArg, xi.trust.messageOffset.SPECIAL_MOVE_1)
        end
    end)

    mob:addGambit(ai.t.SELF, { ai.c.ALWAYS, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.FOCUS })

    mob:addGambit(ai.t.SELF, { ai.c.ALWAYS, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.DODGE })

    mob:addGambit(ai.t.SELF, { ai.c.HAS_TOP_ENMITY, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.COUNTERSTANCE })
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
