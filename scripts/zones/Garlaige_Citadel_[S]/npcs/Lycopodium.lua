-----------------------------------
-- Area: Garlaige Citadel [S]
--  NPC: Lycopodium
-- !pos -96.753 -1.000 -167.332 164
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel_[S]/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.LYCOPODIUM_ENTRANCED)

    if not utils.mask.getBit(player:getCharVar("LycopodiumTeleport_Mask"), 0) then
        player:startEvent(30)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 30 then
        player:setCharVar("LycopodiumTeleport_Mask", utils.mask.setBit(player:getCharVar("LycopodiumTeleport_Mask"), 0, true))
    end
end

return entity
