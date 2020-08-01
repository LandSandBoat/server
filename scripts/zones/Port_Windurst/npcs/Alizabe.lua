-----------------------------------
-- Area: Port Windurst
--  NPC: Alizabe
--  Tavnazian Archipelago Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCurrentMission(COP) >= tpz.mission.id.cop.THE_SAVAGE then
        if GetRegionOwner(tpz.region.TAVNAZIANARCH) ~= tpz.nation.WINDURST then
            player:showText(npc, ID.text.ALIZABE_CLOSED_DIALOG)
        else
            local stock =
            {
                1523,  290,    -- Apple Mint
                5164, 1945,    -- Ground Wasabi
                17005,  99,    -- Lufaise Fly
                5195,  233,    -- Misareaux Parsley
                1695,  920,    -- Habanero Peppers
            }

            player:showText(npc, ID.text.ALIZABE_OPEN_DIALOG)
            tpz.shop.general(player, stock, WINDURST)
        end
    else
        player:showText(npc, ID.text.ALIZABE_COP_NOT_COMPLETED)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
