-----------------------------------
-- Area: Castle Oztroja
--  NPC: _479 (Brass Door)
-- Involved in Mission "Saintly Invitation"
-- !pos -99 -59 84 151
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local zPos = player:getZPos()

    if
        npcUtil.tradeHas(trade, 1142) and
        player:hasKeyItem(xi.ki.BALGA_CHAMPION_CERTIFICATE) and
        zPos >= 80 and zPos < 86
    then
        npc:openDoor(2.5)
        player:confirmTrade()
    else
        player:messageSpecial(ID.text.ITS_LOCKED)
    end
end

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == xi.anim.CLOSE_DOOR then
        player:messageSpecial(ID.text.ITS_LOCKED)
        return 1
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
