-----------------------------------
-- Area: Temenos W T
--  Mob: Enhanced Mandragora
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobEngaged(mob, target)

end

function onMobDeath(mob, player, isKiller)
local cofferID=Randomcoffer(2, Temenos_Western_Tower)
    local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()
    GetNPCByID(16929236):setStatus(tpz.status.NORMAL)
  if (cofferID~=0) then
       GetNPCByID(16928768+cofferID):setPos(mobX, mobY, mobZ)
    GetNPCByID(16928768+cofferID):setStatus(tpz.status.NORMAL)
  end
end
