-----------------------------------
-- Area: Windurst Walls
--  Door: Priming Gate
--  Involved in quest: Toraimarai Turmoil
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    X = player:getXPos()
    Z = player:getZPos()

    if ((X >= 1.51 and X <= 9.49) and (Z >= 273.1 and Z <= 281)) then
        if player:hasKeyItem(tpz.ki.RHINOSTERY_CERTIFICATE) then
            player:startEvent(401)
        else
            player:startEvent(264)
        end
    else
        player:startEvent(395)
    end
    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
