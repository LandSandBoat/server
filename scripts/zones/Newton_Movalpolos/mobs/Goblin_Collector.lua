------------------------------
-- Area: Newton Movalpolos
--   NM: Goblin Collector
------------------------------
local ID = require("scripts/zones/Newton_Movalpolos/IDs")
require("scripts/globals/status")
------------------------------

local entity = {}

entity.onMobSpawn = function(mob)
    -- TODO: Needs to do a jumping animation on spawn
    mob:setMod(xi.mod.MATT, 150)
    mob:setMod(xi.mod.BIND_MEVA, 40)
    mob:setMod(xi.mod.GRAVITY_MEVA, 40)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 20)
    mob:showText(mob, ID.text.COLLECTOR_SPAWN, xi.items.PREMIUM_BAG)
end

entity.onMobFight = function(mob, target)
    -- Resets threat on every auto attack
    mob:addListener("ATTACK", "COLLECTOR_ATTACK", function(goblin)
        goblin:resetEnmity(target)
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    mob:removeListener("COLLECTOR_ATTACK")
end

return entity
