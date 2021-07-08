-----------------------------------
-- Area: Alzadaal Undersea Ruins
-- Door: Runic Seal
-- !pos 125 -2 20 72
-----------------------------------
require("scripts/globals/instance")
local ID = require("scripts/zones/Alzadaal_Undersea_Ruins/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not xi.instance.onTrigger(player, npc, xi.zone.NYZUL_ISLE) then
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onEventUpdate = function(player, csid, option, target)
    -- If instance loading or entry fails (for you or your party):
    -- Force the Nyzul Isle loop to bail out
    if xi.instance.onEventUpdate(player, csid, option) then
        player:setLocalVar("NYZUL_INSTANCE", 1)
    else
        player:updateEvent(405, 3, 3, 3, 3, 3, 3, 3)
    end
end

entity.onEventFinish = function(player, csid, option)
    -- NOTE: Entrance to Nyzul Isle is two daisy-chained events, so we handle this
    --       here as a special case
    if csid == 405 and option == 1073741824 and player:getLocalVar("NYZUL_INSTANCE") == 1 then
        player:startEvent(116, 2) -- This means the event was force terminated. Loop into the entrance animation.
    elseif csid == 116 and option == 1 then
        xi.instance.onEventFinish(player, csid, option)
    end
end

return entity
