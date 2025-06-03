-----------------------------------
-- Trust: Prishe II
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell, xi.magic.spell.PRISHE)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    local psychoAnima  = 3539

    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.TENZEN_II] = xi.trust.messageOffset.TEAMWORK_1,
        [xi.magic.spell.NASHMEIRA_II] = xi.trust.messageOffset.TEAMWORK_2,
        [xi.magic.spell.LILISETTE_II] = xi.trust.messageOffset.TEAMWORK_3,
        [xi.magic.spell.ARCIELA_II] = xi.trust.messageOffset.TEAMWORK_4,
        [xi.magic.spell.IROHA_II] = xi.trust.messageOffset.TEAMWORK_5,
    })

    local itemOneGambit = mob:addGambit(ai.t.SELF, { ai.c.HPP_LT, 35 }, { ai.r.MS, ai.s.SPECIFIC, psychoAnima })
    -- TODO: Add additional logic for Hysteroanima
    -- local itemTwoGambit = mob:addGambit(ai.t.TARGET, { ai.c.CASTING_MA, 35 }, { ai.r.MS, ai.s.SPECIFIC, 3540 })

    mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 25 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURAGA })
    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.SLEEP_I }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURAGA })
    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.SLEEP_II }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURAGA })

    -- TODO: Trust Synergy: If Ulmia in the party, Prishe will cast Curaga when party members are in the yellow instead of red.
    -- Prishe will use Cure spells exclusively on Ulmia (Only Cure I-IV)
    -- https://ffxiclopedia.fandom.com/wiki/Trust:_Prishe_II

    mob:addListener('WEAPONSKILL_USE', 'PRISHE_II_WEAPONSKILL_USE', function(mobArg, target, wsid, tp, action)
        if wsid == 3234 then -- Nullifying Dropkick
            -- Welcome to Painville!
            xi.trust.message(mobArg, xi.trust.messageOffset.SPECIAL_MOVE_1)
        end
    end)

    mob:addListener('WEAPONSKILL_STATE_EXIT', 'ANIMA_USED', function(mobArg, wsid)
        if wsid == psychoAnima then
            mobArg:removeGambit(itemOneGambit)
        end

        --[[
        if wsid == hysteroAnima then
            mobArg:removeGambit(itemTwoGambit)
        end
        ]]--
    end)

    mob:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.RANDOM)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
