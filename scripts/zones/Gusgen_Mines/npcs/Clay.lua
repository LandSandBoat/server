-----------------------------------
-- Area: Gusgen Mines
--  NPC: Clay
-- Involved in Quest: A Potter's Preference
-- !pos 117 -21 432 196
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/settings")
local ID = require("scripts/zones/Gusgen_Mines/IDs")
-----------------------------------

function onTrade(player, npc, trade)

end

function onTrigger(player, npc)
    local GUSGENCLAY = 569

    if (player:hasItem(GUSGENCLAY) == false) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, GUSGENCLAY)
        else
            player:addItem(GUSGENCLAY)
            player:messageSpecial(ID.text.ITEM_OBTAINED, GUSGENCLAY)
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
