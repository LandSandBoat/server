-----------------------------------
-- Area: Ro'Maeve
--  NPC: qm3 (Moongate Pass QM)
-- !pos -277.651, -3.765, -17.895 122 and many <pos>
-----------------------------------
local ID = require("scripts/zones/RoMaeve/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.MOONGATE_PASS) then
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    else
        local moongateQMLocations =
        {
            { -277.651, -3.765, -17.895 },
            {  264.681,  4.000, -52.630 },
            {  278.402,  4.993,  -3.200 },
            {  151.779,  4.719,  68.553 },
            { -134.518,  4.000, 106.042 },
        }
        npcUtil.giveKeyItem(player, xi.ki.MOONGATE_PASS)
        npc:hideNPC(1800)
        local newPosition = npcUtil.pickNewPosition(npc:getID(), moongateQMLocations, true)
        npc:setPos(newPosition.x, newPosition.y, newPosition.z)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
