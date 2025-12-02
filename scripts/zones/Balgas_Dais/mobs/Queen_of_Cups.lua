-----------------------------------
-- Area: Balgas Dais
--  Mob: Queen of Cups (WHM)
-- KSNM: Royale Ramble
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SILENCE)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.BANISH_III,
        xi.magic.spell.BANISHGA_III,
        xi.magic.spell.HOLY,
        xi.magic.spell.DIA_II,
        xi.magic.spell.DIAGA_II,
        xi.magic.spell.HASTE,
        xi.magic.spell.BLINK,
        xi.magic.spell.STONESKIN,
        xi.magic.spell.AQUAVEIL,
        xi.magic.spell.SHELL_IV,
        xi.magic.spell.POISONA,
        xi.magic.spell.BLINDNA,
        xi.magic.spell.CURE_V,
        xi.magic.spell.PARALYZE,
        xi.magic.spell.SLOW,
        xi.magic.spell.SILENCE,
        xi.magic.spell.PROTECT_IV,
        xi.magic.spell.ERASE,
    }

    return spellList[math.random(1, #spellList)]
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
