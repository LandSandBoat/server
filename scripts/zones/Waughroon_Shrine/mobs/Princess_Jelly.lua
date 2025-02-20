-----------------------------------
-- Area: Waughroon Shrine
-- Mob: Princess Jelly
-- BCNM: Royal Jelly
-----------------------------------
local waughroonID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------
---@type TMobEntity
local entity = {}

local elementalSpells =
{
    { xi.magic.spell.BURN,  xi.magic.spell.FIRE },
    { xi.magic.spell.DROWN, xi.magic.spell.WATER },
    { xi.magic.spell.SHOCK, xi.magic.spell.THUNDER },
    { xi.magic.spell.RASP , xi.magic.spell.STONE },
    { xi.magic.spell.CHOKE, xi.magic.spell.AERO },
    { xi.magic.spell.FROST, xi.magic.spell.BLIZZARD },
    { xi.magic.spell.DIA,   xi.magic.spell.BANISH },
    { xi.magic.spell.BIO,   xi.magic.spell.DRAIN },
}

local centers =
{
    { -177.5,  60, -142 },
    {   22.5,   0,   18 },
    {  222.5, -60,  138 },
}

local mevaList =
{
    { xi.mod.WATER_MEVA,   xi.mod.FIRE_ABSORB },
    { xi.mod.THUNDER_MEVA, xi.mod.WATER_ABSORB },
    { xi.mod.EARTH_MEVA,   xi.mod.LTNG_ABSORB },
    { xi.mod.WIND_MEVA,    xi.mod.EARTH_ABSORB },
    { xi.mod.ICE_MEVA,     xi.mod.WIND_ABSORB },
    { xi.mod.FIRE_MEVA,    xi.mod.ICE_ABSORB },
    { xi.mod.DARK_MEVA,    xi.mod.LIGHT_ABSORB },
    { xi.mod.LIGHT_MEVA,   xi.mod.DARK_ABSORB },
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 40)
end

entity.onMobSpawn = function(mob)
    mob:setBaseSpeed(xi.settings.map.BASE_SPEED * 0.05) -- ~5% of normal movementspeed
    mob:setMod(xi.mod.REGEN, 3)
    mob:setLocalVar('mobElement', math.random(1, 8))
    mob:addMod(mevaList[mob:getLocalVar('mobElement')][1], -250)
    mob:addMod(mevaList[mob:getLocalVar('mobElement')][2], 1000)
end

local function getQueenJellyID(bfNum)
    return waughroonID.mob.QUEEN_JELLY + (bfNum - 1) * 10
end

local function getDistanceFromCenter(bfNum, mob)
    local pos = mob:getPos()

    local difX = pos.x - centers[bfNum][1]
    local difY = pos.y - centers[bfNum][2]
    local difZ = pos.z - centers[bfNum][3]

    return math.sqrt(math.pow(difX, 2) + math.pow(difY, 2) + math.pow(difZ, 2))
end

local function allJellysInCenter(bfNum, zone)
    local totalMobsAlive = 0
    local totalInCenter = 0
    for i = 1, 8 do
        local princess = GetMobByID(getQueenJellyID(bfNum) + i)
        if getDistanceFromCenter(bfNum, princess) <= 0.5 then
            totalInCenter = totalInCenter + 1
        end

        if princess and princess:isAlive() then
            totalMobsAlive = totalMobsAlive + 1
        end
    end

    if totalMobsAlive == 0 then
        -- Win condition
        return false
    end

    return totalMobsAlive == totalInCenter
end

local function princessesTotalHP(bfNum, zone)
    local totalHP = 0

    for i = 1, 8 do
        local princess = GetMobByID(getQueenJellyID(bfNum) + i)
        if princess and princess:isAlive() then
            totalHP = totalHP + princess:getHP()
        end
    end

    return totalHP
end

local function spawnQueenJelly(bfNum, target, zone)
    local queen = GetMobByID(getQueenJellyID(bfNum))

    if queen and not queen:isSpawned() then
        SpawnMob(queen:getID())
        queen:setHP(princessesTotalHP(bfNum, zone))
        queen:setPos(centers[bfNum][1], centers[bfNum][2], centers[bfNum][3], 0)
        queen:setLocalVar('target', target:getID())

        queen:timer(3000, function(queenArg)
            local player = GetPlayerByID(queenArg:getLocalVar('target'))
            if player ~= nil and player:isAlive() then
                queen:updateClaim(player)
            end
        end)

        for i = 1, 8 do
            DespawnMob(queen:getID() + i)
        end
    end
end

entity.onMobMagicPrepare = function(mob, target, spellId)
    local element = mob:getLocalVar('mobElement')
    local spell   = math.random(1, 100)

    if spell > 60 then
        return elementalSpells[element][1] -- element's DoT
    elseif spell > 20 then
        return elementalSpells[element][2] -- element's nuke
    else
        return 258
    end
end

entity.onMobFight = function(mob, target)
    local bfNum = mob:getBattlefield():getArea()
    local queen = GetMobByID(getQueenJellyID(bfNum))
    local center = centers[bfNum]

    mob:pathThrough(center, xi.path.flag.SCRIPT)

    if getDistanceFromCenter(bfNum, mob) <= 0.5 then
        if
            queen and
            not queen:isSpawned() and
            allJellysInCenter(bfNum, mob:getZone())
        then
            spawnQueenJelly(bfNum, target, mob:getZone())
        end
    end

    if mob:checkDistance(target) >= 20 then
        mob:setMagicCastingEnabled(false)
    else
        mob:setMagicCastingEnabled(true)
    end
end

entity.onMobEngage = function(mob, target)
    -- battlefield has superlink
end

entity.onMobDeath = function(mob, player, optParams)
    local bfNum = mob:getBattlefield():getArea()
    local queen = GetMobByID(getQueenJellyID(bfNum))

    if
        queen and
        not queen:isSpawned() and
        allJellysInCenter(bfNum, mob:getZone())
    then
        spawnQueenJelly(bfNum, player, mob:getZone())
    end
end

return entity
