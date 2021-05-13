-----------------------------------
-- Zone Global
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
-----------------------------------
local zoneUtil = {}

zoneUtil.exterminationRandomSpawn = function(mob, ID)
    local spawnPoints =
        {
            [1]  = {189.410,  -3.663, 102.417, 145},
            [2]  = {323.574,  -6.361, 261.256,   0},
            [3]  = {111.220, -10.232, -26.560, 188},
            [4]  = {491.285,  -5.183, 303.974,  90},
        }

    local sPoint = math.random(1, #spawnPoints)
    local instance = mob:getInstance()
    local NM = instance:getEntity(bit.band(ID, 0xFFF), xi.objType.MOB)
    local spawnNM = math.random(100)

    if spawnNM <= 20 and NM:getLocalVar("NMSpawned") == 0 then
        NM:setSpawn(spawnPoints[sPoint])
        SpawnMob(ID, instance)
        NM:setLocalVar("NMSpawned", 1)
        instance:setProgress(instance:getProgress() - 1)
    end
end

return zoneUtil
