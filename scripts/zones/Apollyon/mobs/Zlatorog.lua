-----------------------------------
-- Area: Apollyon NW
--  Mob: Zlatorog
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
      local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()
    GetNPCByID(16932864+108):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+108):setStatus(tpz.status.NORMAL)
end
