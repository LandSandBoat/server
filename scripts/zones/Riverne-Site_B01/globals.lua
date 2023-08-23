-- Zone: Riverne - Site #B01 (29)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------

local riverneB01Global =
{
    --[[..............................................................................................
        trade to unstable displacement NPC
        ..............................................................................................]]
    unstableDisplacementTrade = function(player, npc, trade)
        if npcUtil.tradeHas(trade, xi.item.GIANT_SCALE) then
            player:confirmTrade()
            npc:openDoor(xi.settings.main.RIVERNE_PORTERS)
            player:messageSpecial(ID.text.SD_HAS_GROWN)
        end
    end,

    --[[..............................................................................................
        click on unstable displacement NPC
        ..............................................................................................]]
    unstableDisplacementTrigger = function(player, npc, event)
        if npc:getAnimation() == xi.anim.OPEN_DOOR then
            player:startEvent(event)
        else
            player:messageSpecial(ID.text.SD_VERY_SMALL)
        end
    end,

}

return riverneB01Global
