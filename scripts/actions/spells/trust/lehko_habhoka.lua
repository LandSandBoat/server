-----------------------------------
-- Trust: Lehko Habhoka
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
        [xi.magic.spell.ROMAA_MIHGO] = xi.trust.messageOffset.TEAMWORK_1,
        [xi.magic.spell.ROBEL_AKBEL] = xi.trust.messageOffset.TEAMWORK_2,
    })

    mob:addGambit(ai.t.TARGET, { ai.c.MB_AVAILABLE, 0 }, { ai.r.MA, ai.s.MB_ELEMENT, xi.magic.spellFamily.NONE })

    mob:addGambit(ai.t.TARGET, { ai.c.NOT_SC_AVAILABLE, 0 }, { ai.r.MA, ai.s.BEST_AGAINST_TARGET, 0 }, 60)

    ---- Uses Ranged Attacks very frequently. Always runs to stay in melee range. [Verification Needed]
    ---- Try and ranged attack every 10s
    mob:addGambit(ai.t.TARGET, { ai.c.ALWAYS, 0 }, { ai.r.RATTACK, 0, 0 }, 10)

    mob:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.RANDOM)

    mob:addListener('WEAPONSKILL_USE', 'LEHKO_WEAPONSKILL_USE', function(mobArg, target, wsid, tp, action)
        if wsid == 3231 then -- Debonair Rush
            --  Here's betting your bark is worrrse than your bite!
            xi.trust.message(mobArg, xi.trust.messageOffset.SPECIAL_MOVE_1)
        end
    end)

    -- MPP 150 migrated to mob_pool_mods
    -- https://forum.square-enix.com/ffxi/threads/49425-Dec-10-2015-%28JST%29-Version-Update?p=567979&viewfull=1#post567979
    -- The attribute "Enhanced Magic Accuracy" has been added.
    local power = mob:getMainLvl() / 10
    mob:addMod(xi.mod.MACC, power)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
