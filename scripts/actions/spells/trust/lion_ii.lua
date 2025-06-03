-----------------------------------
-- Trust: Lion II
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell, xi.magic.spell.LION)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.ZEID] = xi.trust.messageOffset.TEAMWORK_1,
        [xi.magic.spell.PRISHE_II] = xi.trust.messageOffset.TEAMWORK_2,
        [xi.magic.spell.LILISETTE_II] = xi.trust.messageOffset.TEAMWORK_4,
        [xi.magic.spell.ARCIELA_II] = xi.trust.messageOffset.TEAMWORK_5,
    })

    mob:addListener('WEAPONSKILL_USE', 'LION_II_WEAPONSKILL_USE', function(mobArg, target, wsid, tp, action)
        if wsid == 3493 then -- Powder Keg
            --  I won't sit by and let Vana'diel be engulged!
            xi.trust.message(mobArg, xi.trust.messageOffset.SPECIAL_MOVE_1)
        end
    end)

    mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.COPY_IMAGE }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.UTSUSEMI })

    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.RANDOM, 3000)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
