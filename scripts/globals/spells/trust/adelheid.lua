-----------------------------------
-- Trust: Adelheid
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/roe")
require("scripts/globals/trust")
require("scripts/globals/weaponskillids")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spell_object.onSpellCast = function(caster, target, spell)

    -- Records of Eminence: Alter Ego: Adelheid
    if caster:getEminenceProgress(936) then
        xi.roe.onRecordTrigger(caster, 936)
    end

    return xi.trust.spawn(caster, spell)
end

spell_object.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.SPAWN)

    -- TODO: Add Dark Arts, Addendum: Black (requires plumbing updates to work with Trusts)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_WS, 0, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.STUN)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_MS, 0, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.STUN)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.READYING_JA, 0, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.STUN)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.CASTING_MA, 0, ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.STUN)

    -- TODO: Choose Storms based on Mob Weakness before falling back to matching day
    mob:addSimpleGambit(ai.t.SELF, ai.c.NO_STORM, 0, ai.r.MA, ai.s.STORM_DAY, 0, 0)

    -- TODO: Choose Helix based on Mob Weakness before falling back to matching day
    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_STATUS, xi.effect.HELIX, ai.r.MA, ai.s.HELIX_DAY, 0, 0)

    mob:addSimpleGambit(ai.t.TANK, ai.c.HPP_LT, 50, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 33, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE)

    -- TODO: Add Magic Burst Logic to Gambits to MB with Helix corresponding to SC
    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.NONE, 75)
end

spell_object.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spell_object.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spell_object
