-----------------------------------
-- Area: Giddeus
--  NPC: Ghoo Pakya
-- Involved in Mission 1-3
-- !pos -139 0 147 145
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/missions")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getCurrentMission(WINDURST) == xi.mission.id.windurst.THE_PRICE_OF_PEACE) then
        if (player:hasKeyItem(xi.ki.DRINK_OFFERINGS)) then
            -- We have the offerings
            player:startEvent(49)
        else
            if (player:getCharVar("ghoo_talk") == 1) then
                -- npc: You want your offering back?
                player:startEvent(50)
            elseif (player:getCharVar("ghoo_talk") == 2) then
                -- npc: You'll have to crawl back to treasure chamber, etc
                player:startEvent(51)
            else
                -- We don't have the offerings yet or anymore
                player:startEvent(52)
            end
        end
    else
        player:startEvent(52)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 49) then
        player:delKeyItem(xi.ki.DRINK_OFFERINGS)
        player:setCharVar("ghoo_talk", 1)

        if (player:hasKeyItem(xi.ki.FOOD_OFFERINGS) == false) then
            player:setMissionStatus(player:getNation(), 2)
        end
    elseif (csid == 50) then
        player:setCharVar("ghoo_talk", 2)
    end

end

return entity
