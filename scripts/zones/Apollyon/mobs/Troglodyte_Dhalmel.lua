-----------------------------------
-- Area: Apollyon NE
--  Mob: Troglodyte Dhalmel
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
 local mobID = mob:getID()
      local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()


  if (IsMobDead(16933115)==true and
     IsMobDead(16933116)==true and
     IsMobDead(16933117)==true and
     IsMobDead(16933118)==true and
     IsMobDead(16933119)==true and
     IsMobDead(16933120)==true and
     IsMobDead(16933121)==true and
     IsMobDead(16933122)==true
    ) then
     -- item
       GetNPCByID(16932864+178):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+178):setStatus(tpz.status.NORMAL)
   end
end
