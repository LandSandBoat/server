-----------------------------------
-- Trust: Mumor
-----------------------------------
---@type TSpellTrust
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
    return xi.trust.canCast(caster, spell, xi.magic.spell.MUMOR_II)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.UKA_TOTLIHN] = xi.trust.messageOffset.TEAMWORK_1,
        [xi.magic.spell.ULLEGORE   ] = xi.trust.messageOffset.TEAMWORK_2,
    })

    -- Dynamic modifier that checks party member list on tick to apply
    mob:addListener('COMBAT_TICK', 'MUMOR_CTICK', function(mobArg)
        local sambaDurationBoost = 0
        local party = mobArg:getMaster():getPartyWithTrusts()
        for _, member in pairs(party) do
            if member:getObjType() == xi.objType.TRUST then
                if
                    member:getTrustID() == xi.magic.spell.UKA_TOTLIHN
                then
                    sambaDurationBoost = 10
                end
            end
        end

        -- Always set the boost, even if Uka wasn't found.
        -- This accounts for her being in the party and giving the boost
        -- and also if she dies and the boost goes away.
        mobArg:setMod(xi.mod.SAMBA_DURATION, sambaDurationBoost)
    end)

    -- Sets stance
    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.SABER_DANCE }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SABER_DANCE })

    -- Step usage: -DEF debuff and stuns
    mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS, xi.effect.WEAKENED_DAZE_5 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.STUTTER_STEP })
    mob:addGambit(ai.t.TARGET, { ai.c.READYING_WS, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.VIOLENT_FLOURISH })
    mob:addGambit(ai.t.TARGET, { ai.c.READYING_MS, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.VIOLENT_FLOURISH })
    mob:addGambit(ai.t.TARGET, { ai.c.READYING_JA, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.VIOLENT_FLOURISH })
    mob:addGambit(ai.t.TARGET, { ai.c.CASTING_MA, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.VIOLENT_FLOURISH })

    -- Samba logic
    -- Checks masters job, adjusts samba type if master has a healer main job.
    for i = 1, #healingJobs do
        local master  = mob:getMaster()
        if
            master and
            master:getMainJob() == healingJobs[i]
        then
            mob:addGambit(ai.t.SELF, { ai.c.NO_SAMBA, ai.r.JA }, { 0, ai.s.SPECIFIC, xi.ja.HASTE_SAMBA })
        end
    end

    -- Adds ecosystem to adjust samba to haste if target is undead
    mob:addGambit(ai.t.TARGET, { ai.c.IS_ECOSYSTEM, xi.ecosystem.UNDEAD }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.HASTE_SAMBA })
    -- Else picks highest drain spell available
    mob:addGambit(ai.t.SELF, { ai.c.NO_SAMBA, 0 }, { ai.r.JA, ai.s.BEST_SAMBA, xi.ja.DRAIN_SAMBA })
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
