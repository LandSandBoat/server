-----------------------------------
-- Area: Batallia Downs (105)
--  Mob: Skirling Liger
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    mob:setMod(tpz.mod.REGAIN, 50)
end

entity.onMobDisengage = function(mob)
    mob:setMod(tpz.mod.REGAIN, 0)
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 162)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
end

return entity
