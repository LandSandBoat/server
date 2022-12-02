-----------------------------------
-- PET: Luopan
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- BGWIKI: "Regardless of perpetuation cost reduction, Luopans have a maximum duration of 10 minutes."
    mob:timer(600000, function(mobArg)
        mobArg:setHP(0)
    end)
end

entity.onMobDeath = function(mob)
end

return entity
