-----------------------------------
-- Area: Valkurm Dunes
--  NPC: qm1 (???)
-- Involved In Quest: An Empty Vessel
-- !pos 238.524 2.661 -148.784 103
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    -- NOTE: the NPC is despawned when weather is not up, we do NOT need to check weather.

    -- Already got sunsand
    if player:getLocalVar("gotSunSand") > 0 then
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)

    -- its go time
    elseif player:getFreeSlotsCount() > 0 and not player:hasItem(503) then
        player:addItem(503)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 503)
        player:setLocalVar("gotSunSand", 1)

    -- no room!
    else
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 503)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
