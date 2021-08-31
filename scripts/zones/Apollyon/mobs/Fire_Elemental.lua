-----------------------------------
-- Area: Apollyon SW
--  Mob: Fire Elemental
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Apollyon/IDs")
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+3):updateEnmity(target)
    GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+11):updateEnmity(target)
    GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+19):updateEnmity(target)
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if xi.limbus.elementalsDead() then
            GetNPCByID(ID.npc.APOLLYON_SW_CRATE[4]):setStatus(xi.status.NORMAL)
        end
    end
end

return entity
