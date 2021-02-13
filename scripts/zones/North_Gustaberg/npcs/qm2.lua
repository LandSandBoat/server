-----------------------------------
-- Area: North Gustaberg
--  NPC: qm2 (???)
-- Involved in Quest "As Thick As Thieves"
-- !pos -232.924 99.107 442.990 106
-----------------------------------
local ID = require("scripts/zones/North_Gustaberg/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local thickAsThievesGamblingCS = player:getCharVar("thickAsThievesGamblingCS")

    if thickAsThievesGamblingCS == 5 then
        npcUtil.popFromQM(player, npc, ID.mob.GAMBILOX_WANDERLING, {hide = 0})
    elseif thickAsThievesGamblingCS == 6 then
        player:startEvent(200, 1092)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 200 and npcUtil.giveItem(player, 1092) then
        player:setCharVar("thickAsThievesGamblingCS", 7)
    end
end

return entity
