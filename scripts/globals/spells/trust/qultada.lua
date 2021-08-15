-----------------------------------
-- Trust: Qultada
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/trust")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spell_object.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.SPAWN)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.CORSAIRS_ROLL, ai.r.JA, ai.s.SPECIFIC, xi.ja.CORSAIRS_ROLL)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.CHAOS_ROLL, ai.r.JA, ai.s.SPECIFIC, xi.ja.CHAOS_ROLL)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.ALWAYS, 0, ai.r.RATTACK, 0, 0, 10)

    -- Notable: Uses a balance of melee and ranged attacks.
    -- TODO: Observe his WS behaviour on retail
    mob:setTrustTPSkillSettings(ai.tp.OPENER, ai.s.RANDOM)

    -- Per the December 10, 2015 update:
    -- "The "Enhanced Magic Accuracy" attribute has been added."
    local power = mob:getMainLvl() / 5
    mob:addMod(xi.mod.MACC, power)
end

spell_object.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spell_object.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spell_object
