-----------------------------------
-- Area: Cloister of Tremors
--  NPC: qm2 (???)
-- Involved in Quest: Open Sesame
-- Notes: Used to obtain a Tremor Stone
-- !pos -545.184, 1.855, -495.693 209
-----------------------------------
require("scripts/globals/settings")
local ID = require("scripts/zones/Cloister_of_Tremors/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local TREMORSTONE = 2796

    -- Give Player a Tremorstone if they don't have one
    if (player:hasItem(TREMORSTONE) == false) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, TREMORSTONE)
        else
            player:addItem(TREMORSTONE)
            player:messageSpecial(ID.text.ITEM_OBTAINED, TREMORSTONE)
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)
end
