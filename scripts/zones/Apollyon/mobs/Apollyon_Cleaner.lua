-----------------------------------
-- Area: Apollyon NE
--  Mob: Apollyon Cleaner
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


    if (mobID ==16933082) then -- item
       GetNPCByID(16932864+140):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+140):setStatus(tpz.status.NORMAL)
  elseif (mobID ==16933085) then -- timer T1
    GetNPCByID(16932864+139):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+139):setStatus(tpz.status.NORMAL)
  elseif (mobID ==16933087) then --  timer T2
    GetNPCByID(16932864+85):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+85):setStatus(tpz.status.NORMAL)
  elseif (mobID ==16933092) then --  timer T3
    GetNPCByID(16932864+94):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+94):setStatus(tpz.status.NORMAL)
 elseif (mobID ==16933095) then -- recover
    GetNPCByID(16932864+141):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+141):setStatus(tpz.status.NORMAL)
  end
end
