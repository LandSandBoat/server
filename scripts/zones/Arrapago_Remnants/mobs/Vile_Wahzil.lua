-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Vile Wahzil
-----------------------------------
local ID = require("scripts/zones/Arrapago_Remnants/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    local instance = mob:getInstance()
    instance:getEntity(bit.band(ID.npc[2][2].SOCKET, 0xFFF), tpz.objType.NPC):setStatus(tpz.status.DISAPPEAR)
end

function onMobDeath(mob, player, isKiller)
    local CELL = mob:getLocalVar("Cell")
    local AMOUNT = mob:getLocalVar("Qnt") *2

    while AMOUNT > 0 do
        player:addTreasure(CELL)
        AMOUNT = AMOUNT -1
    end
end

function onMobDespawn(mob)
end
