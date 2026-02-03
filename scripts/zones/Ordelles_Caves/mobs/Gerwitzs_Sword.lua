-----------------------------------
-- Area: Ordelles Caves
--   NM: Gerwitz's Sword
-- !pos -51 0.1 3 193
-----------------------------------
local ordellesID = zones[xi.zone.ORDELLES_CAVES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
end

entity.onMobDeath = function(mob, player, optParams)
    player:showText(mob, ordellesID.text.GERWITZS_SWORD_DIALOG)
end

return entity
