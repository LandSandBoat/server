-----------------------------------
-- Area: Halvung
--  NPC: Operating Lever J
-- TODO: more than 5/6 people still need verification as no sites show this requirment?
-----------------------------------
local ID = zones[xi.zone.HALVUNG]
local halvungGlobal = require('scripts/zones/Halvung/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    halvungGlobal.operatingLeverOnTrigger(player, npc, ID.npc.LEVER_IJ_DOOR)
end

entity.onEventFinish = function(player, csid, option, npc)
    halvungGlobal.operatingLeverOnEventFinish(player, csid, option, npc, ID.npc.LEVER_IJ_DOOR)
end

return entity
