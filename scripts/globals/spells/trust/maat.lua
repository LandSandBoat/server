-----------------------------------------
-- Trust: Maat
-----------------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/status")
require("scripts/globals/trust")
-----------------------------------------

local message_page_offset = 37

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell, 1006)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.SPAWN)

    -- On cooldown
    mob:addSimpleGambit(ai.t.SELF, ai.c.ALWAYS, 0,
                        ai.r.JA, ai.s.SPECIFIC, tpz.ja.MANTRA)
end

function onMobDespawn(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
