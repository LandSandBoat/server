-----------------------------------
-- Area: Bastok Markets
--  NPC: Brian
-- Harvest Festival: Wake of the Lilies
-- !pos -260.883 -12.021 -80.343 235
-----------------------------------
local lilies = require('scripts/events/harvest_festival_lilies')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = lilies.onExorcistTrigger

entity.onEventFinish = lilies.onExorcistEventFinish

return entity
