-----------------------------------
-- Area: Mount Zhayolm
--   NM: Cerberus
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.AOE_HIT_ALL, 1)
end

entity.onMobRoam = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobFight = function(mob, target)
    local targetPos = target:getPos()
    local spawnPos = mob:getSpawnPos()
    local arenaBoundaries =
    {
        { { 335, -92 }, { 332, -94 } },
    }

    local drawInPositions =
    {
        { 330.166, -23.909, -89.456, targetPos.rot },
        { 314.186, -24.180, -89.331, targetPos.rot },
        { 314.372, -23.985,   -82.1, targetPos.rot },
        { 321.629,     -24, -90.936, targetPos.rot },
        { 329.969,     -24, -73.665, targetPos.rot },
        { 322.330,     -24, -82.168, targetPos.rot },
        { 331.026,     -24, -81.093, targetPos.rot },
        { 321.795, -23.978, -73.724, targetPos.rot },
    }

    local drawInTable =
    {
        conditions =
        {
            target:getZPos() > -70,
            target:getXPos() < 310,
            not utils.sameSideOfLine(arenaBoundaries[1], targetPos, spawnPos),
        },
        position = utils.randomEntry(drawInPositions),
        wait = 2,
    }
    for _, condition in ipairs(drawInTable.conditions) do
        if condition then
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            utils.drawIn(target, drawInTable)
            break
        else
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        end
    end

    if mob:getHPP() > 25 then
        mob:setMod(xi.mod.REGAIN, 10)
    else
        mob:setMod(xi.mod.REGAIN, 70)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.CERBERUS_MUZZLER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(48, 72) * 3600) -- 48 - 72 hours with 1 hour windows
end

return entity
