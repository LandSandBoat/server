-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Eugballion
-- Only sells when San d'Oria controlls Qufim Region
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.QUFIMISLAND) ~= tpz.nation.SANDORIA then
        player:showText(npc, ID.text.EUGBALLION_CLOSED_DIALOG)
    else
        local stock =
        {
            954, 4121,    -- Magic Pot Shard
        }

        player:showText(npc, ID.text.EUGBALLION_OPEN_DIALOG)
        tpz.shop.general(player, stock, SANDORIA)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
