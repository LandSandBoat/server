-----------------------------------
-- Trust: Tenzen II
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell, xi.magic.spell.TENZEN)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.PRISHE] = xi.trust.messageOffset.TEAMWORK_1,
    })

    mob:addListener('WEAPONSKILL_USE', 'TENZEN_II_WEAPONSKILL_USE', function(mobArg, target, wsid, tp, action)
        if wsid == 1397 then -- Oisoya
            -- Epehemeral, fleeting, fading. You are but a memory
            xi.trust.message(mobArg, xi.trust.messageOffset.SPECIAL_MOVE_1)
        end
    end)

    -- Ranged Attack as much as possible (limited by 'weapon' delay)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.ALWAYS, 0, ai.r.RATTACK, 0, 0)

    mob:setAutoAttackEnabled(false)

    -- Gets 250 TP per hit
    mob:addMod(xi.mod.STORETP, 210)

    mob:setMobMod(xi.mobMod.TRUST_DISTANCE, xi.trust.movementType.LONG_RANGE)

    mob:setTrustTPSkillSettings(ai.tp.OPENER, ai.s.HIGHEST)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
