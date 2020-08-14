-----------------------------------
-- Area: Mhaura
--  NPC: Koh Lenbalalako
-- Type: Standard NPC
-- !pos -64.412 -17 29.213 249
-----------------------------------
local ID = require("scripts/zones/Mhaura/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)

    if (trade:hasItemQty(13315, 1) and trade:getItemCount() == 1) then -- Trade gold earring (during Rng AF3 quest)
        local UnbridledPassionCS = player:getCharVar("unbridledPassion")
        if (UnbridledPassionCS == 2) then
            player:startEvent(10011)
        end
    end

end

function onTrigger(player, npc)

    local FireAndBrimstoneCS = player:getCharVar("fireAndBrimstone")
    local UnbridledPassionCS = player:getCharVar("unbridledPassion")

    -- during RNG af2
    if (FireAndBrimstoneCS == 1) then
        player:startEvent(10007)

    -- during RNG af3
    elseif (UnbridledPassionCS == 1) then
        player:startEvent(10009, 0, 13360, 13315)
    elseif (UnbridledPassionCS == 2) then
        player:startEvent(10010, 0, 0, 13315)
    elseif (UnbridledPassionCS == 3) then
        player:startEvent(10012)

    else
        player:startEvent(10013)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10007) then
        player:startEvent(10032)
        player:setCharVar("fireAndBrimstone", 2)
    elseif (csid == 10009) then
        player:setCharVar("unbridledPassion", 2)
    elseif (csid == 10011) then
        player:addKeyItem(tpz.ki.KOHS_LETTER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.KOHS_LETTER)
        player:tradeComplete()
        player:setCharVar("unbridledPassion", 3)
    end
end
