-----------------------------------
-- Area: Windurst Waters
--  NPC: Roger
-- Harvest Festival: Wake of the Lilies
-- !pos -55.955 -5.494 215.905 238
-----------------------------------
local lilies = require('scripts/events/harvest_festival_lilies')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = lilies.onExorcistTrigger

entity.onEventFinish = lilies.onExorcistEventFinish

return entity
