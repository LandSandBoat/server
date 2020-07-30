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

function onTrade(player, npc, trade)
    if (trade:hasItemQty(502, 1) == true and trade:getItemCount() == 1) then -- Garlaige Key (Not Chest/Coffer)
        player:startEvent(4) -- Open the door
    end
end

function onTrigger(player, npc)

    local X = player:getXPos()
    local Z = player:getZPos()

    if ((X >= 135 and X <= 144) and (Z >= 128 and Z <= 135)) then
        player:startEvent(5)
    else
        player:messageSpecial(ID.text.OPEN_WITH_THE_RIGHT_KEY)
        return 0
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
