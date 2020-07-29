-----------------------------------
-- Area: Apollyon NW
--  Mob: Cynoprosopi
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
      local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()
    GetNPCByID(16932864+110):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+110):setStatus(tpz.status.NORMAL)
end
