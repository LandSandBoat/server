-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Punctured Percy
-- BCNM: Celery
-----------------------------------
local qubiaID = zones[xi.zone.QUBIA_ARENA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
end

entity.onMobSpawn = function(mob)
    -- Punctured Percy takes increased damage from Piercing attacks but reduced damage from Slashing, Blunt & H2H attacks. Takes normal magic damage.
    mob:setMod(xi.mod.SLASH_SDT, -9500)
    mob:setMod(xi.mod.PIERCE_SDT, 10000)
    mob:setMod(xi.mod.IMPACT_SDT, -9500)
    mob:setMod(xi.mod.HTH_SDT, -9500)
end

entity.onMobEngage = function(mob, target)
    -- When Punctured Percy is engaged, the other three ghosts despawn.
    local mobId = mob:getID()
    DespawnMob(mobId - 3) -- Annihilated Anthony
    DespawnMob(mobId - 2) -- Shredded Samson
    DespawnMob(mobId - 1) -- Mauled Murdock
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.AERO_III,
        xi.magic.spell.ASPIR,
        xi.magic.spell.BIND,
        xi.magic.spell.BIO_II,
        xi.magic.spell.BLIND,
        xi.magic.spell.BLIZZAGA_II,
        xi.magic.spell.BURST,
        xi.magic.spell.DRAIN,
        xi.magic.spell.DROWN,
        xi.magic.spell.FLOOD,
        xi.magic.spell.FROST,
        xi.magic.spell.ICE_SPIKES,
        xi.magic.spell.POISON_II,
        xi.magic.spell.QUAKE,
        xi.magic.spell.RASP,
        xi.magic.spell.SLEEP,
        xi.magic.spell.SLEEP_II,
        xi.magic.spell.SLEEPGA,
        xi.magic.spell.STUN,
        xi.magic.spell.THUNDAGA_II,
        xi.magic.spell.TORNADO,
        xi.magic.spell.WATER_III,
    }

    return spellList[math.random(1, #spellList)]
end

entity.onMobDeath = function(mob, player, optParams)
    mob:messageText(mob, qubiaID.text.ETERNAL_DAMNATION)
end

return entity
