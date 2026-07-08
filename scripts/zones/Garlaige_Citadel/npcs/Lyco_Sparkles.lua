-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Lycopodium Teleport
-- !pos -176.759 -1.249 71.511 200
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if utils.mask.getBit(player:getCharVar('LycopodiumTeleport_Mask'), 0) then
        local validFlowers = { 948, 949, 956, 957, 958, 959, 1120, 1410, 1411, 1413, 1725, 2554 }
        for i = 1, #validFlowers do
            if npcUtil.tradeHasExactly(trade, validFlowers[i]) then
                player:startEvent(101)
                break
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    if utils.mask.getBit(player:getCharVar('LycopodiumTeleport_Mask'), 0) then
        player:startEvent(100)
    else
        player:messageSpecial(ID.text.SPARKLING_LIGHT)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 101 then
        player:confirmTrade()
    end
end

return entity
