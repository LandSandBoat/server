-----------------------------------
-- Area: Apollyon NW
--  Mob: Apollyon Scavenger
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
 local mobID = mob:getID()
 -- print(mobID)
      local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()

 if (mobID ==16932964) then -- recover
       GetNPCByID(16932864+327):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+327):setStatus(tpz.status.NORMAL)
 elseif (mobID ==16932966) then -- timer 1
       GetNPCByID(16932864+177):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+177):setStatus(tpz.status.NORMAL)
 elseif (mobID ==16932967) then -- timer 2
      GetNPCByID(16932864+189):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+189):setStatus(tpz.status.NORMAL)
 elseif (mobID ==16932969) then -- timer 3
      GetNPCByID(16932864+190):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+190):setStatus(tpz.status.NORMAL)
 end
end
