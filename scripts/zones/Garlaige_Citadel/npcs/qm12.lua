-----------------------------------
-- Area: Garlaige Citadel
--  NPC: qm12 (???)
-- Involved in Quest: Hitting the Marquisate (THF AF3)
-- !pos -245.603 -5.500 139.855 200
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local hittingTheMarquisateHagainCS = player:getCharVar("hittingTheMarquisateHagainCS")

    if (hittingTheMarquisateHagainCS == 4) then
        player:messageSpecial(ID.text.PRESENCE_FROM_CEILING)
        player:setCharVar("hittingTheMarquisateHagainCS", 5)
    end

end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)
end
