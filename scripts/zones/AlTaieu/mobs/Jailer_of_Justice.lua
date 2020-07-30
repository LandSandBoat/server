-----------------------------------
-- Area: Al'Taieu
--   NM: Jailer of Justice
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------

function onMobFight(mob, target)
    local popTime = mob:getLocalVar("lastPetPop")
    -- ffxiclopedia says 30 sec, bgwiki says 1-2 min..
    -- Going with 60 seconds until I see proof of retails timing.
    if (os.time() - popTime > 60) then
        local alreadyPopped = false
        for Xzomit = mob:getID()+1, mob:getID()+6 do
            if (alreadyPopped == true) then
                break
            else
                if (not GetMobByID(Xzomit):isSpawned()) then
                    SpawnMob(Xzomit, 300):updateEnmity(target)
                    mob:setLocalVar("lastPetPop", os.time())
                    alreadyPopped = true
                end
            end
        end
    end
end

function onMobDeath(mob, player, isKiller)
end
