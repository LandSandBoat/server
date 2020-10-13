-----------------------------------
-- Area: Port San d'Oria
--  NPC: Deguerendars
-- Tavnazian Archipelago Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/missions")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCurrentMission(COP) >= tpz.mission.id.cop.THE_SAVAGE then
        if GetRegionOwner(tpz.region.TAVNAZIANARCH) ~= tpz.nation.SANDORIA then
            player:showText(npc, ID.text.DEGUERENDARS_CLOSED_DIALOG)
        else
            local stock =
            {
                1523,  290,    -- Apple Mint
                5164, 1945,    -- Ground Wasabi
                17005,  99,    -- Lufaise Fly
                5195,  233,    -- Misareaux Parsley
                1695,  920,    -- Habanero Peppers
            }

            player:showText(npc, ID.text.DEGUERENDARS_OPEN_DIALOG)
            tpz.shop.general(player, stock, SANDORIA)
        end
    else
        player:showText(npc, ID.text.DEGUERENDARS_COP_NOT_COMPLETED)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
