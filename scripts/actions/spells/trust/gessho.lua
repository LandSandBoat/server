-----------------------------------
-- Trust: Gessho
-- Will only use the highest tier debuff available, but will use both Utsusemi spells.
-- Will maintain Yonin full time.
-- Holds TP until 1500 to try to close skillchains.
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
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.NAJA_SALAHEEM] = xi.trust.messageOffset.TEAMWORK_1,
        [xi.magic.spell.ABQUHBAH] = xi.trust.messageOffset.TEAMWORK_2,
    })

    mob:addMobMod(xi.mobMod.CAN_PARRY, 1)

    mob:addMod(xi.mod.MAIN_DMG_RATING, xi.trust.modGrowthValMax(mob, 35))
    mob:addMod(xi.mod.DOUBLE_ATTACK, xi.trust.modGrowthValMax(mob, 15))
    mob:addMod(xi.mod.ACC, xi.trust.modGrowthValMax(mob, 200))
    mob:addMod(xi.mod.EVA, xi.trust.modGrowthValMax(mob, 125))
    mob:addMod(xi.mod.FASTCAST, 30)
    mob:addMod(xi.mod.ENMITY, 10)

    local lvl = mob:getMainLvl()

    if lvl >= 5 then
        mob:addGambit(ai.t.SELF, { ai.c.ALWAYS, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE })
    end

    if lvl >= 40 then
        mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.YONIN }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.YONIN })
    end

    mob:addGambit(ai.t.SELF,   { ai.c.NOT_STATUS, xi.effect.COPY_IMAGE }, { ai.r.MA, ai.s.HIGHEST,  xi.magic.spellFamily.UTSUSEMI })
    mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS, xi.effect.BLINDNESS  }, { ai.r.MA, ai.s.HIGHEST,  xi.magic.spellFamily.KURAYAMI }, 30)
    mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS, xi.effect.SLOW       }, { ai.r.MA, ai.s.HIGHEST,  xi.magic.spellFamily.HOJO     }, 30)

    mob:addListener('WEAPONSKILL_USE', 'GESSHO_WEAPONSKILL_USE', function(mobArg, target, skill, tp, action, damage)
        if skill:getID() == xi.mobSkill.SHIBARAKU_TRUST then -- Shibaraku
            -- You have left me no choice. Prepare yourself!
            xi.trust.message(mobArg, xi.trust.messageOffset.SPECIAL_MOVE_1)
        end
    end)

    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.RANDOM, 1500)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
