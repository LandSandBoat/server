-----------------------------------
-- Global file for Apollyon NW
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")
require("scripts/globals/limbus")
-----------------------------------

xi = xi or {}
xi.apollyon_nw = xi.apollyon_nw or {}

-----------------------------------
-- Floor 1
-----------------------------------
-- Mobs in floor 1: Pluto x1, Bardha x7

-- Killing 1 of the 7 Bardhas opens the portal.
-- Correct Bardha selected in nw_apollyon.lua file.
xi.apollyon_nw.handleMobDeathFloorOnePortal = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobID       = mob:getID()
        local battlefield = mob:getBattlefield()
        local randomF1    = battlefield:getLocalVar("randomF1")

        if mobID == randomF1 then
            -- Select witch of the 7 Mountain Buffalos will open portal to floor 3.
            battlefield:setLocalVar("randomF2", ID.mob.APOLLYON_NW_MOB[2] + math.random(1, 7))

            -- Open portal to floor 2.
            xi.limbus.handleDoors(battlefield, true, ID.npc.APOLLYON_NW_PORTAL[1])
        end
    end
end

-- Killing Pluto drops Item Crate.
xi.apollyon_nw.handleMobDeathFloorOneChest = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobX = mob:getXPos()
        local mobY = mob:getYPos()
        local mobZ = mob:getZPos()
        GetNPCByID(ID.npc.APOLLYON_NW_CRATE[1][1]):setPos(mobX, mobY, mobZ)
        GetNPCByID(ID.npc.APOLLYON_NW_CRATE[1][1]):setStatus(xi.status.NORMAL)
    end
end

-----------------------------------
-- Floor 2
-----------------------------------
-- Mobs in floor 2: Zlatorog x1, Mountain Buffalo x7

-- Killing 1 of the 7 Mountain Buffalos opens the portal.
xi.apollyon_nw.handleMobDeathFloorTwoPortal = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobID       = mob:getID()
        local battlefield = mob:getBattlefield()
        local randomF2    = battlefield:getLocalVar("randomF2")

        if mobID == randomF2 then
            -- Select witch of the 7 Apollyon Scavengers will open portal to floor 3.
            battlefield:setLocalVar("randomF3", ID.mob.APOLLYON_NW_MOB[3] + math.random(1, 7))

            -- Open portal to floor 3.
            xi.limbus.handleDoors(battlefield, true, ID.npc.APOLLYON_NW_PORTAL[2])
        end
    end
end

-- Killing Zlatorog drops Item Crate.
xi.apollyon_nw.handleMobDeathFloorTwoChest = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobX = mob:getXPos()
        local mobY = mob:getYPos()
        local mobZ = mob:getZPos()
        GetNPCByID(ID.npc.APOLLYON_NW_CRATE[2][1]):setPos(mobX, mobY, mobZ)
        GetNPCByID(ID.npc.APOLLYON_NW_CRATE[2][1]):setStatus(xi.status.NORMAL)
    end
end

-----------------------------------
-- Floor 3
-----------------------------------
-- Mobs in floor 3: Millenary Mossback x1, Apollyon Scavenger x7

-- Killing 1 of the 7 Apollyon Scavengers opens the portal.
xi.apollyon_nw.handleMobDeathFloorThreePortal = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobID       = mob:getID()
        local battlefield = mob:getBattlefield()
        local randomF3    = battlefield:getLocalVar("randomF3")

        if mobID == randomF3 then
            -- Select witch of the 7 Goryniches will open portal to floor 4.
            battlefield:setLocalVar("randomF4", ID.mob.APOLLYON_NW_MOB[4] + math.random(1, 7))

            -- Open portal to floor 4.
            xi.limbus.handleDoors(battlefield, true, ID.npc.APOLLYON_NW_PORTAL[3])
        end
    end
end

-- Killing the Millenary Mossback drops Item Crate.
xi.apollyon_nw.handleMobDeathFloorThreeChest = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobX = mob:getXPos()
        local mobY = mob:getYPos()
        local mobZ = mob:getZPos()
        GetNPCByID(ID.npc.APOLLYON_NW_CRATE[3][1]):setPos(mobX, mobY, mobZ)
        GetNPCByID(ID.npc.APOLLYON_NW_CRATE[3][1]):setStatus(xi.status.NORMAL)
    end
end

-----------------------------------
-- Floor 4
-----------------------------------
-- Mobs in floor 4: Cynoprosopi x1, Gorynich x7

-- Killing 1 of the 7 Goryniches opens the portal.
xi.apollyon_nw.handleMobDeathFloorFourPortal = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobID       = mob:getID()
        local battlefield = mob:getBattlefield()
        local randomF4    = battlefield:getLocalVar("randomF4")

        if mobID == randomF4 then
            -- Open portal to floor 5.
            xi.limbus.handleDoors(battlefield, true, ID.npc.APOLLYON_NW_PORTAL[4])
        end
    end
end

-- Killing Cynoprosopi drops Item Crate.
xi.apollyon_nw.handleMobDeathFloorFourChest = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobX = mob:getXPos()
        local mobY = mob:getYPos()
        local mobZ = mob:getZPos()
        GetNPCByID(ID.npc.APOLLYON_NW_CRATE[4][1]):setPos(mobX, mobY, mobZ)
        GetNPCByID(ID.npc.APOLLYON_NW_CRATE[4][1]):setStatus(xi.status.NORMAL)
    end
end

-----------------------------------
-- Floor 5
-----------------------------------
-- Mobs in floor 5: Kaiser Behemoth x1, Kronprinz Behemoth x3

-- Killing Kaiser Behemoth makes Item Crate appear at portal, witch finishes the battlefield once opened.
xi.apollyon_nw.handleMobDeathFloorFive = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        GetNPCByID(ID.npc.APOLLYON_NW_CRATE[5]):setStatus(xi.status.NORMAL)
    end
end
