-----------------------------------
-- Area: Apollyon SW
--  Mob: Water Elemental
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
 local mobID = mob:getID()
 -- print(mobID)
      local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()

 local elementalday = GetServerVariable("[SW_Apollyon]ElementalTrigger") - 1
 local correctelement=false

 switch (elementalday): caseof {
       [0] = function (x)
            if (mobID==16932913 or mobID==16932921  or mobID==16932929) then
            correctelement=true
            end
        end    ,
       [1] = function (x)
            if (mobID==16932912 or mobID==16932920  or mobID==16932928 ) then
            correctelement=true
            end
        end    ,
       [2] = function (x)
            if (mobID==16932916 or mobID==16932924  or mobID==16932932 ) then
            correctelement=true
            end
        end    ,
       [3] = function (x)
            if (mobID==16932910 or mobID==16932918  or mobID==16932926 ) then
            correctelement=true
            end
        end    ,
       [4] = function (x)
            if (mobID==16932914 or mobID==16932922  or mobID==16932930 ) then
            correctelement=true
            end
        end    ,
       [5] = function (x)
            if (mobID==16932917 or mobID==16932925  or mobID==16932933 ) then
            correctelement=true
            end
        end    ,
       [6] = function (x)
            if (mobID==16932931 or mobID==16932915  or mobID==16932923 ) then
            correctelement=true
            end
        end    ,
       [7] = function (x)
            if (mobID==16932911 or mobID==16932919  or mobID==16932927 ) then
            correctelement=true
            end
        end    ,
       }

  if (correctelement==true and IselementalDayAreDead() == true) then
       GetNPCByID(16932864+313):setPos(mobX, mobY, mobZ)
    GetNPCByID(16932864+313):setStatus(tpz.status.NORMAL)
  end

end
