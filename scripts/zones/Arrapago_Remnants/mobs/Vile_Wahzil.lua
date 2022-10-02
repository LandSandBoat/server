-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Vile Wahzil
-----------------------------------
local ID = require("scripts/zones/Arrapago_Remnants/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    local instance = mob:getInstance()
    GetNPCByID(ID.npc[2][2].SOCKET, instance):setStatus(xi.status.DISAPPEAR)
end

entity.onMobDeath = function(mob, player, optParams)
    local cellType = mob:getLocalVar("Cell")
    local numCells = mob:getLocalVar("Qnt") * 2

    while numCells > 0 do
        player:addTreasure(cellType)
        numCells = numCells -1
    end
end

entity.onMobDespawn = function(mob)
end

return entity
