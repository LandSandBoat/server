-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47g (Handle)
-- Note: Opens door _471
-- !pos -182 -15 -19 151
-----------------------------------
local oztrojaGlobal = require('scripts/zones/Castle_Oztroja/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    oztrojaGlobal.handleOnTrigger(npc)
end

return entity
