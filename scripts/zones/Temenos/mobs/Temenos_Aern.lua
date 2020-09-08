-----------------------------------
-- Area: Temenos
--  Mob: Temenos Aern
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobDeath(mob, player, isKiller)
   local mobID = mob:getID()
   local mobX = mob:getXPos()
   local mobY = mob:getYPos()
   local mobZ = mob:getZPos()
switch (mobID): caseof {
       [16929054] = function (x)
            GetNPCByID(16928768+197):setPos(mobX, mobY, mobZ)
            GetNPCByID(16928768+197):setStatus(tpz.status.NORMAL)
       end,
       [16929060] = function (x)
            GetNPCByID(16928768+199):setPos(mobX, mobY, mobZ)
             GetNPCByID(16928768+199):setStatus(tpz.status.NORMAL)
       end,
       [16929065] = function (x)
           GetNPCByID(16928768+200):setPos(mobX, mobY, mobZ)
           GetNPCByID(16928768+200):setStatus(tpz.status.NORMAL)
       end,
       [16929075] = function (x)
           GetNPCByID(16928768+201):setPos(mobX, mobY, mobZ)
           GetNPCByID(16928768+201):setStatus(tpz.status.NORMAL)
       end,
       [16929083] = function (x)
           GetNPCByID(16928768+202):setPos(mobX, mobY, mobZ)
           GetNPCByID(16928768+202):setStatus(tpz.status.NORMAL)
       end,

}
local leftAern=0

local AernList = {16929053, 16929054, 16929055, 16929057, 16929058, 16929060, 16929061, 16929062, 16929063,
                  16929064, 16929065, 16929066, 16929069, 16929071, 16929072, 16929073, 16929075, 16929076,
                  16929077, 16929078, 16929079, 16929082, 16929083, 16929084, 16929085, 16929086, 16929087}

    for n=1, 27, 1 do
      if ( GetMobByID(AernList[n]):isAlive() ) then
        leftAern=leftAern+1
      end
    end
 --print("leftAern" ..leftAern)
    if (leftAern == 0 and isKiller == true) then
     GetMobByID(16929088):setSpawn(mobX, mobY, mobZ)
     GetMobByID(16929088):setPos(mobX, mobY, mobZ)
     SpawnMob(16929088):updateEnmity(player)
    end
end
