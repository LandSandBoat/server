-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Temple Guardian
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    GetNPCByID(ID.npc.TEMPLE_GUARDIAN_DOOR):openDoor(300) -- 5min
end

return entity
