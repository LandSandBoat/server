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
    GetNPCByID(ID.npc[2][2].SOCKET, instance):setStatus(tpz.status.DISAPPEAR)
end

entity.onMobDeath = function(mob, player, isKiller)
    local CELL = mob:getLocalVar("Cell")
    local AMOUNT = mob:getLocalVar("Qnt") *2

    while AMOUNT > 0 do
        player:addTreasure(CELL)
        AMOUNT = AMOUNT -1
    end
end

entity.onMobDespawn = function(mob)
end

return entity
