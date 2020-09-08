-----------------------------------
-- Area: Apollyon SW
--  Mob: Jidra
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobEngaged(mob, target)
 local mobID = mob:getID()
 -- print(mobID)
      local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()

 if (mobID ==16932882) then
                        SpawnMob(16932889):updateEnmity(target)
 elseif (mobID ==16932883) then
                        SpawnMob(16932890):updateEnmity(target)
 elseif (mobID ==16932884) then
                        SpawnMob(16932891):updateEnmity(target)
 elseif (mobID ==16932885) then
                        SpawnMob(16932892):updateEnmity(target)
 elseif (mobID ==16932886) then
                        SpawnMob(16932893):updateEnmity(target)
 elseif (mobID ==16932887) then
                        SpawnMob(16932894):updateEnmity(target)
 elseif (mobID ==16932888) then
                        SpawnMob(16932895):updateEnmity(target)
 end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
 local mobID = mob:getID()
 -- print(mobID)
      local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()


 if (
IsMobDead(16932882)==true and
IsMobDead(16932883)==true and
IsMobDead(16932884)==true and
IsMobDead(16932885)==true and
IsMobDead(16932886)==true and
IsMobDead(16932887)==true and
IsMobDead(16932888)==true

 ) then

-- time
       GetNPCByID(16932864+70):setPos(mobX+3, mobY, mobZ)
    GetNPCByID(16932864+70):setStatus(tpz.status.NORMAL)
-- recover
       GetNPCByID(16932864+71):setPos(mobX+4, mobY, mobZ+4)
    GetNPCByID(16932864+71):setStatus(tpz.status.NORMAL)
-- item
      GetNPCByID(16932864+72):setPos(mobX, mobY, mobZ-3)
    GetNPCByID(16932864+72):setStatus(tpz.status.NORMAL)


 end


end
