-----------------------------------
-- Pouch of Weighted Stones Era Module
-- Removes the banishing gate message hinting at the Pouch of Weighted Stones.
-- The June 14, 2012 version update let the key item open the banishing gates solo.
-----------------------------------
-- Source: https://wiki.ffo.jp/html/27024.html
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('weighted_stones_hint', xi.pre(xi.expansion.ABYSSEA))

m:addOverride('xi.zones.Garlaige_Citadel.npcs._5k0.onTrigger', function(player, npc)
end)

m:addOverride('xi.zones.Garlaige_Citadel.npcs._5k9.onTrigger', function(player, npc)
end)

m:addOverride('xi.zones.Garlaige_Citadel.npcs._5ki.onTrigger', function(player, npc)
end)

return m
