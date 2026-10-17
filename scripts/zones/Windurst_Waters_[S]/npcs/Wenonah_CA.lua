-----------------------------------
-- Area: Windurst Waters [S]
--  NPC: Wenonah, C.A.
-- Type: Campaign Arbiter (teleporter)
-- !pos -2.175 -1.000 10.184 94
-----------------------------------
---@type TNpcEntity
local entity = {}

local arbiterNation = xi.nation.WINDURST

entity.onTrigger = function(player, npc)
    xi.campaignTeleport.arbiterOnTrigger(player, arbiterNation)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.campaignTeleport.arbiterOnEventUpdate(player, csid, option, arbiterNation)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.campaignTeleport.arbiterOnEventFinish(player, csid, option, arbiterNation)
end

return entity
