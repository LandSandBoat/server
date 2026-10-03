-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Gertrude
-- Harvest Festival: Wake of the Lilies
-- !pos -224.314 7.999 52.965 231
-----------------------------------
local lilies = require('scripts/events/harvest_festival_lilies')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = lilies.onExorcistTrigger

entity.onEventFinish = lilies.onExorcistEventFinish

return entity
