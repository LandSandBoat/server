-----------------------------------
-- Area: Apollyon SW
--  Mob: Air Elemental
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Apollyon/IDs")
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    GetMobByID(ID.mob.APOLLYON_SW_MOB[4]):updateEnmity(target)
    GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+8):updateEnmity(target)
    GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+16):updateEnmity(target)
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if xi.limbus.elementalsDead() then
            GetNPCByID(ID.npc.APOLLYON_SW_CRATE[4]):setStatus(xi.status.NORMAL)
        end
    end
end

return entity
