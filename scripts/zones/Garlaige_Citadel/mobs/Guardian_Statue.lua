-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Funnel Bats
--  Quest: Peace for the Spirit
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGPHYS, -4000)
    mob:setMod(xi.mod.UDMGMAGIC, -4000)
end

entity.onMobFight = function(mob)
    -- Regain gets stronger as fight goes on. ~75% = 87.5, ~50% = 175, ~25% = 262.5
    mob:setMod(xi.mod.REGAIN, (100 - mob:getHPP()) * 3.5)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
