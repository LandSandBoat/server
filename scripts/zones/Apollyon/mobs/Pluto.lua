-----------------------------------
-- Area: Apollyon NW
--  Mob: Pluto
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
      local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()
    GetNPCByID(16932864+107):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+107):setStatus(tpz.status.NORMAL)
end
