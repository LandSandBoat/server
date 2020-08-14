-----------------------------------
-- Area: Giddeus
--  NPC: Laa Mozi
-- Involved in Mission 1-3
-- !pos -22 0 148 145
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/missions")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_PRICE_OF_PEACE) then
        if (player:hasKeyItem(tpz.ki.FOOD_OFFERINGS)) then
            -- We have the offerings
            player:startEvent(45)
        else
            if (player:getCharVar("laa_talk") == 1) then
                -- npc: You want your offering back?
                player:startEvent(46)
            elseif (player:getCharVar("laa_talk") == 2) then
                -- npc: You'll have to crawl back to treasure chamber, etc
                player:startEvent(47)
            else
                -- We don't have the offerings yet or anymore
                player:startEvent(48)
            end
        end
    else
        player:startEvent(48)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 45) then
        player:delKeyItem(tpz.ki.FOOD_OFFERINGS)
        player:setCharVar("laa_talk", 1)

        if (player:hasKeyItem(tpz.ki.DRINK_OFFERINGS) == false) then
            player:setCharVar("MissionStatus", 2)
        end
    elseif (csid == 46) then
        player:setCharVar("laa_talk", 2)
    end

end
