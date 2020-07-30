-----------------------------------
-- Area: Crawlers Nest [S]
--  NPC: Kalsu-Kalasu
-- !pos 304.768 -33.519 -19.168 171
-- Notes: Gives Green Letter required to start "Snake on the plains"
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Crawlers_Nest_[S]/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:getCampaignAllegiance() > 0) then
        if (player:getCampaignAllegiance() == 2) then
            player:startEvent(3)
        else
            -- message for other nations missing
            player:startEvent(3)
        end
    elseif (player:hasKeyItem(tpz.ki.GREEN_RECOMMENDATION_LETTER) == true) then
        player:startEvent(2)
    elseif (player:hasKeyItem(tpz.ki.GREEN_RECOMMENDATION_LETTER) == false) then
        player:startEvent(1)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 1 and option == 0) then
        player:addKeyItem(tpz.ki.GREEN_RECOMMENDATION_LETTER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.GREEN_RECOMMENDATION_LETTER)
    end
end
