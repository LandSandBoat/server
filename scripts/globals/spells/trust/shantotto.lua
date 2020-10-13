-----------------------------------------
-- Trust: Shantotto
-----------------------------------------
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/trust")
-----------------------------------------

local message_page_offset = 0

function onMagicCastingCheck(caster, target, spell)
    return tpz.trust.canCast(caster, spell, tpz.magic.spell.SHANTOTTO_II)
end

function onSpellCast(caster, target, spell)
    return tpz.trust.spawn(caster, spell)
end

function onMobSpawn(mob)
    tpz.trust.teamworkMessage(mob, message_page_offset, {
        [tpz.magic.spell.AJIDO_MARUJIDO] = tpz.trust.message_offset.TEAMWORK_1,
        [tpz.magic.spell.STAR_SIBYL] = tpz.trust.message_offset.TEAMWORK_2,
        [tpz.magic.spell.KORU_MORU] = tpz.trust.message_offset.TEAMWORK_3,
        [tpz.magic.spell.KING_OF_HEARTS] = tpz.trust.message_offset.TEAMWORK_4
    })

    mob:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0, ai.r.MA, ai.s.MB_ELEMENT, tpz.magic.spellFamily.NONE)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0, ai.r.MA, ai.s.HIGHEST, tpz.magic.spellFamily.NONE, 60)

    mob:addFullGambit({
        ['predicates'] =
        {
            {
                ['target'] = ai.t.TARGET, ['condition'] = ai.c.MB_AVAILABLE, ['argument'] = 0,
            }
        },
        ['actions'] =
        {
            {
                ['reaction'] = ai.r.MA, ['select'] = ai.s.HIGHEST, ['argument'] = tpz.magic.spellFamily.NONE,
            },
            {
                ['reaction'] = ai.r.MSG, ['select'] = ai.s.SPECIFIC, ['argument'] = tpz.trust.message_offset.SPECIAL_MOVE_1, -- Ohohoho!
            },
        },
    })

    local power = mob:getMainLvl() / 10
    mob:addMod(tpz.mod.MATT, power)
    mob:addMod(tpz.mod.MACC, power)
    mob:addMod(tpz.mod.HASTE_MAGIC, 10)
    mob:SetAutoAttackEnabled(false)
end

function onMobDespawn(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DESPAWN)
end

function onMobDeath(mob)
    tpz.trust.message(mob, message_page_offset, tpz.trust.message_offset.DEATH)
end
