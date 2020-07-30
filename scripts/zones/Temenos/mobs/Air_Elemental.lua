-----------------------------------
-- Area: Temenos E T
--  Mob: Air Elemental
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobDeath(mob, player, isKiller)
   local mobID = mob:getID()
   local mobX = mob:getXPos()
   local mobY = mob:getYPos()
   local mobZ = mob:getZPos()
     switch (mobID): caseof {
         -- 100 a 106 inclut (Temenos -Northern Tower )
        [16928858] = function (x)
           GetNPCByID(16928768+181):setPos(mobX, mobY, mobZ)
           GetNPCByID(16928768+181):setStatus(tpz.status.NORMAL)
        end    ,
        [16928859] = function (x)
           GetNPCByID(16928768+217):setPos(mobX, mobY, mobZ)
           GetNPCByID(16928768+217):setStatus(tpz.status.NORMAL)
        end    ,
        [16928860] = function (x)
           GetNPCByID(16928768+348):setPos(mobX, mobY, mobZ)
           GetNPCByID(16928768+348):setStatus(tpz.status.NORMAL)
        end    ,
        [16928861] = function (x)
           GetNPCByID(16928768+46):setPos(mobX, mobY, mobZ)
           GetNPCByID(16928768+46):setStatus(tpz.status.NORMAL)
        end    ,
        [16929035] = function (x)
           if (IsMobDead(16929036)==false) then
             DespawnMob(16929036)
             SpawnMob(16929042)
           end
        end    ,
     }
end
