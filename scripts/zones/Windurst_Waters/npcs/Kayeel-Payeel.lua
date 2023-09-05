-----------------------------------
-- Area: Windurst Waters
--  NPC: Kayeel-Payeel
-----------------------------------
require("scripts/globals/events/starlight_celebrations")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        if xi.events.starlightCelebration.npcGiftsNpcOnTrigger(player, 1) then
            return
        end
    end

    player:startEvent(975)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
