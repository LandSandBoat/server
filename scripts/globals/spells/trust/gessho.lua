-----------------------------------
-- Trust: Gessho
-----------------------------------
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.NAJA_SALAHEEM] = xi.trust.message_offset.TEAMWORK_1,
        [xi.magic.spell.ABQUHBAH] = xi.trust.message_offset.TEAMWORK_2,
    })

    mob:addListener("WEAPONSKILL_USE", "GESSHO_WEAPONSKILL_USE", function(mobArg, target, wsid, tp, action)
        if wsid == 3257 then -- Shibaraku
            -- You have left me no choice. Prepare yourself!
            xi.trust.message(mobArg, xi.trust.message_offset.SPECIAL_MOVE_1)
        end
    end)

    -- Shadows are represented by xi.effect.COPY_IMAGE, but with different icons depending on the tier
    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.COPY_IMAGE, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.UTSUSEMI)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, xi.effect.BLINDNESS, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.KURAYAMI, 60)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, xi.effect.SLOW, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.HOJO, 60)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.YONIN,
        ai.r.JA, ai.s.SPECIFIC, xi.ja.YONIN)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_HAS_TOP_ENMITY, 0,
                        ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE)

    mob:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.RANDOM)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spellObject
