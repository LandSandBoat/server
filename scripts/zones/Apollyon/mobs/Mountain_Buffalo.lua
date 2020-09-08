-----------------------------------
-- Area: Apollyon NW
--  Mob: Mountain Buffalo
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
 local mobID = mob:getID()
 -- print(mobID)
      local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()

 if (mobID ==16932951) then -- recover
       GetNPCByID(16932864+289):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+289):setStatus(tpz.status.NORMAL)
 elseif (mobID ==16932952) then -- timer 1
       GetNPCByID(16932864+43):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+43):setStatus(tpz.status.NORMAL)
 elseif (mobID ==16932954) then -- timer 2
      GetNPCByID(16932864+44):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+44):setStatus(tpz.status.NORMAL)
 elseif (mobID ==16932957) then -- timer 3
      GetNPCByID(16932864+45):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+45):setStatus(tpz.status.NORMAL)
 end
end
