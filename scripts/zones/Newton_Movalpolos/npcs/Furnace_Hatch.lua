-----------------------------------
-- Area: Newton Movalpolos
--  NPC: Furnace_Hatch
-----------------------------------
local ID = require("scripts/zones/Newton_Movalpolos/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 947) then
        local offset = npc:getID() - ID.npc.FURNACE_HATCH_OFFSET
        player:confirmTrade()
        player:startEvent(21 + offset) -- THUD!

        -- trading to any hatch toggles all doors zone-wide
        local doorOffset = ID.npc.DOOR_OFFSET
        for i = doorOffset, doorOffset + 11 do
            local door = GetNPCByID(i)
            door:setAnimation((door:getAnimation() == xi.anim.OPEN_DOOR) and xi.anim.CLOSE_DOOR or xi.anim.OPEN_DOOR)
        end
    else
        player:startEvent(20) -- no firesand message
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(20) -- no firesand message
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
