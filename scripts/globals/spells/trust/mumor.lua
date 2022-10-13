-----------------------------------
-- Trust: Mumor
-----------------------------------
require("scripts/globals/trust")
-----------------------------------------
local spellObject = {}

local jobs1 = 
{
    xi.job.WHM, 
    xi.job.RDM, 
    xi.job.SCH, 
    xi.job.PLD,
}

spellObject.onMagicCastingCheck = function(caster, target, spell)
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
        [xi.magic.spell.UKA_TOTLIHN] = xi.trust.message_offset.TEAMWORK_1,
        [xi.magic.spell.ULLEGORE] = xi.trust.message_offset.TEAMWORK_2,
    })

    --LOCALS FOR SYNERGY
    local master = mob:getMaster()
    local synergy = master:getLocalVar("mumorSynergy")

    --DYNAMIC MODIFIER THAT CHECKS VARIABLE ON TICK TO APPLY
    mob:addListener("COMBAT_TICK", "MUMOR_CTICK", function(mob)
        if synergy >= 2 then
            mob:setMod(xi.mod.SAMBA_DURATION, 10)
        end
    end)

    --LISTENERS TO SUBTRACT SYNERGY VARIABLE IF ONE OF THE TWO ARE KILLED OR RELEASED
    mob:addListener("DEATH", "MUMOR_DEATH", function(mob, killer)
        master:setLocalVar("mumorSynergy", synergy - 1)
    end)

    mob:addListener("DESPAWN", "MUMOR_DESPAWN", function(mob)
        master:setLocalVar("mumorSynergy", synergy - 1)
    end)

    --SETS STANCE
    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.SABER_DANCE, ai.r.JA, ai.s.SPECIFIC, xi.ja.SABER_DANCE)

    --STEP USAGE: -DEF DEBUFF AND STUNS
    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, xi.effect.WEAKENED_DAZE_5, ai.r.JA, ai.s.SPECIFIC, xi.ja.STUTTER_STEP)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_WS, 0, ai.r.JA, ai.s.SPECIFIC, xi.ja.VIOLENT_FLOURISH)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_MS, 0, ai.r.JA, ai.s.SPECIFIC, xi.ja.VIOLENT_FLOURISH)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_JA, 0, ai.r.JA, ai.s.SPECIFIC, xi.ja.VIOLENT_FLOURISH)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.CASTING_MA, 0, ai.r.JA, ai.s.SPECIFIC, xi.ja.VIOLENT_FLOURISH)

    --SAMBA LOGIC
    --CHECKS MASTERS JOB : ADJUSTS SAMBA TYPE IF MASTER HAS HEALER MAIN.
    for i = 1, #jobs1 do
        if (master:getMainJob() == jobs1[i]) then
            mob:addSimpleGambit(ai.t.SELF, ai.c.NO_SAMBA, ai.r.JA, ai.s.SPECIFIC, xi.ja.HASTE_SAMBA)
        end
    end
    --ADDS ECOSYSTEM TO ADJUST SAMBA TO HASTE IF TARGET IS UNDEAD
    mob:addSimpleGambit(ai.t.TARGET, ai.c.IS_ECOSYSTEM, xi.ecosystem.UNDEAD, ai.r.JA, ai.s.SPECIFIC, xi.ja.HASTE_SAMBA)
    --ELSE PICKS HIGHEST DRAIN SPELL AVAILABLE
    mob:addSimpleGambit(ai.t.SELF, ai.c.NO_SAMBA, 0, ai.r.JA, ai.s.BEST_SAMBA, xi.ja.DRAIN_SAMBA)

end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spellObject
