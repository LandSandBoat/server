-----------------------------------
-- Area: The Eldieme Necropolis [S]
--  NPC: Turbulent Storm
-- Note: Starts Quest "The Fighting Fourth"
-- !pos 422.461 -48.000 175
-----------------------------------
local ID = require("scripts/zones/The_Eldieme_Necropolis_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCampaignAllegiance() > 0) then
        if (player:getCampaignAllegiance() == 2) then
            player:startEvent(9)
        else
            -- message for other nations missing
            player:startEvent(9)
        end
    elseif (player:hasKeyItem(tpz.ki.RED_RECOMMENDATION_LETTER) == true) then
        player:startEvent(8)
    elseif (player:hasKeyItem(tpz.ki.RED_RECOMMENDATION_LETTER) == false) then
        player:startEvent(7)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 7 and option == 0) then
        player:addKeyItem(tpz.ki.BLUE_RECOMMENDATION_LETTER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.BLUE_RECOMMENDATION_LETTER)
    end
end
