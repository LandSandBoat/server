-----------------------------------
-- Trust: Amchuchu
-- Possesses Inspiration (50% Fast Cast effect during Vallation, is party-wide during Valiance), Converts 5% of Physical Damage Taken to MP.
-- Only casts enhancing spells on herself.
-- Uses Embolden when casting Protect.
-- She can rapidly generate Volatile Enmity for initial threat or recovery from enmity reset attacks with a cornucopia of abilties and spells like Provoke, Flash, and Foil.
-- Uses Runes resisting the element of the current day. After taking magic damage, uses the appropriate Bar-spell and changes runes.
-- Uses One for All in response to enemies casting high-tier damaging spells.
-- Magic Bursts Level 4 Light or Level 4 Darkness skillchains using Lunge.
-- Holds up to 3000 TP to close skillchains. Weapon skills are a lower priority,
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

    mob:addMobMod(xi.mobMod.CAN_PARRY, 3)

    mob:addMod(xi.mod.INSPIRATION_FAST_CAST, 50)
    mob:addMod(xi.mod.ENMITY, 15)
    mob:addMod(xi.mod.DMG, -500) -- Damage Taken -5%
    mob:addMod(xi.mod.HPP, 10)
    mob:addMod(xi.mod.MPP, 10)

    local lvl = mob:getMainLvl()

    if lvl >= 5 then
        mob:addGambit(ai.t.SELF, { ai.c.NO_MAX_RUNE, 0 }, { ai.r.JA, ai.s.RUNE_DAY, xi.ja.IGNIS })
    end

    if lvl >= 10 then
        mob:addGambit(ai.t.TARGET, { ai.c.ALWAYS,           0                    }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE   })
        mob:addGambit(ai.t.TARGET, { ai.c.CAST_ELE_MA_SELF, xi.effect.VALLATION  }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.VALLATION })
    end

    if lvl >= 20 then
        mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.SWORDPLAY }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SWORDPLAY })
    end

    if lvl >= 25 then
        mob:addGambit(ai.t.TARGET, { ai.c.LUNGE_MB_AVAILABLE, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.LUNGE })
        mob:addGambit(ai.t.TARGET, { ai.c.LUNGE_MB_AVAILABLE, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SWIPE })
    end

    if lvl >= 30 then
        mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.BERSERK }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.BERSERK })
    end

    if lvl >= 50 then
        mob:addGambit(ai.t.TARGET, { ai.c.CASTING_ELE_MA_AOE, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.VALIANCE })
    end

    if lvl >= 60 then
        mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.EMBOLDEN }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.EMBOLDEN })
    end

    if lvl >= 65 then
        mob:addGambit(ai.t.SELF, { ai.c.HPP_LT, 50 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.VIVACIOUS_PULSE })
    end

    if lvl >= 75 then
        mob:addGambit(ai.t.SELF, { ai.c.HPP_LT, 75 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.BATTUTA })
    end

    if lvl >= 95 then
        mob:addGambit(ai.t.TARGET, { ai.c.CASTING_ELE_MA_AOE, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.ONE_FOR_ALL })
    end

    mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS, xi.effect.FLASH   }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH         })
    mob:addGambit(ai.t.SELF,   { ai.c.NOT_STATUS, xi.effect.PHALANX }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.PHALANX       })
    mob:addGambit(ai.t.SELF,   { ai.c.NOT_STATUS, xi.effect.FOIL    }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FOIL          })
    mob:addGambit(ai.t.SELF,   { ai.c.NOT_STATUS, xi.effect.PROTECT }, { ai.r.MA, ai.s.HIGHEST,  xi.magic.spellFamily.PROTECT })
    mob:addGambit(ai.t.SELF,   { ai.c.NOT_STATUS, xi.effect.SHELL   }, { ai.r.MA, ai.s.HIGHEST,  xi.magic.spellFamily.SHELL   })

    mob:addGambit(ai.t.TARGET, { { ai.c.CAST_ELE_MA_SELF, 0                   }, { ai.c.NEED_ELE_BAREFFECT,  0 }, }, { ai.r.MA, ai.s.DEF_BAR_ELEMENT, 0                          })
    mob:addGambit(ai.t.SELF,   { { ai.c.NOT_STATUS,       xi.effect.REGEN     }, { ai.c.HPP_LT,             75 }, }, { ai.r.MA, ai.s.HIGHEST,         xi.magic.spellFamily.REGEN })
    mob:addGambit(ai.t.SELF,   { { ai.c.NOT_STATUS,       xi.effect.REFRESH   }, { ai.c.MPP_LT,             75 }, }, { ai.r.MA, ai.s.SPECIFIC,        xi.magic.spell.REFRESH     })

    mob:addGambit(ai.t.SELF, {
        { ai.c.NOT_STATUS, xi.effect.STONESKIN },
        { ai.c.HPP_LT, 75 },
        { ai.c.MPP_GTE, 50 }, }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.STONESKIN })

    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.HIGHEST, 3000)

    mob:addListener('WEAPONSKILL_USE', 'AMCHUCHU_WEAPONSKILL_USE', function(mobArg, target, skill, tp, action)
        if skill:getID() == xi.mobSkill.DIMIDIATION_1 then
            xi.trust.message(mobArg, xi.trust.messageOffset.SPECIAL_MOVE_1) -- Nothing-wothing wrong with a little mad science now and again!
        end
    end)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
