-----------------------------------
-- Area: Batallia Downs (105)
--  Mob: Skirling Liger
-----------------------------------
local entity = {}

entity.onMobEngage = function(mob, target)
    mob:setMod(xi.mod.REGAIN, 50)
end

entity.onMobDisengage = function(mob)
    mob:setMod(xi.mod.REGAIN, 0)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 162)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
end

return entity
