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

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 40)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setBaseSpeed(xi.settings.map.BASE_SPEED * 0.05) -- ~5% of normal movement speed
    mob:setMod(xi.mod.REGEN, 3)

    -- All Princess Jellies pick a different element on spawn
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    local elementBitmask = battlefield:getLocalVar('elementChosen')

    -- Build table with available elements.
    local elementTable = {}
    for i = xi.element.FIRE, xi.element.DARK do
        if not utils.mask.getBit(elementBitmask, i) then
            table.insert(elementTable, i)
        end
    end

    -- Pick one random available element.
    local chosenElement   = elementTable[math.random(1, #elementTable)]
    local oppositeElement = xi.data.element.getElementWeakness(chosenElement)

    -- Mark element as picked and save it to battlefield.
    elementBitmask = utils.mask.setBit(elementBitmask, chosenElement, true)
    battlefield:setLocalVar('elementChosen', elementBitmask)

    -- Apply element-specific resistances/weaknesses
    mob:setLocalVar('mobElement', chosenElement)
    mob:addMod(xi.data.element.getElementalMEVAModifier(chosenElement), 250)
    mob:addMod(xi.data.element.getElementalMEVAModifier(oppositeElement), -250)
    mob:addMod(xi.data.element.getElementalAbsorptionModifier(chosenElement), 1000)
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
        queen:setMaxHP(princessesTotalHP(bfNum, zone))
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

    -- Jellies become invulnerable in the center
    if getDistanceFromCenter(bfNum, mob) <= 0.2 then
        mob:setMod(xi.mod.UDMGPHYS, -10000)
        mob:setMod(xi.mod.UDMGMAGIC, -10000)
    end

    -- When all the jellies are in the center, spawn the queen
    if getDistanceFromCenter(bfNum, mob) <= 0.2 then
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
