 -----------------------------------
-- PET: Luopan
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/msg")
-----------------------------------

function onMobSpawn(mob)
    -- BGWIKI: "Regardless of perpetuation cost reduction, Luopans have a maximum duration of 10 minutes."
    mob:timer(600000, function(mob) mob:setHP(0) end)
end

function onMobDeath(mob)
end
