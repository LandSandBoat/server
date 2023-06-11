-----------------------------------
-- Area: Misareaux_Coast
--  NPC: ??? (Spawn Gration)
-- !pos 113.563 -16.302 38.912 25
-----------------------------------
local ID = require("scripts/zones/Misareaux_Coast/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local shieldChance = 0
    if npcUtil.tradeHasExactly(trade, xi.items.HICKORY_SHIELD) then
        shieldChance = 500
        npc:setLocalVar("shield", 1)
    elseif npcUtil.tradeHasExactly(trade, xi.items.PICAROONS_SHIELD) then
        shieldChance = 1000
        npc:setLocalVar("shield", 2)
    end

    if
        shieldChance > 0 and
        npcUtil.popFromQM(player, npc, ID.mob.GRATION)
    then
        player:confirmTrade()
        GetMobByID(ID.mob.GRATION):setLocalVar("DropRate", shieldChance)
        if npc:getLocalVar("shield") == 1 then
            player:messageSpecial(ID.text.SNATCHED_AWAY, xi.items.HICKORY_SHIELD)
        else
            player:messageSpecial(ID.text.SNATCHED_AWAY, xi.items.PICAROONS_SHIELD)
        end
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SHATTERED_SHIELD)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
