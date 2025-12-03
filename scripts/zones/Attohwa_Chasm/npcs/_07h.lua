-----------------------------------
-- Area: Attohwa Chasm
--  NPC: Miasma Wall
-----------------------------------
local attohwaGlobal = require('scripts/zones/Attohwa_Chasm/globals')
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)
    -- Parradamo Tor miasma walls
    npc:addPeriodicTrigger(0, 3, 0)
end

entity.onTimeTrigger = function(npc, triggerID)
    attohwaGlobal.handleMiasma(npc)
end

return entity
