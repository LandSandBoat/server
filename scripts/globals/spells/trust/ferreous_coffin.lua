-----------------------------------
-- Trust: Ferreous Coffin
-----------------------------------
require("scripts/globals/trust")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spell_object.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.SPAWN)

    -- TODO: Research and apply correct amounts of Double Attack and Auto-Refresh. Given some lower base
    -- values for now.
    -- TODO: Add Randgrith to skill list.
    -- TODO: Raise family gambit not being respected. Resolve before merge.


    mob:addSimpleGambit(ai.t.TOP_ENMITY, ai.c.STATUS, xi.effect.PARALYSIS, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.PARALYNA)
    mob:addSimpleGambit(ai.t.TOP_ENMITY, ai.c.STATUS, xi.effect.CURSE_I, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURSNA)

    mob:addSimpleGambit(ai.t.TOP_ENMITY, ai.c.STATUS_FLAG, xi.effectFlag.ERASABLE, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.ERASE)

    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 25, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE)

    mob:addSimpleGambit(ai.t.MELEE, ai.c.NOT_STATUS, xi.effect.HASTE, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.HASTE)

    -- Adjust target to appropriate type when he can target the dead.
    mob:addSimpleGambit(ai.t.PARTY_DEAD, ai.c.STATUS, xi.effect.KO, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.RAISE)

    mob:addListener("WEAPONSKILL_USE", "FERREOUS_WEAPONSKILL_USE", function(mobArg, target, wsid, tp, action)
        if wsid == 1198 then -- Randgrith
            --  Return to the dust whence you came! Randgrith!!!
            xi.trust.message(mobArg, xi.trust.message_offset.SPECIAL_MOVE_1)
        end
    end)

    mob:addMod(xi.mod.REFRESH, 1)
end

spell_object.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spell_object.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spell_object
