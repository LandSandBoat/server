-----------------------------------
-- Area: Lufaise Meadows
--  Mob: Leshy
-----------------------------------
local ID = require("scripts/zones/Lufaise_Meadows/IDs")
-----------------------------------

function disturbMob(mob)
    local offset = mob:getID() - ID.mob.LESHY_OFFSET
    if (offset >= 0 and offset <= 7) then
        local nm = GetMobByID(ID.mob.COLORFUL_LESHY)
        if (not nm:isSpawned() and not GetMobByID(ID.mob.COLORFUL_LESHY + 1):isSpawned()) then
            nm:setLocalVar("timeToGrow", os.time() + math.random(43200, 86400)) -- Colorful in 12 to 24 hours
        end
    end
end

function onMobEngaged(mob, target)
    disturbMob(mob)
end

function onMobFight(mob, target)
    disturbMob(mob)
end

function onMobRoam(mob)
    local ph = mob:getID()
    local offset = ph - ID.mob.LESHY_OFFSET
    if (offset >= 0 and offset <= 7) then
        local nm = GetMobByID(ID.mob.COLORFUL_LESHY)
        if (
            not nm:isSpawned() and
            not GetMobByID(ID.mob.COLORFUL_LESHY + 1):isSpawned() and
            os.time() > nm:getLocalVar("timeToGrow") and
            nm:getLocalVar("phIndex") == 0 and
            math.random(1, 20) == 1 -- this prevents the same Leshy from growing every cycle
        ) then
            local p = mob:getPos()
            DisallowRespawn(ph, true)
            DespawnMob(ph)
            DisallowRespawn(ID.mob.COLORFUL_LESHY, false)
            nm:setSpawn(p.x, p.y, p.z, p.rot)
            SpawnMob(ID.mob.COLORFUL_LESHY)
            nm:setLocalVar("phIndex", ph)
        end
    end
end

function onMobDeath(mob, player, isKiller)
end
