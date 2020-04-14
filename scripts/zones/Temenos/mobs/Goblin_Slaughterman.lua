-----------------------------------
-- Area: Temenos N T
--  Mob: Goblin Slaughterman
-----------------------------------
require("scripts/globals/limbus")
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Temenos/IDs")

function onMobDeath(mob, player, isKiller)
    if isKiller then
        local mobID = mob:getID()
        local battlefield = player:getBattlefield()
        local random = battlefield:getLocalVar("randomF1")

        if mobID - ID.mob.TEMENOS_N_MOB[1] == random - 1 then
            tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_N_GATE[1])
        end

        if mobID == ID.mob.TEMENOS_N_MOB[1]+1 and random % 2 == 1 then
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[1]):setStatus(tpz.status.NORMAL)
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[1]+1):setStatus(tpz.status.NORMAL)
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[1]+2):setStatus(tpz.status.NORMAL)
        elseif mobID == ID.mob.TEMENOS_N_MOB[1] and random % 2 == 0 then
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[1]):setStatus(tpz.status.NORMAL)
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[1]+1):setStatus(tpz.status.NORMAL)
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[1]+2):setStatus(tpz.status.NORMAL)
        end
    end
end
