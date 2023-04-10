-----------------------------------
-- Trust: Naja Salaheem
-----------------------------------
require("scripts/globals/trust")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell, 1008)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.GESSHO] = xi.trust.message_offset.TEAMWORK_1,
        [xi.magic.spell.RONGELOUTS] = xi.trust.message_offset.TEAMWORK_2,
        [xi.magic.spell.ABQUHBAH] = xi.trust.message_offset.TEAMWORK_3,
    })

    mob:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.RANDOM)

    mob:addListener("WEAPONSKILL_USE", "NAJA_WEAPONSKILL_USE", function(mobArg, target, wsid, tp, action)
        if wsid == 3215 then -- Peacebreaker
            --  Cha-ching! Thirty gold coins!
            xi.trust.message(mobArg, xi.trust.message_offset.SPECIAL_MOVE_1)
        end
    end)

    mob:addSimpleGambit(ai.t.SELF, ai.c.ALWAYS, 0,
        ai.r.JA, ai.s.SPECIFIC, xi.ja.FOCUS)

    mob:addSimpleGambit(ai.t.SELF, ai.c.ALWAYS, 0,
        ai.r.JA, ai.s.SPECIFIC, xi.ja.DODGE)

    mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0,
        ai.r.JA, ai.s.SPECIFIC, xi.ja.COUNTERSTANCE)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spellObject
