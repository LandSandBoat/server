-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Ailbeche
-- Starts and Finishes Quest: Father and Son, Sharpening the Sword, A Boy's Dream (start)
-- !pos 4 -1 24 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/events/starlight_celebrations")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        if xi.events.starlightCelebration.onStarlightSmilebringersTrade(player, trade, npc) then
            return
        end
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
