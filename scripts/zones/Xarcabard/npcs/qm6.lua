-----------------------------------
-- Area: Xarcabard
--  NPC: qm6 (???)
-- Involved in Quests: RNG AF3 - Unbridled Passion
-- !pos -254.883 -17.003 -150.818 112
-----------------------------------
local ID = require("scripts/zones/Xarcabard/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local unbridledPassionCS = player:getCharVar("unbridledPassion")

    if unbridledPassionCS == 5 then
        player:startEvent(6, 0, 13360)
    elseif unbridledPassionCS == 6 then
        player:startEvent(7)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 6 then
        player:setCharVar("unbridledPassion", 6)
    elseif csid == 7 and npcUtil.giveItem(player, 17323) then
        player:setCharVar("unbridledPassion", 7)
    end
end
