-----------------------------------
-- Area: Mamook
--  Mob: Mamool Ja Palatine
-- Note: When this mob dies, it updates a timer to be respawned
--       by Gulool.
-----------------------------------
mixins = { require("scripts/mixins/weapon_break") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Adds not witnessed to use any mob skills
    mob:setMobAbilityEnabled(false)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    GetMobByID(zones[mob:getZoneID()].mob.GULOOL_JA_JA):setLocalVar("[GULOOL]respawnAdd" .. mob:getID(), os.time() + 30)
end

return entity
