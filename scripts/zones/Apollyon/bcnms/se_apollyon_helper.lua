-----------------------------------
-- Global file for Apollyon SE
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")
require("scripts/globals/limbus")
-----------------------------------
xi = xi or {}
xi.apollyon_se = xi.apollyon_se or {}

-----------------------------------
-- Floor 1 to 4
-----------------------------------
-- Mobs in floor 1: Ghost Clot (Boss), Metalloid Amoeba x8
-- Mobs in floor 2: Tieholtsodi (Boss), Adamantshell x8
-- Mobs in floor 3: Grave Digger (Boss), Inhumer x8
-- Mobs in floor 4: Evil Armory (Boss), Flying Spear x8

xi.apollyon_se.handleMobDeathKey = function(mob, player, isKiller, noKiller, floor)
    if isKiller or noKiller then
        if floor == 4 then
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[4]):setStatus(xi.status.NORMAL)
        else
            xi.limbus.handleDoors(player:getBattlefield(), true, ID.npc.APOLLYON_SE_PORTAL[floor])
        end
    end
end

-- Floor 1: Crates spawn at mob location.
xi.apollyon_se.handleMobDeathFloorOne = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        battlefield:setLocalVar("killCountF1", battlefield:getLocalVar("killCountF1") + 1)

        -- Spawn crate.
        local killCount = battlefield:getLocalVar("killCountF1")

        if killCount == 2 then
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[1]):setPos(mob:getXPos(), mob:getYPos(), mob:getZPos())
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[1]):setStatus(xi.status.NORMAL)
        elseif killCount == 4 then
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[1] + 1):setPos(mob:getXPos(), mob:getYPos(), mob:getZPos())
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[1] + 1):setStatus(xi.status.NORMAL)
        elseif killCount == 8 then
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[1] + 2):setPos(mob:getXPos(), mob:getYPos(), mob:getZPos())
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[1] + 2):setStatus(xi.status.NORMAL)
        end
    end
end

-- Floor 2: Crates spawn at fixed locations.
xi.apollyon_se.handleMobDeathFloorTwo = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        battlefield:setLocalVar("killCountF2", battlefield:getLocalVar("killCountF2") + 1)

        -- Spawn crate.
        local killCount = battlefield:getLocalVar("killCountF2")

        if killCount == 2 then
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[2]):setStatus(xi.status.NORMAL)
        elseif killCount == 4 then
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[2] + 1):setStatus(xi.status.NORMAL)
        elseif killCount == 8 then
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[2] + 2):setStatus(xi.status.NORMAL)
        end
    end
end

-- Floor 3: Crates spawn at random locations. Spawn pos handled on battlefield initialize.
xi.apollyon_se.handleMobDeathFloorThree = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local cratePos =
        {
            [1] = { 366.000, -0.500, -313.000 },
            [2] = { 313.021,  0.000, -317.754 },
            [3] = { 376.097,  0.000, -259.382 },
            [4] = { 321.552,  0.000, -293.187 },
            [5] = { 337.399, -0.388, -313.442 },
            [6] = { 354.661, -0.072, -273.424 },
        }

        local battlefield = mob:getBattlefield()
        battlefield:setLocalVar("killCountF3", battlefield:getLocalVar("killCountF3") + 1)

        -- Spawn crate.
        local killCount = battlefield:getLocalVar("killCountF3")

        if killCount == 2 then
            local pos = battlefield:getLocalVar("randomCrate1")
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[3]):setPos(cratePos[pos])
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[3]):setStatus(xi.status.NORMAL)
        elseif killCount == 4 then
            local pos = battlefield:getLocalVar("randomCrate2")
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[3] + 1):setPos(cratePos[pos])
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[3] + 1):setStatus(xi.status.NORMAL)
        elseif killCount == 8 then
            local pos = battlefield:getLocalVar("randomCrate3")
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[3] + 2):setPos(cratePos[pos])
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[3] + 2):setStatus(xi.status.NORMAL)
        end
    end
end
