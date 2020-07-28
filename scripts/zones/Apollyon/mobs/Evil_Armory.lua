-----------------------------------
-- Area: Apollyon SE
--  Mob: Evil Armory
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobEngaged(mob, target)
    GetMobByID(16933033):updateEnmity(target)
    GetMobByID(16933034):updateEnmity(target)
    GetMobByID(16933035):updateEnmity(target)
    GetMobByID(16933036):updateEnmity(target)
    GetMobByID(16933037):updateEnmity(target)
    GetMobByID(16933038):updateEnmity(target)
    GetMobByID(16933039):updateEnmity(target)
    GetMobByID(16933040):updateEnmity(target)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
   local mobID = mob:getID()
  -- print(mobID)
 local mobX = mob:getXPos()
 local mobY = mob:getYPos()
 local mobZ = mob:getZPos()

  GetNPCByID(16932864+263):setPos(mobX, mobY, mobZ)
  GetNPCByID(16932864+263):setStatus(tpz.status.NORMAL)

end
