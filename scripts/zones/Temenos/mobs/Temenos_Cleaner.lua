-----------------------------------
-- Area: Temenos Central 1floor
--  Mob: Temenos Cleaner
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobEngaged(mob, target)
 if (IsMobDead(16929046)==true) then
     mob:addStatusEffect(tpz.effect.REGAIN, 7, 3, 0)
     mob:addStatusEffect(tpz.effect.REGEN, 50, 3, 0)
  end
end

function onMobDeath(mob, player, isKiller)
    local mobX = mob:getXPos()
    local mobY = mob:getYPos()
    local mobZ = mob:getZPos()
  if (IsMobDead(16929046)==true and IsMobDead(16929047)==true and IsMobDead(16929048)==true and IsMobDead(16929049)==true and IsMobDead(16929050)==true and IsMobDead(16929051)==true) then
       GetNPCByID(16928768+71):setPos(mobX, mobY, mobZ)
    GetNPCByID(16928768+71):setStatus(tpz.status.NORMAL)
    GetNPCByID(16928770+471):setStatus(tpz.status.NORMAL)
  end
end
