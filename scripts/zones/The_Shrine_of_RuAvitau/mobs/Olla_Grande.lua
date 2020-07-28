-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Olla Grande
-----------------------------------
local ID = require("scripts/zones/The_Shrine_of_RuAvitau/IDs")
require("scripts/globals/settings")

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    GetNPCByID(ID.npc.OLLAS_QM):updateNPCHideTime(FORCE_SPAWN_QM_RESET_TIME)
end
