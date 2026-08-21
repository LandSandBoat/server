-----------------------------------
-- Area: Xarcabard [S]
--  NPC: Timid Scorpion, L.C.
-- Type: Campaign Arbiter (return trip to player's own nation of allegiance)
-- !pos 135.152 -22.066 -116.423 137
--
-- Default event 451, teleport event 455 -- part of this
-- zone's 4-NPC arbiter quartet (San d'Oria/Bastok/Windurst/generic-Beastman),
-- confirmed in-client 2026-08-20. See campaign_teleport.lua's own comment on
-- xi.campaignTeleport.zoneArbiterOnTrigger for the shared logic and the
-- Bronze-Ribbon-of-Service-or-higher gate.
-----------------------------------
---@type TNpcEntity
local entity = {}

local defaultEventId = 451
local teleportEventId = 455

entity.onTrigger = function(player, npc)
    xi.campaignTeleport.zoneArbiterOnTrigger(player, defaultEventId, teleportEventId)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.campaignTeleport.zoneArbiterOnEventUpdate(player, csid, option, teleportEventId)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.campaignTeleport.zoneArbiterOnEventFinish(player, csid, option, teleportEventId)
end

return entity
