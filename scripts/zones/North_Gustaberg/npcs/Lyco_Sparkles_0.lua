-----------------------------------
-- Area: North Gustaberg
--  NPC: Lycopodium Teleport 0
-- !pos -281.182 40.113 263.102 106
-----------------------------------
local ID = zones[xi.zone.NORTH_GUSTABERG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if utils.mask.getBit(player:getCharVar('LycopodiumTeleport_Mask'), 2) then
        local validFlowers = { 948, 949, 956, 957, 958, 959, 1120, 1410, 1411, 1413, 1725, 2554 }
        for i = 1, #validFlowers do
            if npcUtil.tradeHasExactly(trade, validFlowers[i]) then
                player:startEvent(264)
                break
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    if utils.mask.getBit(player:getCharVar('LycopodiumTeleport_Mask'), 2) then
        player:startEvent(263)
    else
        player:messageSpecial(ID.text.SPARKLING_LIGHT)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 264 then
        player:confirmTrade()
    end
end

return entity
