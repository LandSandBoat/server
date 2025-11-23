-----------------------------------
-- Area: Waughroon Shrine
-- Mob: Queen Jelly
-- BCNM: Royal Jelly
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 200)
    mob:addMod(xi.mod.ACC, 100)
    mob:setMod(xi.mod.SPELLINTERRUPT, 25)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setBaseSpeed(60)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.FIRE,
        xi.magic.spell.BURN,
        xi.magic.spell.BLIZZARD,
        xi.magic.spell.FROST,
        xi.magic.spell.AERO,
        xi.magic.spell.CHOKE,
        xi.magic.spell.STONE,
        xi.magic.spell.RASP,
        xi.magic.spell.THUNDER,
        xi.magic.spell.SHOCK,
        xi.magic.spell.WATER,
        xi.magic.spell.DROWN,
        xi.magic.spell.DIA,
        xi.magic.spell.BANISH,
        xi.magic.spell.BIO,
        xi.magic.spell.DRAIN,
        xi.magic.spell.BINDGA,
    }

    return spellList[math.random(1, #spellList)]
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
