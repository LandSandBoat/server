-----------------------------------
-- A chasing mob whose target lands within 1 yalm of it
--
-- The in-range directness probe clears the chase path when its navmesh query fails, which it always does under 1 yalm.
-- Move() then read the destination of the cleared path, aborting builds with STL assertions (Linux ASAN, _MSVC_STL_HARDENING).
-----------------------------------

describe('Mob chase when the target lands on top of it', function()
    ---@type CClientEntityPair
    local player

    ---@type CTestEntity
    local mob

    before_each(function()
        player = xi.test.world:spawnPlayer({ zone = xi.zone.WEST_RONFAURE, level = 99 })
        mob    = player.entities:moveTo('Wild_Rabbit')
        mob:respawn()
        mob:clearPath()
        mob:setUnkillable(true)
        mob:setBaseSpeed(40) -- the mob default, other tests leave this rabbit immobile
    end)

    it('settles on the target after the in-range probe clears its chase path', function()
        local start = mob:getPos()
        player:setPos(start.x - 10, start.y, start.z, 0)

        mob:addEnmity(player, 100, 100)
        mob:engage(player:getTargID())

        for _ = 1, 5 do
            xi.test.world:tickEntity(mob)
            if mob:isFollowingPath() then
                break
            end
        end

        assert(mob:isFollowingPath(), 'mob should be chasing along a path')
        assert(mob:checkDistance(player) > 3, 'mob should still be short of melee range')

        local chasePos = mob:getPos()
        player:setPos(chasePos.x + 0.5, chasePos.y, chasePos.z, 0)
        xi.test.world:tickEntity(mob)

        assert(mob:isEngaged(), 'mob should still be engaged on the player')
        assert(not mob:isFollowingPath(), 'mob should settle on the player instead of walking a stale path')
    end)
end)
