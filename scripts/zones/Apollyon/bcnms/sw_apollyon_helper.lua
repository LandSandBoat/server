-----------------------------------
-- Global file for Apollyon SW
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")
require("scripts/globals/limbus")
-----------------------------------

xi = xi or {}
xi.apollyon_sw = xi.apollyon_sw or {}

-----------------------------------
-- Floor 1
-----------------------------------
-- Mobs in floor 1: Fir Bholg x10

local firBholgOffsets =
{
    [1] = { 2, 7 }, -- Hume
    [2] = { 0, 5 }, -- Elvaan
    [3] = { 4, 9 }, -- Taru
    [4] = { 3, 8 }, -- Mithra
    [5] = { 1, 6 }, -- Galka
}

xi.apollyon_sw.handleMobDeathFloorOne = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobID       = mob:getID()
        local battlefield = mob:getBattlefield()
        local playerRace  = battlefield:getLocalVar("raceF1")
        local mobOffset   = firBholgOffsets[playerRace]

        -- If is one of the two mobs of the same race as the race of the first player to enter.
        if
            mobID == ID.mob.APOLLYON_SW_MOB[1] + mobOffset[1] or
            mobID == ID.mob.APOLLYON_SW_MOB[1] + mobOffset[2]
        then
            -- If the pair is dead
            if
                GetMobByID(ID.mob.APOLLYON_SW_MOB[1] + mobOffset[1]):isDead() and
                GetMobByID(ID.mob.APOLLYON_SW_MOB[1] + mobOffset[2]):isDead()
            then
                -- Open portal.
                xi.limbus.handleDoors(battlefield, true, ID.npc.APOLLYON_SW_PORTAL[1])

                -- Spawn chests.
                GetNPCByID(ID.npc.APOLLYON_SW_CRATE[1]):setStatus(xi.status.NORMAL)
                GetNPCByID(ID.npc.APOLLYON_SW_CRATE[1] + 1):setStatus(xi.status.NORMAL)
                GetNPCByID(ID.npc.APOLLYON_SW_CRATE[1] + 2):setStatus(xi.status.NORMAL)
            end
        end
    end
end

-----------------------------------
-- Floor 2
-----------------------------------
-- Mobs in floor 2: Jidra x8

xi.apollyon_sw.handleMobDeathFloorTwo = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobID = mob:getID()

        -- Open portal.
        if mobID == ID.mob.APOLLYON_SW_MOB[2] then
            local battlefield = mob:getBattlefield()

            xi.limbus.handleDoors(battlefield, true, ID.npc.APOLLYON_SW_PORTAL[2])

        -- Spawn additional mob.
        -- TODO: Check for all mobs but boss. Spawn chests.
        else
            local mobX    = mob:getXPos()
            local mobY    = mob:getYPos()
            local mobZ    = mob:getZPos()
            local add_mob = GetMobByID(mobID + 7)

            add_mob:setPos(mobX, mobY, mobZ)
            add_mob:setSpawn(mobX, mobY, mobZ)
            add_mob:spawn()

            if player then
                add_mob:updateEnmity(player)
            end
        end
    end
end

-----------------------------------
-- Floor 3
-----------------------------------
-- Mobs in floor 3: Armoury Crate x8

xi.apollyon_sw.handleMobDeathFloorThree = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if GetNPCByID(ID.npc.APOLLYON_SW_PORTAL[3]):getAnimation() ~= xi.animation.OPEN_DOOR then
            xi.limbus.handleDoors(mob:getBattlefield(), true, ID.npc.APOLLYON_SW_PORTAL[3])
        end
    end
end

xi.apollyon_sw.handleMobDespawnFloorThree = function(mob)
    local battlefield = mob:getBattlefield()

    if battlefield then
        local mobID        = mob:getID()
        local mimicSpawned = battlefield:getLocalVar("mimicSpawned")

        if mobID == ID.mob.APOLLYON_SW_MOB[3] then
            battlefield:setLocalVar("mimicSpawned", mimicSpawned - 1)
        elseif mobID == ID.mob.APOLLYON_SW_MOB[3] + 1 then
            battlefield:setLocalVar("mimicSpawned", mimicSpawned - 2)
        elseif mobID == ID.mob.APOLLYON_SW_MOB[3] + 2 then
            battlefield:setLocalVar("mimicSpawned", mimicSpawned - 4)
        end
    end
end

-----------------------------------
-- Floor 4
-----------------------------------
-- Mobs in floor 4: Elemental x3 for all 8 elements. (24 Mobs)

-- Table for Elementals
local elementalMobDayOffset =
{
    [0] = { 3, 11, 19 }, -- Fire
    [1] = { 2, 10, 18 }, -- Earth
    [2] = { 6, 14, 22 }, -- Water
    [3] = { 0,  8, 16 }, -- Wind
    [4] = { 4, 12, 20 }, -- Ice
    [5] = { 7, 15, 23 }, -- Lightning
    [6] = { 5, 13, 21 }, -- Light
    [7] = { 1,  9, 17 }, -- Dark
}

xi.apollyon_sw.handleMobEngagedFloorFour = function(mob, target, mobElement)
    local battlefield   = mob:getBattlefield()
    local targetElement = battlefield:getLocalVar("targetElement")
    local table         = elementalMobDayOffset[mobElement]

    -- No elemental type chosen, so we choose one.
    if targetElement == 0 then
        local dayElement = VanadielDayOfTheWeek()
        battlefield:setLocalVar("targetElement", dayElement + 1)
    end

    -- Agro trio.
    GetMobByID(ID.mob.APOLLYON_SW_MOB[4] + table[1]):updateEnmity(target)
    GetMobByID(ID.mob.APOLLYON_SW_MOB[4] + table[2]):updateEnmity(target)
    GetMobByID(ID.mob.APOLLYON_SW_MOB[4] + table[3]):updateEnmity(target)
end

xi.apollyon_sw.handleMobDeathFloorFour = function(mob, player, isKiller, noKiller, mobElement)
    if isKiller or noKiller then
        local battlefield   = mob:getBattlefield()
        local targetElement = battlefield:getLocalVar("targetElement") - 1

        -- If elemental is of the correct element.
        if mobElement == targetElement then
            local table = elementalMobDayOffset[VanadielDayOfTheWeek()]

            -- If trio is dead.
            if
                GetMobByID(ID.mob.APOLLYON_SW_MOB[4] + table[1]):isDead() and
                GetMobByID(ID.mob.APOLLYON_SW_MOB[4] + table[2]):isDead() and
                GetMobByID(ID.mob.APOLLYON_SW_MOB[4] + table[3]):isDead()
            then
                GetNPCByID(ID.npc.APOLLYON_SW_CRATE[4]):setStatus(xi.status.NORMAL)
            end
        end
    end
end
