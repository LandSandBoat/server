-----------------------------------
-- Area: Apollyon Central
--  Mob: Gunpod
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
      local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()
    GetNPCByID(16932864+259):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+259):setStatus(tpz.status.NORMAL)
end
