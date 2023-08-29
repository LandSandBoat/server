-----------------------------------
-- Area: Alzadaal Undersea Ruins
-- Door: Runic Seal
-- !pos 125 -2 20 72
-----------------------------------
local ID = zones[xi.zone.ALZADAAL_UNDERSEA_RUINS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not xi.instance.onTrigger(player, npc, xi.zone.NYZUL_ISLE) then
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    -- If instance loading or entry fails (for you or your party):
    -- Force the Nyzul Isle loop to bail out
    if xi.instance.onEventUpdate(player, csid, option, npc) then
        player:setLocalVar('NYZUL_INSTANCE', 1)
    -- This was causing entry to fail out, and 116 to not be hit.  Handled inside
    -- Path of Darkness instance script.
    -- else
    --     v:updateEvent(405, 3, 3, 3, 3, 3, 3, 3)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- NOTE: Entrance to Nyzul Isle is two daisy-chained events, so we handle this
    --       here as a special case
    if
        csid == 405 and
        option == 1073741824 and
        player:getLocalVar('NYZUL_INSTANCE') == 1
    then
        player:startEvent(116, 2) -- This means the event was force terminated. Loop into the entrance animation.
    elseif csid == 116 and option == 1 then
        -- TODO: Entrance message for registrant: 'Commencing transport to Nyzul Isle'  This was not being hit
        -- by Path of Darkness, and has been moved (in that case) into the mission script.
        xi.instance.onEventFinish(player, csid, option, npc)
    end
end

return entity
