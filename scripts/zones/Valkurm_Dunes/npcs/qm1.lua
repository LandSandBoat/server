-----------------------------------
-- Area: Valkurm Dunes
--  NPC: qm1 (???)
-- Involved In Quest: An Empty Vessel and Stardust
-- !pos 238.524 2.661 -148.784 103
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- NOTE: the NPC is despawned when weather is not up, we do NOT need to check weather.

    -- Already got sunsand
    if not player:needToZone() then
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)

    -- its go time
    elseif player:getFreeSlotsCount() > 0 then
        player:addItem(503)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 503)
        player:needToZone(true)

    -- no room!
    else
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 503)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
