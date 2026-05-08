-----------------------------------
-- Trust: Trion
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
        [xi.magic.spell.CURILLA] = xi.trust.messageOffset.TEAMWORK_1,
        [xi.magic.spell.RAHAL] = xi.trust.messageOffset.TEAMWORK_2,
        [xi.magic.spell.HALVER] = xi.trust.messageOffset.TEAMWORK_3,
    })

    mob:setMobMod(xi.mobMod.CAN_SHIELD_BLOCK, 1)
    mob:setMobMod(xi.mobMod.CAN_PARRY, 3)

    mob:addMod(xi.mod.HPP, 10)
    mob:addMod(xi.mod.MPP, 10)
    mob:addMod(xi.mod.FASTCAST, 30)
    mob:addMod(xi.mod.DMG, -1000)
    mob:addMod(xi.mod.ENMITY, 25)

    mob:addGambit(ai.t.SELF,   { ai.c.NOT_HAS_TOP_ENMITY, 0                  }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE                  })
    mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS,         xi.effect.FLASH    }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH           })
    mob:addGambit(ai.t.SELF,   { ai.c.NOT_STATUS,         xi.effect.SENTINEL }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SENTINEL                 })
    mob:addGambit(ai.t.PARTY,  { ai.c.HPP_LT,             75                 }, { ai.r.MA, ai.s.HIGHEST,  xi.magic.spellFamily.CURE      })

    mob:setTrustTPSkillSettings(ai.tp.RANDOM, ai.s.RANDOM, 1500)

    mob:addListener('WEAPONSKILL_USE', 'TRION_WEAPONSKILL_USE', function(mobArg, target, skill, tp, action, damage)
        if skill:getID() == xi.mobSkill.ROYAL_SAVIOR_TRUST then -- Royal Savior
            -- O great kings of the noble line of d'Oraguille, shield me from harm!
            xi.trust.message(mobArg, xi.trust.messageOffset.SPECIAL_MOVE_1)
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
