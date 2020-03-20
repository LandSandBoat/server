-----------------------------------
-- Area: Navukgo Execution Chamber
--  Mob: Immortal Flan
-----------------------------------
require("scripts/globals/battlefield")
local ID = require("scripts/zones/Navukgo_Execution_Chamber/IDs")
----------------------------------------

function onMobEngaged(mob, target)
    local bf = mob:getBattlefield()
    local mobOffset = (bf:getArea() - 1) * 7
    if not (bf:getLocalVar('flans_spawned') == 1) then
        local entrants = bf:getLocalVar('num_entrants')
        if entrants >= 4 then
            GetMobByID(ID.mob.IMMORTAL_FLAN2 + mobOffset):spawn()
        end
        if entrants >= 7 then
            GetMobByID(ID.mob.IMMORTAL_FLAN3 + mobOffset):spawn()
        end
        if entrants >= 10 then
            GetMobByID(ID.mob.IMMORTAL_FLAN4 + mobOffset):spawn()
        end
        if entrants >= 13 then
            GetMobByID(ID.mob.IMMORTAL_FLAN5 + mobOffset):spawn()
        end
        if entrants >= 16 then
            GetMobByID(ID.mob.IMMORTAL_FLAN6 + mobOffset):spawn()
        end
        bf:setLocalVar('flans_spawned', 1)
    end
end

function onMobFight(mob, target)
end

function onMobDeath(mob, player, isKiller)
end
