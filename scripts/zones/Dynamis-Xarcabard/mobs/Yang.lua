-----------------------------------
-- Area: Dynamis - Xarcabard
--   NM: Yang
-----------------------------------
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob, target)
end

entity.onMobSpawn = function(mob)
    local dynaLord = GetMobByID(ID.mob.DYNAMIS_LORD)

    if dynaLord:getLocalVar("physImmune") < 2 then -- both dragons have not been killed initially
        dynaLord:setMod(xi.mod.UDMGPHYS, -10000)
        dynaLord:setMod(xi.mod.UDMGRANGE, -10000)
        dynaLord:setLocalVar("physImmune", 0)
        mob:setSpawn(-364, -35.974, 24.254) -- Reset Yang's spawn point to initial spot.
    else
        mob:setSpawn(-414.282, -44, 20.427) -- Spawned by DL, reset to DL's spawn point.
    end
end

entity.onMobFight = function(mob, target)
    -- Repop Ying every 30 seconds if Yang is up and Ying is not.
    local ying = GetMobByID(ID.mob.YING)
    local yingToD = mob:getLocalVar("YingToD")

    if ying:getCurrentAction() == xi.act.NONE and os.time() > yingToD + 30 then
        ying:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
        ying:spawn()
        ying:updateEnmity(target)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local ying = GetMobByID(ID.mob.YING)
    local dynaLord = GetMobByID(ID.mob.DYNAMIS_LORD)

    -- localVars clear on death, so setting it on its partner
    ying:setLocalVar("YangToD", os.time())
    if dynaLord:getLocalVar("physImmune") == 0 then
        dynaLord:setMod(xi.mod.UDMGPHYS, 0)
        dynaLord:setMod(xi.mod.UDMGRANGE, 0)
        if dynaLord:getLocalVar("magImmune") == 1 then -- other dragon is also dead
            dynaLord:setLocalVar("physImmune", 2)
            dynaLord:setLocalVar("magImmune", 2)
        else
            dynaLord:setLocalVar("physImmune", 1)
        end
    end
end

return entity
