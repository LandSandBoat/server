-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Banishing Gate #1
-- !pos -201.000 -2.994 220 200
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:hasKeyItem(xi.ki.POUCH_OF_WEIGHTED_STONES) == false or player:getXPos() > -201) then
        player:messageSpecial(ID.text.A_GATE_OF_STURDY_STEEL)
        return 1
    else
        local DoorID = npc:getID()

        for i = DoorID, DoorID+4, 1 do
            GetNPCByID(i):openDoor(30)
        end
        player:messageSpecial(ID.text.BANISHING_GATES) -- First Banishing gate opening
        return 1
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
