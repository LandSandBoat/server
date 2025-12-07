xi = xi or {}
xi.xispfollow = xi.xispfollow or {}

xi.xispfollow.follow = function(pal, player)
    -- Fail safe: If player isn't logged in, despawn the pal
    if not player then
        DespawnMob(pal:getID())
        return
    end

    local lPos   = player:getPos()
    local posX, posZ = xi.xisp.getPointAroundLoc(lPos, 2, 2)
    local pos    = pal:getPos()
    local dist   = 10

    -- Teleport to player if far away
    if pal:checkDistance(player) > 40 then
        pal:setPos(posX, lPos.y, posZ)
    end

    -- Don't follow too close if player is in combat
    if player:isEngaged() then
        dist = 20
    end

    -- Update movement parameters
    if pal:checkDistance(player) > dist then
        pal:setLocalVar('isMoving', 1)
        pal:pathTo(posX, lPos.y, posZ, xi.path.flag.RUN)
    else
        pal:setLocalVar('isMoving', 0)
        pal:pathTo(pos.x, pos.y, pos.z)
    end
end