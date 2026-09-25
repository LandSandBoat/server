-----------------------------------
-- Area: Fei'Yin
--   NM: Capricious Cassie
-----------------------------------
mixins = { require('scripts/mixins/rage') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(5400, 7200))

    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PARALYZE)

    mob:setMobMod(xi.mobMod.GIL_MIN, 20000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 20000)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
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
    if player then
        player:addTitle(xi.title.CASSIENOVA)
    end
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(5400, 7200)) -- 90 to 120 minutes
end

return entity
