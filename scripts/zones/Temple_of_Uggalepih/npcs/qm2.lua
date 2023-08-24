-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: ??? (Uggalepih Offering ITEM)
-- !pos 388 0 269 159
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        npc:getStatus() == xi.status.NORMAL and
        not player:hasItem(xi.items.OFFERING_TO_UGGALEPIH)
    then
        if npcUtil.giveItem(player, xi.items.OFFERING_TO_UGGALEPIH) then -- Uggalepih Offering
            local positions =
            {
                { 393.78, -0.30, 272.287 },
                { 393.78, -0.30, 247.382 },
                { 373.88, -0.30, 247.382 },
                { 373.88, -0.30, 272.287 },
                { 313.59, 0.00, 230.870 },
                { 293.92, 0.00, 230.870 },
            }
            local newPosition = npcUtil.pickNewPosition(npc:getID(), positions)
            npc:setStatus(xi.status.DISAPPEAR)
            npc:setPos(newPosition.x, newPosition.y, newPosition.z)
            npc:updateNPCHideTime(math.random(900, 7200)) -- 15 minutes to 2 hours
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
