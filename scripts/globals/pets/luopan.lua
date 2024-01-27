-----------------------------------
-- PET: Luopan
-----------------------------------
xi = xi or {}
xi.pets = xi.pets or {}
xi.pets.luopan = {}

xi.pets.luopan.onMobSpawn = function(mob)
    -- BGWIKI: "Regardless of perpetuation cost reduction, Luopans have a maximum duration of 10 minutes."
    mob:timer(600000, function(mobArg)
        mobArg:setHP(0)
    end)
end

xi.pets.luopan.onMobDeath = function(mob)
end
