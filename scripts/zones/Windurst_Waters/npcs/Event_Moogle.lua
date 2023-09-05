-----------------------------------
-- Area: Windurst Waters
--  NPC: Moogle
-- Type: Special Events Moogle
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/events/starlight_celebrations")
require("scripts/globals/utils")
require("scripts/globals/npc_util")
-----------------------------------

local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if npc:getID() == 17752551 then
        if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
            xi.events.starlightCelebration.npcGiftsMoogleOnTrigger(player)
        end
    else
        if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
            xi.events.starlightCelebration.merryMakersMoogleOnTrigger(player, npc)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        if csid == 32703 or csid == 32702 then
            xi.events.starlightCelebration.npcGiftsMoogleOnFinish(player, ID, csid, option)
        elseif csid == 4702 then
            xi.events.starlightCelebration.merryMakersMoogleOnFinish(player, ID, csid, option)
        end
    end
end

return entity
