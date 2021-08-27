-----------------------------------
-- Area: Xarcabard
--  NPC: qm6 (???)
-- Involved in Quests: RNG AF3 - Unbridled Passion
-- !pos -254.883 -17.003 -150.818 112
-----------------------------------
local ID = require("scripts/zones/Xarcabard/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local unbridledPassionCS = player:getCharVar("unbridledPassion")

    if unbridledPassionCS == 5 then
        player:startEvent(6, 0, 13360)
    elseif unbridledPassionCS == 6 then
        player:startEvent(7)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 6 then
        player:setCharVar("unbridledPassion", 6)
    elseif csid == 7 and npcUtil.giveItem(player, xi.items.ICE_ARROW) then
        player:setCharVar("unbridledPassion", 7)
    end
end

return entity
