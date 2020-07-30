-----------------------------------
-- Area: Temenos E T
--  Mob: Dark Elemental
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobEngaged(mob, target)

end

function onMobDeath(mob, player, isKiller)
   local mobID = mob:getID()
   local mobX = mob:getXPos()
   local mobY = mob:getYPos()
   local mobZ = mob:getZPos()
     switch (mobID): caseof {
         -- 100 a 106 inclut (Temenos -Northern Tower )
        [16928892] = function (x)
           GetNPCByID(16928768+70):setPos(mobX, mobY, mobZ)
           GetNPCByID(16928768+70):setStatus(tpz.status.NORMAL)
        end    ,
        [16928893] = function (x)
           GetNPCByID(16928768+123):setPos(mobX, mobY, mobZ)
           GetNPCByID(16928768+123):setStatus(tpz.status.NORMAL)
        end    ,
     }
end
