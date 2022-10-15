-----------------------------------
-- Area: Pso'Xja
--  Mob: Gargoyle
-----------------------------------
local ID = require("scripts/zones/PsoXja/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        local mobId = mob:getID()
        local offset = mobId - ID.mob.GARGOYLE_OFFSET
        if offset < 16 then
            GetNPCByID(ID.npc.STONE_DOOR_OFFSET + offset):openDoor(30)
        end
    end
end

entity.onMobDespawn = function(mob)
end

return entity
