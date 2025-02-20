-----------------------------------
-- Area: Fei'Yin
--   NM: Capricious Cassie
-----------------------------------
mixins = { require('scripts/mixins/rage') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobRoam = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobFight = function(mob, target)
    local targetPos = target:getPos()
    local spawnPos = mob:getSpawnPos()
    local arenaBoundaries =
    {
        { { -87, 142 }, { -93, 146 } }, -- G-7 SW hallway
        { { -98, 208 }, { -94, 213 } }, -- G-6 NW hallway
        { { -13, 254 }, {  -8, 257 } }, -- H-5 N hallway
        { {  18, 192 }, {  15, 187 } }, -- H-6 E hallway
    }
    local drawInTable =
    {
        conditions =
        {
            targetPos.z < 130, -- S hallway
            not utils.sameSideOfLine(arenaBoundaries[1], targetPos, spawnPos),
            not utils.sameSideOfLine(arenaBoundaries[2], targetPos, spawnPos),
            targetPos.z > 250 and not utils.sameSideOfLine(arenaBoundaries[3], targetPos, spawnPos),
            not utils.sameSideOfLine(arenaBoundaries[4], targetPos, spawnPos),
        },
        position = mob:getPos(),
        wait = 3,
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
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.CASSIENOVA)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(75600, 86400)) -- 21-24 hours
end

return entity
