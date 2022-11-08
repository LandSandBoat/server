-----------------------------------
-- Area: Garlaige Citadel
--  NPC: _5kr (Crematory Hatch)
-- Type: Door
-- !pos 139 -6 127 200
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/settings")
require("scripts/globals/quests")
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if trade:hasItemQty(502, 1) and trade:getItemCount() == 1 then -- Garlaige Key (Not Chest/Coffer)
        player:startEvent(4) -- Open the door
    end
end

entity.onTrigger = function(player, npc)
    local xPos = player:getXPos()
    local zPos = player:getZPos()

    if xPos >= 135 and xPos <= 144 and zPos >= 128 and zPos <= 135 then
        player:startEvent(5)
    else
        player:messageSpecial(ID.text.OPEN_WITH_THE_RIGHT_KEY)
        return 0
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
