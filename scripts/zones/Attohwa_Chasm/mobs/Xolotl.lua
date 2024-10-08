-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setRespawnTime(0)
    mob:setMobMod(xi.mobMod.SUPERLINK, 32)
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.XOLOTL_XTRAPOLATOR)
end

entity.onMobDespawn = function(mob)
    -- Do not respawn Xolotl for 21-24 hours
    mob:setRespawnTime(math.random(75600, 86400))
end

return entity
