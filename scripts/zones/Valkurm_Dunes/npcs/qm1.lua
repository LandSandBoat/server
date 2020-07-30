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

    if (player:getFreeSlotsCount() > 0 and player:hasItem(503) == false) then
        player:addItem(503)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 503)
    else
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 503)
    end

end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)
end
