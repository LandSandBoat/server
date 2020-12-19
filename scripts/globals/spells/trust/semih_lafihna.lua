-----------------------------------------
-- Trust: Semih Lafihna
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------------

local message_page_offset = 44

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    tpz.trust.teamworkMessage(mob, message_page_offset, {
        [tpz.magic.spell.STAR_SIBYL] = tpz.trust.message_offset.TEAMWORK_1,
        [tpz.magic.spell.AJIDO_MARUJIDO] = tpz.trust.message_offset.TEAMWORK_2,
    })

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.BARRAGE,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.BARRAGE)

    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, tpz.effect.SHARPSHOT,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.SHARPSHOT)

    mob:addSimpleGambit(ai.t.SELF, ai.c.HAS_TOP_ENMITY, 0,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.STEALTH_SHOT)

    -- Ranged Attack as much as possible (limited by "weapon" delay)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.ALWAYS, 0, ai.r.RATTACK, 0, 0)

    mob:SetAutoAttackEnabled(false)
end

function onMobDespawn(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
