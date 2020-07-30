-----------------------------------
-- Area: Apollyon NE
--  Mob: Borametz
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobDeath(mob, player, isKiller)
 local mobID = mob:getID()
 -- print(mobID)
  --    local mobX = mob:getXPos()
    --local mobY = mob:getYPos()
    --local mobZ = mob:getZPos()

 if (mobID ==16933048) then -- time T1
       GetNPCByID(16932864+118):setPos(452, -1, 30)
    GetNPCByID(16932864+118):setStatus(tpz.status.NORMAL)
 elseif (mobID ==16933052) then -- recover
       GetNPCByID(16932864+120):setPos(470, -1, 30)
    GetNPCByID(16932864+120):setStatus(tpz.status.NORMAL)
 end
end
