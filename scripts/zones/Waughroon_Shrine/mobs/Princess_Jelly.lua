-----------------------------------
-- Area: Waughroon Shrine
-- Mob: Princess Jelly
-- BCNM: Royal Jelly
-----------------------------------
local ID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------
---@type TMobEntity
local entity = {}

local battlefieldCenters =
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

    mob:setLocalVar('reachedCenter', 0)
    battlefield:setLocalVar('jelliesInCenter', 0)
    battlefield:setLocalVar('jelliesAlive', 8)
    battlefield:setLocalVar('queenSpawned', 0)

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

-----------------------------------
-- Returns the distance of the mob from the center of the battlefield.
-----------------------------------
local function getDistanceFromCenter(battlefieldArea, mob)
    local pos = mob:getPos()

    local difX = pos.x - battlefieldCenters[battlefieldArea][1]
    local difY = pos.y - battlefieldCenters[battlefieldArea][2]
    local difZ = pos.z - battlefieldCenters[battlefieldArea][3]

    return math.sqrt(math.pow(difX, 2) + math.pow(difY, 2) + math.pow(difZ, 2))
end

entity.onMobFight = function(mob, target)
    local battlefield = mob:getBattlefield()

    if not battlefield then
        return
    end

    local battlefieldArea = battlefield:getArea()
    local jelliesInCenter = battlefield:getLocalVar('jelliesInCenter')
    local jelliesAlive    = battlefield:getLocalVar('jelliesAlive')

    if not battlefieldArea then
        return
    end

    local battlefieldCenter = battlefieldCenters[battlefieldArea]

    if not battlefieldCenter then
        return
    end

    -- On first combat tick, begin pathing to the center
    if not mob:isFollowingPath() then
        mob:pathThrough(battlefieldCenter, xi.path.flag.SCRIPT)
    end

    -- Jellies become invulnerable in the center
    if
        getDistanceFromCenter(battlefieldArea, mob) <= 0.2 and
        mob:getLocalVar('reachedCenter') == 0
    then
        mob:setMod(xi.mod.UDMGPHYS, -10000)
        mob:setMod(xi.mod.UDMGRANGE, -10000)
        mob:setMod(xi.mod.UDMGMAGIC, -10000)
        mob:setMod(xi.mod.UDMGBREATH, -10000)
        mob:setLocalVar('reachedCenter', 1)
        jelliesInCenter = jelliesInCenter + 1
        battlefield:setLocalVar('jelliesInCenter', jelliesInCenter)
    end

    -- If the amount of Princess Jellies alive doesn't equal the amount in center, return.
    if
        jelliesAlive == 0 or
        jelliesAlive ~= jelliesInCenter
    then
        return
    end

    -- If we make it here, spawn the Queen Jelly
    if battlefield:getLocalVar('queenSpawned') == 0 then
        battlefield:setLocalVar('queenSpawned', 1)
        local queenHP      = 0
        local queenJellyID = ID.mob.QUEEN_JELLY + (battlefieldArea - 1) * 10
        local queenJelly   = GetMobByID(queenJellyID)

        if not queenJelly then
            return
        end

        for i = 1, 8 do
            local princessJelly = GetMobByID(queenJellyID + i)

            if not princessJelly then
                return
            end

            if princessJelly:isAlive() then
                queenHP = queenHP + princessJelly:getHP()
                DespawnMob(princessJelly:getID())
            end
        end

        SpawnMob(queenJellyID)
        queenJelly:setMaxHP(queenHP)
        queenJelly:setHP(queenJelly:getMaxHP())
    end
end

local spellTable =
{
    [xi.element.FIRE   ] = { xi.magic.spell.BIND, xi.magic.spell.BURN,  xi.magic.spell.FIRE     },
    [xi.element.ICE    ] = { xi.magic.spell.BIND, xi.magic.spell.FROST, xi.magic.spell.BLIZZARD },
    [xi.element.WIND   ] = { xi.magic.spell.BIND, xi.magic.spell.CHOKE, xi.magic.spell.AERO     },
    [xi.element.EARTH  ] = { xi.magic.spell.BIND, xi.magic.spell.RASP , xi.magic.spell.STONE    },
    [xi.element.THUNDER] = { xi.magic.spell.BIND, xi.magic.spell.SHOCK, xi.magic.spell.THUNDER  },
    [xi.element.WATER  ] = { xi.magic.spell.BIND, xi.magic.spell.DROWN, xi.magic.spell.WATER    },
    [xi.element.LIGHT  ] = { xi.magic.spell.BIND, xi.magic.spell.DIA,   xi.magic.spell.BANISH   },
    [xi.element.DARK   ] = { xi.magic.spell.BIND, xi.magic.spell.BIO,   xi.magic.spell.DRAIN    },
}

entity.onMobSpellChoose = function(mob, target, spellId)
    local mobElement = mob:getLocalVar('mobElement')
    local spellList  = spellTable[mobElement] or spellTable[xi.element.FIRE]

    return spellList[math.random(1, #spellList)]
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local battlefield = mob:getBattlefield()

        if not battlefield then
            return
        end

        local jelliesAlive = battlefield:getLocalVar('jelliesAlive')
        battlefield:setLocalVar('jelliesAlive', jelliesAlive - 1)
    end
end

return entity
