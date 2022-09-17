-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Capelthwaite
-- BCNM: Let Sleeping Dogs Die
-----------------------------------
local ID = require("scripts/zones/QuBia_Arena/IDs")
-----------------------------------
local entity = {}

local checkHounds = function(mob)
    for i = 0, 3 do
        if GetMobByID(ID.hounds[mob:getBattlefield():getArea()]+i):isAlive() then
            return true
        end
    end
    return false
end

entity.onMobSpawn = function(houndMob)
    houndMob:setBehaviour(bit.bor(houndMob:getBehaviour(), xi.behavior.NO_DESPAWN))

    houndMob:addListener("DEATH", "CAPELTHWAITE_DEATH", function(mob, killer)
        if checkHounds(mob) then
            mob:timer(35000, function(mobArg)
                mobArg:setHP(mobArg:getMaxHP())
                mobArg:resetAI()
                mobArg:updateEnmity(killer)
            end)
        else
            for i = 0, 3 do
                GetMobByID(ID.hounds[mob:getBattlefield():getArea()]+i):setBehaviour(0)
            end
        end
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
