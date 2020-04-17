-----------------------------------
-- Area: Apollyon SW
--  Mob: Fire Elemental
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Apollyon/IDs")

function onMobEngaged(mob, target)
    GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+3):updateEnmity(target)
    GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+11):updateEnmity(target)
    GetMobByID(ID.mob.APOLLYON_SW_MOB[4]+19):updateEnmity(target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if tpz.limbus.elementalsDead() then
            GetNPCByID(ID.npc.APOLLYON_SW_CRATE[4]):setStatus(tpz.status.NORMAL)
        end
    end
end
