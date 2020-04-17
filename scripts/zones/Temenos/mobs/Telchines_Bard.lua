-----------------------------------
-- Area: Temenos N T
--  Mob: Telchines Bard
-----------------------------------
require("scripts/globals/limbus")
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Temenos/IDs")

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        local random = battlefield:getLocalVar("randomF3")

        if random == 1 then
            battlefield:setLocalVar("randomF4", math.random(1, 4))
            tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_N_GATE[3])
        end

        if random % 2 == 0 then
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[3]):setStatus(tpz.status.NORMAL)
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[3]+1):setStatus(tpz.status.NORMAL)
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[3]+2):setStatus(tpz.status.NORMAL)
        end
    end
end
