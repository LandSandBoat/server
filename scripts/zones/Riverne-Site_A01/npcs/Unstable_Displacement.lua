-----------------------------------
-- Area: Riverne Site #A01
--  NPC: Unstable Displacement
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_A01/IDs")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local offset = npc:getID() - ID.npc.DISPLACEMENT_OFFSET
    if (offset == 5 and TradeBCNM(player, npc, trade)) then -- The Wyrmking Descends
        return
    end
end

entity.onTrigger = function(player, npc)
    local offset = npc:getID() - ID.npc.DISPLACEMENT_OFFSET

    -- OURYU COMETH
    if (offset == 5) then
        player:messageSpecial(ID.text.SPACE_SEEMS_DISTORTED)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
