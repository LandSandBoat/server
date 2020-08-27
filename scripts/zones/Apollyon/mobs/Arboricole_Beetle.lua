-----------------------------------
-- Area: Apollyon NE
--  Mob: Arboricole Beetle
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        local deadF2 = battlefield:getLocalVar("deadF2")
        battlefield:setLocalVar("deadF2", deadF2+1)
        if battlefield:getLocalVar("deadF2") == 7 then
            GetNPCByID(ID.npc.APOLLYON_SW_CRATE[2]):setStatus(tpz.status.NORMAL)
            GetNPCByID(ID.npc.APOLLYON_SW_CRATE[2]+1):setStatus(tpz.status.NORMAL)
            GetNPCByID(ID.npc.APOLLYON_SW_CRATE[2]+2):setStatus(tpz.status.NORMAL)
        end
    end
end
