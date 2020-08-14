-----------------------------------
-- Area: Attohwa Chasm
--  NPC: Jakaka
-- Type: ENM
-- !pos -144.711 6.246 -250.309 7
-----------------------------------
local ID = require("scripts/zones/Attohwa_Chasm/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
    -- Trade Parradamo Stones
    if (trade:hasItemQty(1778, 1) and trade:getItemCount() == 1) then
        player:tradeComplete()
        player:startEvent(12)
    end
end

function onTrigger(player, npc)

    local MiasmaFilterCD = player:getCharVar("[ENM]MiasmaFilter")

    if (player:hasKeyItem(tpz.ki.MIASMA_FILTER)) then
        player:startEvent(11)
    else
        if (MiasmaFilterCD >= os.time()) then
            -- Both Vanadiel time and unix timestamps are based on seconds. Add the difference to the event.
            player:startEvent(14, VanadielTime()+(MiasmaFilterCD-os.time()))
        else
            if (player:hasItem(1778) == true or player:hasItem(1777) == true) then -- Parradamo Stones, Flaxen Pouch
                player:startEvent(15)
            else
                player:startEvent(13)
            end
        end
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 12) then
        player:addKeyItem(tpz.ki.MIASMA_FILTER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MIASMA_FILTER)
        player:setCharVar("[ENM]MiasmaFilter", os.time()+(ENM_COOLDOWN*3600)) -- Current time + (ENM_COOLDOWN*1hr in seconds)
    elseif (csid == 13) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1777) -- Flaxen Pouch
            return
        else
            player:addItem(1777)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1777) -- Flaxen Pouch
        end
    end
end
