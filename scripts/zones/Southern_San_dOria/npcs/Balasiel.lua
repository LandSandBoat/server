-----------------------------------
-- Area: Southern San d'Oria (230)
--  NPC: Balasiel
-- Starts and Finishes: A Squire's Test, A Squire's Test II, A Knight's Test, Methods Create Madness
-- !pos -136 -11 64 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/events/starlight_celebrations")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
        if xi.events.starlightCelebration.npcGiftsNpcOnTrigger(player, 4) then
            return
        end
    end
end

entity.onEventFinish = function(player, csid, option)
end

--    player:startEvent(32690)     -- starlight celebration

return entity
