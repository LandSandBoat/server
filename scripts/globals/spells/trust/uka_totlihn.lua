-----------------------------------
-- Trust: Uka Totlihn
-----------------------------------
require("scripts/globals/trust")
-----------------------------------
local spellObject = {}

local jobs1 = 
{
    xi.job.WHM, 
    xi.job.RDM, 
    xi.job.SCH, 
    xi.job.PLD,
}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    --ADD SYNERGY VARIABLE TO THE MASTER.
    local synergy = caster:getLocalVar("mumorSynergy")
    caster:setLocalVar("mumorSynergy", synergy + 1)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.MUMOR] = xi.trust.message_offset.TEAMWORK_1,
        [xi.magic.spell.ULLEGORE] = xi.trust.message_offset.TEAMWORK_2,
    })

    --LOCALS FOR SYNERGY
    local master = mob:getMaster()
    local synergy = master:getLocalVar("mumorSynergy")

    --DYNAMIC MODIFIER THAT CHECKS VARIABLE ON TICK TO APPLY
    mob:addListener("COMBAT_TICK", "UKA_TOTLIHN_CTICK", function(mob)
        if synergy >= 2 then
            mob:setMod(xi.mod.WALTZ_POTENTCY, 10)
        end
    end)

    --LISTENERS TO SUBTRACT SYNERGY VARIABLE IF ONE OF THE TWO ARE KILLED OR RELEASED
    mob:addListener("DEATH", "UKA_TOTLIHN_DEATH", function(mob, killer)
        master:setLocalVar("mumorSynergy", synergy - 1)
    end)

    mob:addListener("DESPAWN", "UKA_TOTLIHN_DESPAWN", function(mob)
        master:setLocalVar("mumorSynergy", synergy - 1)
    end)

    for i = 1, #jobs1 do
        if (master:getMainJob() == jobs1[i]) then
            mob:addSimpleGambit(ai.t.SELF, ai.c.NO_SAMBA, 0, ai.r.JA, ai.s.SPECIFIC, xi.ja.HASTE_SAMBA)
        end
    end

    --Step Interactions:
    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, xi.effect.LETHARGIC_DAZE_5, ai.r.JA, ai.s.SPECIFIC, xi.ja.QUICKSTEP, 20)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_WS, 0, ai.r.JA, ai.s.SPECIFIC, xi.ja.VIOLENT_FLOURISH)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_MS, 0, ai.r.JA, ai.s.SPECIFIC, xi.ja.VIOLENT_FLOURISH)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_JA, 0, ai.r.JA, ai.s.SPECIFIC, xi.ja.VIOLENT_FLOURISH)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.CASTING_MA, 0, ai.r.JA, ai.s.SPECIFIC, xi.ja.VIOLENT_FLOURISH)

    --ecosystem check to swap to Haste samba if the target is undead.
    mob:addSimpleGambit(ai.t.TARGET, ai.c.IS_ECOSYSTEM, xi.ecosystem.UNDEAD, ai.r.JA, ai.s.SPECIFIC, xi.ja.HASTE_SAMBA)

    --Healing logic:
    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 50, ai.r.JA, ai.s.HIGHEST_WALTZ, xi.ja.CURING_WALTZ)
    mob:addSimpleGambit(ai.t.SELF, ai.c.NO_SAMBA, 0, ai.r.JA, ai.s.BEST_SAMBA, xi.ja.DRAIN_SAMBA)
    mob:addSimpleGambit(ai.t.SELF, ai.c.STATUS_FLAG, xi.effectFlag.WALTZABLE, ai.r.JA, ai.s.SPECIFIC, xi.ja.HEALING_WALTZ)

    --TP use and return.
    mob:addSimpleGambit(ai.t.SELF, ai.c.STATUS, xi.effect.FINISHING_MOVE_5, ai.r.JA, ai.s.SPECIFIC, xi.ja.REVERSE_FLOURISH, 60)
    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.RANDOM, 2000)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spellObject
