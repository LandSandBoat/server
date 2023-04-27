-----------------------------------
-- Area: Arrapago Reef
--  Mob: Lamia's Avatar (Lamie No.9 pet)
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.BINDRES, 10000)
    mob:setMod(xi.mod.GRAVITYRES, 10000)
    mob:setMod(xi.mod.SLEEPRES, 10000)
    mob:setMod(xi.mod.STUNRES, 10000)
    mob:setMod(xi.mod.LULLABYRES, 10000)
end

entity.onMobDeath = function(mob, player, optParams)
    local respawnTime = math.random(60, 90) + os.time()
    mob:setLocalVar("respawn", respawnTime)
end

return entity
