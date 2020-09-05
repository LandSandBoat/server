-----------------------------------
-- Area: Pso'Xja
--  Mob: Gargoyle
-----------------------------------
local ID = require("scripts/zones/PsoXja/IDs")

function onMobDeath(mob, player, isKiller)
    if (isKiller) then
        local mobId = mob:getID()
        local offset = mobId - ID.mob.GARGOYLE_OFFSET
        if (offset < 16) then
            GetNPCByID(ID.npc.STONE_DOOR_OFFSET + offset):openDoor(30)
        end
    end
end

function onMobDespawn(mob)
end
