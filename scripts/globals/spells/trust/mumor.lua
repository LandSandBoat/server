-----------------------------------
-- Trust: Mumor
-----------------------------------
require("scripts/globals/trust")
-----------------------------------
local spellObject = {}

-- Define the main jobs with access to primary healing used to toggle Samba type
local healingJobs =
{
    xi.job.WHM,
    xi.job.RDM,
    xi.job.SCH,
    xi.job.PLD,
}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell, 1015)
end

spellObject.onSpellCast = function(caster, target, spell)
    -- Add synergy variable to the master.
    local synergy = caster:getLocalVar("mumorSynergy")

    caster:setLocalVar("mumorSynergy", synergy + 1)

    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.UKA_TOTLIHN] = xi.trust.message_offset.TEAMWORK_1,
        [xi.magic.spell.ULLEGORE   ] = xi.trust.message_offset.TEAMWORK_2,
    })

    -- Dynamic modifier that checks variable on tick to apply
    mob:addListener("COMBAT_TICK", "MUMOR_CTICK", function(mobArg)
        -- Locals for synergy
        local master  = mob:getMaster()
        local synergy = master:getLocalVar("mumorSynergy")
        if synergy >= 2 then
            mob:setMod(xi.mod.SAMBA_DURATION, 10)
        end
    end)

    -- Listeners to subtract synergy variable if one of the two are killed or released
    -- Todo: rework synergy check for dynamic adjustments on tick
    -- Todo: update gambit container to allow to toggling behaviors with synergy
    mob:addListener("DEATH", "MUMOR_DEATH", function(mobArg, killer)
        local master  = mob:getMaster()
        local synergy = master:getLocalVar("mumorSynergy")
        master:setLocalVar("mumorSynergy", synergy - 1)
    end)

    mob:addListener("DESPAWN", "MUMOR_DESPAWN", function(mobArg)
        local master  = mob:getMaster()
        local synergy = master:getLocalVar("mumorSynergy")
        master:setLocalVar("mumorSynergy", synergy - 1)
    end)

    -- Sets stance
    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.SABER_DANCE, ai.r.JA, ai.s.SPECIFIC, xi.ja.SABER_DANCE)

    -- Step usage: -DEF debuff and stuns
    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, xi.effect.WEAKENED_DAZE_5, ai.r.JA, ai.s.SPECIFIC, xi.ja.STUTTER_STEP)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_WS, 0, ai.r.JA, ai.s.SPECIFIC, xi.ja.VIOLENT_FLOURISH)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_MS, 0, ai.r.JA, ai.s.SPECIFIC, xi.ja.VIOLENT_FLOURISH)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_JA, 0, ai.r.JA, ai.s.SPECIFIC, xi.ja.VIOLENT_FLOURISH)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.CASTING_MA, 0, ai.r.JA, ai.s.SPECIFIC, xi.ja.VIOLENT_FLOURISH)

    -- Samba logic
    -- Checks masters job, adjusts samba type if master has a healer main job.
    for i = 1, #healingJobs do
        local master  = mob:getMaster()
        if master:getMainJob() == healingJobs[i] then
            mob:addSimpleGambit(ai.t.SELF, ai.c.NO_SAMBA, ai.r.JA, ai.s.SPECIFIC, xi.ja.HASTE_SAMBA)
        end
    end

    -- Adds ecosystem to adjust samba to haste if target is undead
    mob:addSimpleGambit(ai.t.TARGET, ai.c.IS_ECOSYSTEM, xi.ecosystem.UNDEAD, ai.r.JA, ai.s.SPECIFIC, xi.ja.HASTE_SAMBA)
    -- Else picks highest drain spell available
    mob:addSimpleGambit(ai.t.SELF, ai.c.NO_SAMBA, 0, ai.r.JA, ai.s.BEST_SAMBA, xi.ja.DRAIN_SAMBA)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spellObject
