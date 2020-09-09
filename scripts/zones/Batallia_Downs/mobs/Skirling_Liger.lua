-----------------------------------
-- Area: Batallia Downs (105)
--  Mob: Skirling Liger
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------

function onMobEngaged(mob, target)
    mob:setMod(tpz.mod.REGAIN, 50)
end

function onMobDisengage(mob)
    mob:setMod(tpz.mod.REGAIN, 0)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 162)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
end
