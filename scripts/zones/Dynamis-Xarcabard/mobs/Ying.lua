-----------------------------------
-- Area: Dynamis - Xarcabard
--   NM: Ying
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob, target)
end

function onMobSpawn(mob)
    local dynaLord = GetMobByID(17330177)
    if (dynaLord:getLocalVar("magImmune") < 2) then -- both dragons have not been killed initially
        dynaLord:setMod(tpz.mod.UDMGMAGIC, -100)
        dynaLord:setMod(tpz.mod.UDMGBREATH, -100)
        dynaLord:setLocalVar("magImmune", 0)
        mob:setSpawn(-364, -35.661, 17.254) -- Reset Ying's spawn point to initial spot.
    else
        mob:setSpawn(-414.282, -44, 20.427) -- Spawned by DL, reset to DL's spawn point.
    end
end

function onMobFight(mob, target)
    local YangID = 17330184
    local YangToD = mob:getLocalVar("YangToD")
    -- Repop Yang every 30 seconds if Ying is up and Yang is not.
    if (GetMobAction(YangID) == tpz.act.NONE and os.time() > YangToD+30) then
        GetMobByID(YangID):setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
        SpawnMob(YangID):updateEnmity(target)
    end
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local Yang = GetMobByID(17330184)
    local dynaLord = GetMobByID(17330177)
    -- localVars clear on death, so setting it on its partner
    Yang:setLocalVar("YingToD", os.time())
    if (dynaLord:getLocalVar("magImmune") == 0) then
        dynaLord:setMod(tpz.mod.UDMGMAGIC, 0)
        dynaLord:setMod(tpz.mod.UDMGBREATH, 0)
        if (dynaLord:getLocalVar("physImmune") == 1) then -- other dragon is also dead
            dynaLord:setLocalVar("physImmune", 2)
            dynaLord:setLocalVar("magImmune", 2)
        else
            dynaLord:setLocalVar("magImmune", 1)
        end
    end
end
