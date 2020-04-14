-----------------------------------
-- Area: Temenos E T
--  Mob: Dark Elemental
-----------------------------------
local ID = require("scripts/zones/Temenos/IDs")

function onMobDeath(mob, player, isKiller)
    if isKiller then
        local mobID = mob:getID()
        local battlefield = player:getBattlefield()
    
        switch (mobID): caseof {
            [ID.mob.TEMENOS_E_MOB[7]] = function ()
                if GetMobByID(ID.mob.TEMENOS_E_MOB[7]+1):isDead() then
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[7]):setStatus(tpz.status.NORMAL)
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[7]+1):setStatus(tpz.status.NORMAL)
                end
            end,
            [ID.mob.TEMENOS_E_MOB[7]+1] = function ()
                if GetMobByID(ID.mob.TEMENOS_E_MOB[7]):isDead() then
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[7]):setStatus(tpz.status.NORMAL)
                    GetNPCByID(ID.npc.TEMENOS_E_CRATE[7]+1):setStatus(tpz.status.NORMAL)
                end
            end,
        }
    end
end
