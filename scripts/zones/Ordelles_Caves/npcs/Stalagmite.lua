-----------------------------------
-- Area: Ordelles Caves
--  NPC: Stalagmite
-- Involved In Quest: Sharpening the Sword
-- !pos -51 0.1 3 193
-----------------------------------
local ID = require("scripts/zones/Ordelles_Caves/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local sharpeningTheSwordStat = player:getCharVar("sharpeningTheSwordCS")

    if sharpeningTheSwordStat == 3 and player:getCharVar("PolevikKilled") == 1 then
        npcUtil.giveKeyItem(player, xi.ki.ORDELLE_WHETSTONE)
        player:setCharVar("PolevikKilled", 0)
        player:setCharVar("sharpeningTheSwordCS", 4)
    elseif
        sharpeningTheSwordStat == 3 and
        npcUtil.popFromQM(player, npc, ID.mob.POLEVIK, { hide = 0 })
    then
        -- do nothing else
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
