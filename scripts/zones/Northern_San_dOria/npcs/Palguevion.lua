-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Palguevion
-- Only sells when San d'Oria controlls Valdeaunia Region
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.VALDEAUNIA) ~= tpz.nation.SANDORIA then
        player:showText(npc, ID.text.PALGUEVION_CLOSED_DIALOG)
    else
        local stock =
        {
            4382,  29,    -- Frost Turnip
            638,  170,    -- Sage
        }

        player:showText(npc, ID.text.PALGUEVION_OPEN_DIALOG)
        tpz.shop.general(player, stock, SANDORIA)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
