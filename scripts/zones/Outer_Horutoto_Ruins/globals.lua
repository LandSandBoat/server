-- Zone: Outer Horutoto Ruins (194)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = zones[xi.zone.OUTER_HORUTOTO_RUINS]
-----------------------------------

-----------------------------------
-- local functions
-----------------------------------

local function setTrioCooldown()
    local pop = os.time() + math.random(2700, 3600) -- 45 to 60 minutes

    for i = ID.mob.BALLOON_NM_OFFSET + 1, ID.mob.BALLOON_NM_OFFSET + 3 do
        GetMobByID(i):setLocalVar('pop', pop)
    end
end

local function trioPrimed()
    for i = ID.mob.BALLOON_NM_OFFSET + 1, ID.mob.BALLOON_NM_OFFSET + 3 do
        local nm = GetMobByID(i)
        if nm ~= nil and (nm:isSpawned() or nm:getRespawnTime() ~= 0) then
            return true
        end
    end

    return false
end

-----------------------------------
-- public functions
-----------------------------------

local outerHorutotoGlobal =
{
    --[[..............................................................................................
        check to spawn trio NM.
        ..............................................................................................]]
    balloonOnDespawn = function(mob)
        local phId   = mob:getID()
        local offset = phId - ID.mob.BALLOON_NM_OFFSET

        if
            offset >= 0 and
            offset <= 4 and
            not trioPrimed() and
            math.random(1, 100) <= 20
        then
            local nmId = ID.mob.BALLOON_NM_OFFSET + math.random(1, 3)
            local nm   = GetMobByID(nmId)
            local pop  = nm:getLocalVar('pop')

            if os.time() > pop then
                DisallowRespawn(phId, true)
                DisallowRespawn(nmId, false)
                UpdateNMSpawnPoint(nmId)
                nm:setRespawnTime(GetMobRespawnTime(phId))

                nm:addListener('DESPAWN', 'DESPAWN_'..nmId, function(m)
                    DisallowRespawn(nmId, true)
                    DisallowRespawn(phId, false)
                    GetMobByID(phId):setRespawnTime(GetMobRespawnTime(phId))
                    m:removeListener('DESPAWN_'..nmId)
                    setTrioCooldown()
                end)
            end
        end
    end,
}

return outerHorutotoGlobal
