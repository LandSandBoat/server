-----------------------------------
-- Area: Sea Serpent Grotto
--  NPC: Sahagin Key Door
-- !pos 40 8.6 20.012 176
-----------------------------------
local ID = require("scripts/zones/Sea_Serpent_Grotto/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, 1197) then
        npc:openDoor(8) -- Open the door if a Sahagin key has been traded
        player:messageSpecial(ID.text.SAHAGIN_DOOR_TRADED, 0, 1197) -- Give a message telling the PC the item is lost
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    local X = player:getXPos()
    local Z = player:getZPos()

    if X > 94 and Z >= 40 then
        player:messageSpecial(ID.text.SAHAGIN_DOOR_OUTSIDE) -- Give a message if standing on the "outside" of the door (closest to Norg)
    elseif X < 104 and X >= 94 and Z <= 40 then
        player:messageSpecial(ID.text.SAHAGIN_DOOR_INSIDE) -- Give a message if standing on the "inside" of the door
    end

    return 1 -- Keeps the door closed it should not open onTrigger
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
