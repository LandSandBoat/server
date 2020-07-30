-----------------------------------
-- Area: Apollyon SE
--  Mob: Adamantshell
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

 if (mobID ==16933008) then --
       GetNPCByID(16932864+232):setPos(108, -1, -518)
    GetNPCByID(16932864+232):setStatus(tpz.status.NORMAL)
 elseif (mobID ==16933013) then --
       GetNPCByID(16932864+233):setPos(109, -1, -521)
    GetNPCByID(16932864+233):setStatus(tpz.status.NORMAL)
 elseif (mobID ==16933007) then --
      GetNPCByID(16932864+234):setPos(112, -1, -523)
    GetNPCByID(16932864+234):setStatus(tpz.status.NORMAL)
 end

end
