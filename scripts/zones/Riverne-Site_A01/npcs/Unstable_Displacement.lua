-----------------------------------
-- Area: Riverne Site #A01
--  NPC: Unstable Displacement
-- Note: entrance for "Ouryu Cometh"
-- !pos 183.390 -3.250 341.550 30
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_A01]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.bcnm.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if not xi.bcnm.onTrigger(player, npc) then
        player:messageSpecial(ID.text.A_GLOWING_MIST)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    xi.bcnm.onEventUpdate(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.bcnm.onEventFinish(player, csid, option, npc)
end

return entity
