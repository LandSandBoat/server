-----------------------------------
-- Area: Temenos E T
--  Mob: Light Elemental
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobEngaged(mob, target)
   local mobID = mob:getID()
  if (mobID==16929031) then
          GetMobByID(16929032):updateEnmity(target)
        GetMobByID(16929030):updateEnmity(target)
  elseif (mobID==16929032) then
          GetMobByID(16929031):updateEnmity(target)
        GetMobByID(16929030):updateEnmity(target)
  end
end

function onMobDeath(mob, player, isKiller)
   local mobID = mob:getID()

     switch (mobID): caseof {
        [16929031] = function (x)
          if (IsMobDead(16929030)==true and IsMobDead(16929032)==true ) then
            GetNPCByID(16928768+77):setPos(0.5, -6, -459)
            GetNPCByID(16928768+77):setStatus(tpz.status.NORMAL)
            GetNPCByID(16928768+472):setStatus(tpz.status.NORMAL)
          end
        end    ,
        [16929032] = function (x)
          if (IsMobDead(16929030)==true and IsMobDead(16929031)==true ) then
            GetNPCByID(16928768+77):setPos(0.5, -6, -459)
            GetNPCByID(16928768+77):setStatus(tpz.status.NORMAL)
            GetNPCByID(16928768+472):setStatus(tpz.status.NORMAL)
          end
        end    ,
     }
end
