-----------------------------------
-- Area: Arrapago Remnants
-- NPC: Socket
-- Trade Slavage Cells to pop Wahzil
-- Wahzil drops 2x the Cells traded
-----------------------------------
local ID = require("scripts/zones/Arrapago_Remnants/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    local instance = npc:getInstance()
    local mob = instance:getEntity(bit.band(ID.mob[2][3].wahzil, 0xFFF), tpz.objType.MOB)
    local COUNT = trade:getItemCount()
    local INCUS_CELL = 5365
    local SPISSATUS_CELL = 5384

    for i = INCUS_CELL, SPISSATUS_CELL do
        if COUNT <= 5 and trade:hasItemQty(i, COUNT) then
            SpawnMob(ID.mob[2][3].wahzil, instance):updateClaim(player)
            player:tradeComplete()
            mob:setLocalVar("Cell", i)
            mob:setLocalVar("Qnt", COUNT)
        end
    end
end

function onTrigger(entity, npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(entity, eventid, result)
end
