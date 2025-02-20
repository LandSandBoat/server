-----------------------------------
-- Trust: Sylvie UC
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

    local master = mob:getMaster()
    if not master then
        return
    end

    local mJob   = master:getMainJob()

    -- TODO: Nott weaponskill needs implemented and logic added here for Apururu to use at 50% MP at level 50.
    -- Has Regain (50/tick) and uses Nott when MP falls below 66%.
    -- cure IV cures 456 HP @99

    mob:addMod(xi.mod.GEOMANCY_SKILL, 8 * mob:getMainLvl() + 1)
    mob:addMod(xi.mod.INDI_DURATION, 180)
    mob:addMod(xi.mod.REGAIN, 50)

    if mob:getMainLvl() >= 99 then
        mob:addMod(xi.mod.GEOMANCY_BONUS, 3)
    end

    mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 25 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE })

    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.SLEEP_I }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURE })
    mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.SLEEP_II }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURE })

    mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 75 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE })

    mob:addGambit(ai.t.MASTER, { ai.c.STATUS_FLAG, xi.effectFlag.ERASABLE }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.ERASE })
    mob:addGambit(ai.t.PARTY, { ai.c.STATUS_FLAG, xi.effectFlag.ERASABLE }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.ERASE })
    mob:addGambit(ai.t.SELF, { ai.c.STATUS_FLAG, xi.effectFlag.ERASABLE }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.ERASE })

    if mob:getMainLvl() >= 20 then
        mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.COLURE_ACTIVE }, { ai.r.MA, ai.s.BEST_INDI, xi.magic.spellFamily.NONE })
    end

    if mob:getMainLvl() >= 93 and mJob ~= xi.job.GEO then
        mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.ENTRUST }, { ai.r.JA, ai.s.SPECIFIC, xi.jobAbility.ENTRUST })
        mob:addGambit(ai.t.SELF, { ai.c.STATUS, xi.effect.ENTRUST }, { ai.r.MA, ai.s.ENTRUSTED, xi.magic.spellFamily.INDI_BUFF })
    end

    mob:addGambit(ai.t.MASTER, { ai.c.NOT_STATUS, xi.effect.HASTE }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.HASTE })
    mob:addGambit(ai.t.MELEE, { ai.c.NOT_STATUS, xi.effect.HASTE }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.HASTE })

    mob:setAutoAttackEnabled(false)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
