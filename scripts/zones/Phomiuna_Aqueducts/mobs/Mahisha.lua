-----------------------------------
-- Area: Phomiuna_Aqueducts
--   NM: Mahisha
-----------------------------------
mixins = { require("scripts/mixins/fomor_hate") }
local ID = require("scripts/zones/Phomiuna_Aqueducts/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar("fomorHateAdj", 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    -- Respawn is shared with Eba, random to see which spawns
    if math.random(1, 2) == 1 then
        SetServerVariable("EBA_MAHISHA", 1) -- Respawn Mahisha
        xi.mob.nmTODPersist(mob, math.random(28800, 43200)) -- 8 to 12 hours
    else
        SetServerVariable("EBA_MAHISHA", 0) -- Respawn Eba
        xi.mob.nmTODPersist(GetMobByID(ID.mob.EBA), math.random(28800, 43200)) -- 8 to 12 hours
    end
end

return entity
