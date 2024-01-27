-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Temple Guardian
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    GetNPCByID(ID.npc.TEMPLE_GUARDIAN_DOOR):openDoor(300) -- 5min
end

return entity
