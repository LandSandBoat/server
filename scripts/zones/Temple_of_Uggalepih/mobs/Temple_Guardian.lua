-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Temple Guardian
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    GetNPCByID(ID.npc.TEMPLE_GUARDIAN_DOOR):openDoor(300) -- 5min
end

return entity
