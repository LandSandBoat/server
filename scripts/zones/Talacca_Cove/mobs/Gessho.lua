-----------------------------------
-- Area: Talacca Cove
--  Mob: Gessho
-----------------------------------
local ID = require("scripts/zones/Talacca_Cove/IDs")

function onMobFight(mob, target)
    if(mob:getID() == ID.mob.GESSHO) then
        local chance = math.random(1, 100)

        if (chance == 50) then
            local clones = math.random(1, 6)
            for i=1, clones, 1 do SpawnMob(mob:getID()+i) end
        end

        if (mob:getHPP() <= 15) then
            mob:getBattlefield():win()
        end
    else
        local count = mob:getLocalVar("DespawnCount")
        mob:setLocalVar("DespawnCount", count+1)

        if (count == 100) then
            DespawnMob(mob:getID())
        end
    end
end

function onMobDeath(mob, player, isKiller)
end
