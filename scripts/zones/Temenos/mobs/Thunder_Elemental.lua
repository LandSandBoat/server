-----------------------------------
-- Area: Temenos E T
--  Mob: Thunder Elemental
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
        [16928876] = function (x)
           GetNPCByID(16928768+183):setPos(mobX, mobY, mobZ)
           GetNPCByID(16928768+183):setStatus(tpz.status.NORMAL)
        end    ,
        [16928877] = function (x)
           GetNPCByID(16928768+261):setPos(mobX, mobY, mobZ)
           GetNPCByID(16928768+261):setStatus(tpz.status.NORMAL)
        end    ,
        [16928878] = function (x)
           GetNPCByID(16928768+393):setPos(mobX, mobY, mobZ)
           GetNPCByID(16928768+393):setStatus(tpz.status.NORMAL)
        end    ,
        [16928879] = function (x)
           GetNPCByID(16928768+68):setPos(mobX, mobY, mobZ)
           GetNPCByID(16928768+68):setStatus(tpz.status.NORMAL)
        end    ,
        [16929037] = function (x)
           if (IsMobDead(16929038)==false) then
             DespawnMob(16929038)
             SpawnMob(16929044)
           end
        end    ,
     }
end
