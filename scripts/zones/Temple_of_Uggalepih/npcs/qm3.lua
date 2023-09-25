-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: ??? (Uggalepih Whistle ITEM)
-- !pos -150 0 -71 159
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
        not player:hasItem(xi.items.UGGALEPIH_WHISTLE)
    then
        if npcUtil.giveItem(player, xi.items.UGGALEPIH_WHISTLE) then -- Uggalepih Whistle
            local positions =
            {
                { -133.47, -0.33, -49.15 },
                { -126.28, -0.33, -70.98 },
                { -146.74, -0.33, -71.02 },
                { -153.58, -0.33, -49.08 },
            }
            local newPosition = npcUtil.pickNewPosition(npc:getID(), positions)
            npc:setStatus(xi.status.DISAPPEAR)
            npc:setPos(newPosition.x, newPosition.y, newPosition.z)
            npc:updateNPCHideTime(7200) -- 2 hours
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity
