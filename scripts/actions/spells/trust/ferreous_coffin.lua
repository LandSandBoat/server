-----------------------------------
-- Trust: Ferreous Coffin
-- Auto Refresh II (Cleric's Bliaut +2). HP-10%, MP+35%
-- Will only cast Raise III on KO party members in casting range.
-- Will only cast status ailment removal spells on the player with the highest enmity.
-- Has a high Cursna success rate (only casts on the highest threat player) Official note
-- Ferreous Coffin only uses Randgrith and benefits from relic aftermath (acc +20).
-- Will use TP as soon as he gets it, so he is good at maintaining enemy Evasion Down and initiating Light skillchains.
-- Casts Haste on party members regardless of job.
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.SPAWN)

    -- HPP/MPP mods migrated to sql/mob_pool_mods
    mob:addMod(xi.mod.REFRESH, 2)
    mob:addMod(xi.mod.ENHANCES_CURSNA, 20)

    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.SLOW }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.ERASE })
    mob:addGambit(ai.t.PARTY, { ai.c.NOT_STATUS, xi.effect.HASTE }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.HASTE })

    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.SLEEP_I }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURE })
    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.SLEEP_II }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURE })

    mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 75 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE })

    mob:addGambit(ai.t.TOP_ENMITY, { ai.c.STATUS, xi.effect.PARALYSIS }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.PARALYNA })
    mob:addGambit(ai.t.TOP_ENMITY, { ai.c.STATUS, xi.effect.BLINDNESS }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.BLINDNA })
    mob:addGambit(ai.t.TOP_ENMITY, { ai.c.STATUS, xi.effect.SILENCE }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.SILENA })
    mob:addGambit(ai.t.TOP_ENMITY, { ai.c.STATUS, xi.effect.PETRIFICATION }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.STONA })
    mob:addGambit(ai.t.TOP_ENMITY, { ai.c.STATUS, xi.effect.DISEASE }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.VIRUNA })

    mob:addGambit(ai.t.TOP_ENMITY, { ai.c.STATUS, xi.effect.CURSE_I }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURSNA })
    mob:addGambit(ai.t.TOP_ENMITY, { ai.c.STATUS, xi.effect.CURSE_II }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURSNA })
    mob:addGambit(ai.t.TOP_ENMITY, { ai.c.STATUS, xi.effect.BANE }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURSNA })
    mob:addGambit(ai.t.TOP_ENMITY, { ai.c.STATUS, xi.effect.DOOM }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURSNA })

    mob:addGambit(ai.t.PARTY_DEAD, { ai.c.ALWAYS, 0 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.RAISE })

    mob:addListener('WEAPONSKILL_USE', 'FERREOUS_COFFIN_WEAPONSKILL_USE', function(mobArg, target, wsid, tp, action)
        if wsid == 170 then -- Randgrith
        -- Return to the dust whence you came! Randgrith!!!
            if math.random(1, 100) <= 66 then
                xi.trust.message(mobArg, xi.trust.messageOffset.SPECIAL_MOVE_1)
            end

            mob:addStatusEffect(xi.effect.ACCURACY_BOOST, 20, 0, 20) -- Cheat in Relic AM ACC
            -- TODO: Expand Relic (Mjollnir) Handling (Occ. Double Damage, etc)
        end
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
