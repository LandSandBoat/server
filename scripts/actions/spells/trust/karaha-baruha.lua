-----------------------------------
-- Trust: Karaha-Baruha
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
    -- TODO: Add logic so that Spirit Taker is used if lower on mana, instead of holding to close TP.
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.STAR_SIBYL] = xi.trust.messageOffset.TEAMWORK_1,
        [xi.magic.spell.ROBEL_AKBEL] = xi.trust.messageOffset.TEAMWORK_2,
    })

    mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 55 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE })
    mob:addGambit(ai.t.PARTY, { ai.c.NOT_STATUS, xi.effect.PROTECT }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.PROTECTRA })
    mob:addGambit(ai.t.PARTY, { ai.c.NOT_STATUS, xi.effect.SHELL }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.SHELLRA })
    mob:addGambit(ai.t.PARTY, { ai.c.NOT_STATUS, xi.effect.PROTECT }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.PROTECT })
    mob:addGambit(ai.t.PARTY, { ai.c.NOT_STATUS, xi.effect.SHELL }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.SHELL })
    mob:addGambit(ai.t.PARTY, { ai.c.NOT_STATUS, xi.effect.HASTE }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.HASTE })
    -- -na Spells
    mob:addGambit(ai.t.PARTY, { ai.l.OR(
                                { ai.c.STATUS, xi.effect.CURSE_I },
                                { ai.c.STATUS, xi.effect.CURSE_II },
                                { ai.c.STATUS, xi.effect.BANE },
                                { ai.c.STATUS, xi.effect.DOOM })
                                }, { ai.r.MS, ai.s.SPECIFIC, xi.magic.spell.CURSNA })
    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.PARALYSIS }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.PARALYNA })
    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.BLINDNESS }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.BLINDNA })
    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.SILENCE }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.SILENA })
    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.PETRIFICATION }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.STONA })
    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.DISEASE }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.VIRUNA })

    -- Handle his Barelementra tracking --
    mob:addListener('TAKE_DAMAGE', 'KARAHA-BARUHA_TAKE_DAMAGE', function(mobArg, amount, attacker, attackType, damageType)
        local elemTable = {
            [xi.damageType.FIRE] = { effect = xi.effect.BARFIRE, spell = 66 },
            [xi.damageType.ICE] = { effect = xi.effect.BARBLIZZARD, spell = 67 },
            [xi.damageType.WIND] = { effect = xi.effect.BARAERO, spell = 68 },
            [xi.damageType.EARTH] = { effect = xi.effect.BARSTONE, spell = 69 },
            [xi.damageType.THUNDER] = { effect = xi.effect.BARTHUNDER, spell = 70 },
            [xi.damageType.WATER] = { effect = xi.effect.BARWATER, spell = 71 },
        }
        local elemData = elemTable[damageType]
        if elemData and not mobArg:getStatusEffect(elemData.effect) then
            mobArg:timer(30, function(mobBar)
                mobBar:castSpell(elemData.spell)
            end)
        end
    end)

    mob:addListener('WEAPONSKILL_USE', 'KARAHA-BARUHA_WEAPONSKILL_USE', function(mobArg, target, wsid, tp, action)
        if wsid == 3336 then -- Howling Moon
        -- The light shall never fade!
            if math.random(1, 100) <= 25 then
                xi.trust.message(mobArg, xi.trust.messageOffset.SPECIAL_MOVE_1)
            end
        end
    end)

    if
        mob:getMPP() < 30
    then
        mob:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.RANDOM)
    else
        mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.HIGHEST, 3000)
    end
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
