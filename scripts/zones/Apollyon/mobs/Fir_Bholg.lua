-----------------------------------
-- Area: Apollyon SW
--  Mob: Fir Bholg
-----------------------------------
require("scripts/globals/limbus")
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Apollyon/IDs")
-----------------------------------
local entity = {}

-- Returns an ID based on raw race value.  Since gender is considered two
-- different races for Hume, Elvaan, and Taru, and Galka and Mithra are single,
-- we need a sane way to tell them apart.
-- 1 = Hume, 2 = Elvaan, 3 = Taru, 4 = Mithra, 5 = Galka
local function getRaceType(raceID)
    local raceType = nil

    if raceID <= 6 then
        raceType = math.ceil(raceID / 2)
    else
        raceType = raceID - 3
    end

    return raceType
end

local firBholgOffsets =
{
    [1] = { 2, 7 }, -- Hume
    [2] = { 0, 5 }, -- Elvaan
    [3] = { 4, 9 }, -- Taru
    [4] = { 3, 8 }, -- Mithra
    [5] = { 1, 6 }, -- Galka
}

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local mobID = mob:getID()
        local battlefield = mob:getBattlefield()
        local race = battlefield:getLocalVar("raceF1")
        local mobOffset = firBholgOffsets[getRaceType(race)]

        if
            mobID == ID.mob.APOLLYON_SW_MOB[1] + mobOffset[1] or
            mobID == ID.mob.APOLLYON_SW_MOB[1] + mobOffset[2]
        then
            if
                GetMobByID(ID.mob.APOLLYON_SW_MOB[1] + mobOffset[1]):isDead() and
                GetMobByID(ID.mob.APOLLYON_SW_MOB[1] + mobOffset[2]):isDead()
            then
                GetNPCByID(ID.npc.APOLLYON_SW_CRATE[1]):setStatus(xi.status.NORMAL)
                GetNPCByID(ID.npc.APOLLYON_SW_CRATE[1] + 1):setStatus(xi.status.NORMAL)
                GetNPCByID(ID.npc.APOLLYON_SW_CRATE[1] + 2):setStatus(xi.status.NORMAL)
            else
                xi.limbus.handleDoors(battlefield, true, ID.npc.APOLLYON_SW_PORTAL[1])
            end
        end
    end
end

return entity
