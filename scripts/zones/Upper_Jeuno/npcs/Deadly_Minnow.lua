-----------------------------------
-- Area: Upper Jeuno
--  NPC: Deadly Minnow
-- Standard Merchant NPC
-- Involved in Quest: Borghertz's Hands (1st quest only)
-- !pos -5 1 48 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if player:getCharVar("BorghertzHandsFirstTime") == 1 then
        player:startEvent(24)
        player:setCharVar("BorghertzHandsFirstTime", 2)
    else
        local stock =
        {
            12442, 13179,    -- Studded Bandana
            12425, 22800,    -- Silver Mask
            12426, 47025,    -- Banded Helm
            12570, 20976,    -- Studded Vest
            12553, 35200,    -- Silver Mail
            12554, 66792,    -- Banded Mail
            12698, 11012,    -- Studded Gloves
            12681, 18800,    -- Silver Mittens
            12672, 23846,    -- Gauntlets
            12682, 35673,    -- Mufflers
        }

        player:showText(npc, ID.text.DEADLYMINNOW_SHOP_DIALOG)
        tpz.shop.general(player, stock)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
