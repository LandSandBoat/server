-----------------------------------
-- CatsEyeXI Custom NPCs
-----------------------------------
local m = Module:new("three_mage_door_open")

m:addOverride("xi.zones.Inner_Horutoto_Ruins.npcs._5c8.onTrigger", function(player, npc)
    npc:openDoor(30)
end)

return m 