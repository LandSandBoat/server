-----------------------------------
-- Trust: Tenzen II
-- Todo: Constantly adjusts his distance for optimal ranged damage (always shot from sweet spot).
-- BIG Todo: make his TP gains per shot match retail at all levels
-- Tenzen II Gets 252 TP per hit at lv 90+ ONLY, see https://www.bg-wiki.com/ffxi/BGWiki:Trusts#Tenzen_II
-- While the changes in TP gain do happen at the levels a SAM would get a storeTP trait adjustment,
-- no combination of STP and wDelay aligns with the TP change in a way that makes all the different amounts
-- make any kind of sense. Some sort of override is seeded to SET his exact TP gain based on a level check.
-- There's just no other way to be retail accurate while having his attack delay match retail.
-- This also means retail unfairly nerfs his TP gains prior to level 90,
-- as other ranged attackers have the amount at level one he doesn't until level 90.
-- I can't help but wonder if he is simply bugged on retail and nobody ever realized it.
-----------------------------------
---@type TSpellTrust
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
        if wsid == 3542 then -- Oisoya
            -- Epehemeral, fleeting, fading. You are but a memory
            xi.trust.message(mobArg, xi.trust.messageOffset.SPECIAL_MOVE_1)
        end
    end)

    -- Ranged Attack as much as possible (limited by 'weapon' delay)
    mob:addGambit(ai.t.TARGET, { ai.c.ALWAYS, 0 }, { ai.r.RATTACK, 0, 0 })

    mob:setAutoAttackEnabled(false)

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
