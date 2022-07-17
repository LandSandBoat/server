-----------------------------------
-- Zone: Abyssea-Attohwa
--  NPC: qm23 (???)
-- Spawns Titlacauan
-- !pos -396.937 -3.000 259.001 215
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/keyitems')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- xi.abyssea.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local ID = zones[player:getZoneID()]
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.TITLACAUAN_2, { xi.ki.BLOTCHED_DOOMED_TONGUE, xi.ki.CRACKED_SKELETON_CLAVICLE, xi.ki.WRITHING_GHOST_FINGER, xi.ki.RUSTED_HOUND_COLLAR })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
