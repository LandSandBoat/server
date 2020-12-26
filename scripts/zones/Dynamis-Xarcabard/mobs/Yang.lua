-----------------------------------
-- Area: Dynamis - Xarcabard
--   NM: Yang
-----------------------------------
local ID = require("scripts/zones/Dynamis-Xarcabard/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob, target)
end

function onMobSpawn(mob)
    local dynaLord = GetMobByID(ID.mob.DYNAMIS_LORD)
    if (dynaLord:getLocalVar("physImmune") < 2) then -- both dragons have not been killed initially
        dynaLord:setMod(tpz.mod.UDMGPHYS, -100)
        dynaLord:setMod(tpz.mod.UDMGRANGE, -100)
        dynaLord:setLocalVar("physImmune", 0)
        mob:setSpawn(-364, -35.974, 24.254) -- Reset Yang's spawn point to initial spot.
    else
        mob:setSpawn(-414.282, -44, 20.427) -- Spawned by DL, reset to DL's spawn point.
    end
end

function onMobFight(mob, target)
    -- Repop Ying every 30 seconds if Yang is up and Ying is not.
    local ying = GetMobByID(ID.mob.YING)
    local YingToD = mob:getLocalVar("YingToD")
    if ying:getCurrentAction() == tpz.act.NONE and os.time() > YingToD+30 then
        ying:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
        ying:spawn()
        ying:updateEnmity(target)
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local Ying = GetMobByID(ID.mob.YING)
    local dynaLord = GetMobByID(ID.mob.DYNAMIS_LORD)
    -- localVars clear on death, so setting it on its partner
    Ying:setLocalVar("YangToD", os.time())
    if (dynaLord:getLocalVar("physImmune") == 0) then
        dynaLord:setMod(tpz.mod.UDMGPHYS, 0)
        dynaLord:setMod(tpz.mod.UDMGRANGE, 0)
        if (dynaLord:getLocalVar("magImmune") == 1) then -- other dragon is also dead
            dynaLord:setLocalVar("physImmune", 2)
            dynaLord:setLocalVar("magImmune", 2)
        else
            dynaLord:setLocalVar("physImmune", 1)
        end
    end
end
