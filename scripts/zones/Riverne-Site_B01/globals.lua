-- Zone: Riverne - Site #B01 (29)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------

RIVERNE_SITE_B01 = {
    --[[..............................................................................................
        trade to unstable displacement NPC
        ..............................................................................................]]
    unstableDisplacementTrade = function(player, npc, trade)
        if (npcUtil.tradeHas(trade, 1691)) then
            player:confirmTrade()
            npc:openDoor(RIVERNE_PORTERS)
            player:messageSpecial(ID.text.SD_HAS_GROWN)
        end
    end,

    --[[..............................................................................................
        click on unstable displacement NPC
        ..............................................................................................]]
    unstableDisplacementTrigger = function(player, npc, event)
        if (npc:getAnimation() == tpz.anim.OPEN_DOOR) then
            player:startEvent(event)
        else
            player:messageSpecial(ID.text.SD_VERY_SMALL)
        end
    end,

}

return RIVERNE_SITE_B01
