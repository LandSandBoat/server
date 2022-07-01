-----------------------------------
-- Area: Garlaige Citadel [S]
--  NPC: Randecque
-- !pos 61 -6 137 164
-- Notes: Gives Red Letter required to start "Steamed Rams"
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Garlaige_Citadel_[S]/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getCampaignAllegiance() > 0) then
        if (player:getCampaignAllegiance() == 2) then
            player:startEvent(3)
        else
            -- message for other nations missing
            player:startEvent(3)
        end
    elseif (player:hasKeyItem(xi.ki.RED_RECOMMENDATION_LETTER) == true) then
        player:startEvent(2)
    elseif (player:hasKeyItem(xi.ki.RED_RECOMMENDATION_LETTER) == false) then
        player:startEvent(1)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 1 and option == 0) then
        player:addKeyItem(xi.ki.RED_RECOMMENDATION_LETTER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.RED_RECOMMENDATION_LETTER)
    end
end

return entity
