-----------------------------------
-- Area: Upper Jeuno
--  NPC: Mapitoto
-- Type: Full Speed Ahead Mount NPC
-- !pos -54.310 8.200 85.940 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/chocobo")
require("scripts/globals/keyitems")
require("scripts/globals/status")
-----------------------------------

function onTrade(player,npc,trade)
end

function onTrigger(player,npc)
    if
      player:hasKeyItem(tpz.ki.CHOCOBO_LICENSE) and
      player:getMainLvl() >= 20 and
      player:hasKeyItem(tpz.ki.MAP_OF_THE_JEUNO_AREA)
    then
        -- Raptor riding minigame
        -- player:startEvent(10223)
    else
        player:startEvent(10222)
    end
end

function onEventUpdate(player,csid,option)
end

function onEventFinish(player,csid,option)
end
