-----------------------------------
-- Trust: Shantotto II
-----------------------------------
require("scripts/globals/gambits")
require("scripts/globals/magic")
require("scripts/globals/trust")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell, xi.magic.spell.SHANTOTTO)
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spell_object.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.SPAWN)

    mob:addSimpleGambit(ai.t.TARGET, ai.c.MB_AVAILABLE, 0, ai.r.MA, ai.s.MB_ELEMENT, xi.magic.spellFamily.NONE)
    mob:addSimpleGambit(ai.t.TARGET, ai.c.NOT_SC_AVAILABLE, 0, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.NONE, 45)

    local trustLevel  = mob:getMainLvl()
    local power       = trustLevel / 5
    local spellDamage = trustLevel * math.floor((trustLevel + 1) / 10)

    mob:addMod(xi.mod.MATT, power)
    mob:addMod(xi.mod.MACC, power)
    mob:addMod(xi.mod.HASTE_MAGIC, 10)

    -- Shantotto's tier I spells scale up to mimic tier 2, 3, etc, spells.
    mob:addMod(xi.mod.MAGIC_DAMAGE, spellDamage)

    -- Shantotto has 100% melee hit rate always.
    -- TODO: Add support for "perfect accuracy" in c++ land and stop hacking her accuracy.
    mob:addMod(xi.mod.ACC, 1000)
    -- TODO: Shantotto II attack type is suposed to be "typeless physical, like requiescat WS."
    -- TODO: Her regular attacks have a big range (distance from mob, not AoE)
end

spell_object.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
end

spell_object.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.message_offset.DEATH)
end

return spell_object
