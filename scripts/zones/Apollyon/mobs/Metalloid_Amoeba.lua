-----------------------------------
-- Area: Apollyon SE
--  Mob: Metalloid Amoeba
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
 local mobID = mob:getID()
 -- print(mobID)
      local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()

 if (mobID ==16932993) then -- time
       GetNPCByID(16932864+1):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+1):setStatus(tpz.status.NORMAL)
 elseif (mobID ==16932996) then -- recover
       GetNPCByID(16932864+3):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+3):setStatus(tpz.status.NORMAL)
 elseif (mobID ==16933000) then -- item
      GetNPCByID(16932864+2):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+2):setStatus(tpz.status.NORMAL)
 end
end
