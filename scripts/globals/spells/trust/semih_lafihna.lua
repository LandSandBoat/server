-----------------------------------
-- Trust: Semih Lafihna
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spell_object.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.STAR_SIBYL] = xi.trust.message_offset.TEAMWORK_1,
        [xi.magic.spell.AJIDO_MARUJIDO] = xi.trust.message_offset.TEAMWORK_2,
    })

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.BARRAGE,
                        ai.r.JA, ai.s.SPECIFIC, xi.ja.BARRAGE)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.SHARPSHOT,
                        ai.r.JA, ai.s.SPECIFIC, xi.ja.SHARPSHOT)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.DOUBLE_SHOT,
                        ai.r.JA, ai.s.SPECIFIC, xi.ja.DOUBLE_SHOT)

    mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0,
                        ai.r.JA, ai.s.SPECIFIC, xi.ja.STEALTH_SHOT)

    mob:addListener("WEAPONSKILL_USE", "SEMIH_LAFIHNA_WEAPONSKILL_USE", function(mobArg, target, wsid, tp, action)
        if wsid == 3490 then -- Stellar Arrow
            -- I'll show you no quarter!
            xi.trust.message(mobArg, xi.trust.message_offset.SPECIAL_MOVE_1)
        end
    end)

    -- Ranged Attack as much as possible (limited by "weapon" delay)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.ALWAYS, 0, ai.r.RATTACK, 0, 0)

    mob:SetAutoAttackEnabled(false)

    mob:addMod(xi.mod.STORETP, 30)
end

spell_object.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spell_object.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spell_object
