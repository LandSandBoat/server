-----------------------------------
-- Area: Arrapago Reef
--  Mob: Lamia Exon
-- Note: When this mob dies, it updates a timer to be respawned
--       by Medusa.
-----------------------------------
mixins = { require("scripts/mixins/weapon_break") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Two of Medusa's adds spawn with different models and jobs
    if mob:getID() > zones[mob:getZoneID()].mob.MEDUSA + 2 then
        mob:setMagicCastingEnabled(false)
        mob:setModelId(1655)
        mob:changeJob(1)
    end

    -- Adds not witnessed to use any mob skills
    mob:setMobAbilityEnabled(false)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    GetMobByID(zones[mob:getZoneID()].mob.MEDUSA):setLocalVar("[MEDUSA]respawnAdd" .. mob:getID(), os.time() + 30)
end

return entity
