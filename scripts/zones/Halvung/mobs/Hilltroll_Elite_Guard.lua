-----------------------------------
-- Area: Halvung
--  Mob: Hilltroll Elite Guard
-- Note: When this mob dies, it updates a timer to be respawned
--       by Gurfurlur the Menacing.
-----------------------------------
mixins = { require("scripts/mixins/weapon_break") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- mob not witnessed to use any mob skills
    mob:setMobAbilityEnabled(false)
    mob:setMod(xi.mod.WIND_ABSORB, 100)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    GetMobByID(zones[mob:getZoneID()].mob.GURFURLUR_THE_MENACING):setLocalVar("[GURFURLUR]respawnAdd" .. mob:getID(), os.time() + 30)
end

return entity
