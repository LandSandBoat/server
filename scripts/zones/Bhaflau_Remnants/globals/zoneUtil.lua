-----------------------------------
-- Zone Utilities
-- random globals that may be used per zone
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_REMNANTS]
-----------------------------------
xi = xi or {}
xi.zoneUtil = xi.zoneUtil or {}
-----------------------------------

local equipCells =
{
    xi.item.UNDULATUS_CELL,
    xi.item.CASTELLANUS_CELL,
    xi.item.VIRGA_CELL,
    xi.item.CUMULUS_CELL,
    xi.item.RADIATUS_CELL,
    xi.item.CIRROCUMULUS_CELL,
    xi.item.STRATUS_CELL,
}

local statCells =
{
    xi.item.PANNUS_CELL,
    xi.item.FRACTUS_CELL,
    xi.item.CONGESTUS_CELL,
    xi.item.NIMBUS_CELL,
    xi.item.VELUM_CELL,
    xi.item.PILEUS_CELL,
    xi.item.MEDIOCRIS_CELL,
}

local specialCells =
{
    xi.item.HUMILUS_CELL,
    xi.item.SPISSATUS_CELL,
}

-- TODO: Reduce complexity
-- Disable cyclomatic complexity check for this function:
-- luacheck: ignore 561
xi.zoneUtil.pickList = function(mob)
    local instance = mob:getInstance()

    if instance then
        local floor = instance:getStage()
        local mobID = mob:getID()

        if floor == 1 then
            if utils.contains(mobID, ID.mob.WAMOURACAMPA) then
                return equipCells[math.random(1, #equipCells)],
                equipCells[math.random(1, #equipCells)],
                equipCells[math.random(1, #equipCells)]
            elseif utils.contains(mobID, ID.mob.CARMINE_ERUCA) then
                return statCells[math.random(1, #statCells)],
                statCells[math.random(1, #statCells)],
                statCells[math.random(1, #statCells)]
            else
                return xi.item.INCUS_CELL, xi.item.DUPLICATUS_CELL,
                specialCells[math.random(1, #specialCells)]
            end
        end

        if floor == 2 then
            if
                utils.contains(mobID, utils.slice(ID.mob.SULFUR_SCORPION, 4, 12)) or
                utils.contains(mobID, utils.slice(ID.mob.TROLL_SMELTER, 1, 3)) or
                utils.contains(mobID, utils.slice(ID.mob.TROLL_IRONWORKER, 3, 5))
            then --East Central
                return xi.item.INCUS_CELL, xi.item.HUMILUS_CELL,
                statCells[math.random(1, #statCells)],
                statCells[math.random(1, #statCells)]
            elseif
                utils.contains(mobID, utils.slice(ID.mob.TROLL_ENGRAVER, 4, 5)) or
                utils.contains(mobID, utils.slice(ID.mob.TROLL_STONEWORKER, 4, 5)) or
                utils.contains(mobID, utils.slice(ID.mob.TROLL_CAMEIST, 4, 5)) or
                utils.contains(mobID, utils.slice(ID.mob.WANDERING_WAMOURA, 13, 16))
            then -- Northwest
                return xi.item.OPACUS_CELL, xi.item.SPISSATUS_CELL,
                statCells[math.random(1, #statCells)],
                statCells[math.random(1, #statCells)]
            elseif
                utils.contains(mobID, utils.slice(ID.mob.WANDERING_WAMOURA, 17, 23)) or
                utils.contains(mobID,
                {
                    ID.mob.TROLL_ENGRAVER[6],
                    ID.mob.TROLL_STONEWORKER[6],
                    ID.mob.TROLL_CAMEIST[6]
                })
            then -- Southwest
                return xi.item.DUPLICATUS_CELL, xi.item.SPISSATUS_CELL,
                statCells[math.random(1, #statCells)],
                statCells[math.random(1, #statCells)]
            elseif
                utils.contains(mobID, utils.slice(ID.mob.WANDERING_WAMOURA, 4, 12)) or
                utils.contains(mobID, utils.slice(ID.mob.TROLL_ENGRAVER, 1, 3)) or
                utils.contains(mobID, utils.slice(ID.mob.TROLL_IRONWORKER, 6, 8))
            then -- West Central
                return xi.item.DUPLICATUS_CELL, xi.item.SPISSATUS_CELL,
                equipCells[math.random(1, #equipCells)],
                equipCells[math.random(1, #equipCells)]
            elseif
                utils.contains(mobID, utils.slice(ID.mob.TROLL_SMELTER, 4, 6)) or
                utils.contains(mobID, utils.slice(ID.mob.TROLL_STONEWORKER, 1, 3)) or
                utils.contains(mobID, utils.slice(ID.mob.TROLL_CAMEIST, 1, 3)) or
                utils.contains(mobID, utils.slice(ID.mob.SULFUR_SCORPION, 13, 22))
            then -- Northeast, Southeast
                return xi.item.INCUS_CELL, xi.item.HUMILUS_CELL,
                equipCells[math.random(1, #equipCells)],
                equipCells[math.random(1, #equipCells)]
            end
        end

        if floor == 3 then
            if utils.contains(mobID, utils.slice(ID.mob.BLACK_PUDDING, 15, 34)) then
                return xi.item.PRAECIPITATIO_CELL,
                specialCells[math.random(1, #specialCells)],
                xi.item.DUPLICATUS_CELL
            elseif
                utils.contains(mobID, utils.slice(ID.mob.TROLL_ENGRAVER, 7, 9)) or
                utils.contains(mobID,
                {
                    ID.mob.TROLL_GEMOLOGIST[4],
                    ID.mob.TROLL_SMELTER[8],
                    ID.mob.TROLL_CAMEIST[8],
                    ID.mob.TROLL_IRONWORKER[9],
                })
            then -- Northwest
                return xi.item.HUMILUS_CELL, xi.item.SPISSATUS_CELL,
                statCells[math.random(1, #statCells)],
                statCells[math.random(1, #statCells)]
            elseif utils.contains(mobID, utils.slice(ID.mob.BLACK_PUDDING, 8, 14)) then -- Southwest
                return xi.item.DUPLICATUS_CELL, xi.item.PRAECIPITATIO_CELL,
                statCells[math.random(1, #statCells)]
            elseif
                utils.contains(mobID, utils.slice(ID.mob.TROLL_STONEWORKER, 7, 13)) or
                utils.contains(mobID, utils.slice(ID.mob.TROLL_SMELTER, 9, 10)) or
                utils.contains(mobID, utils.slice(ID.mob.TROLL_CAMEIST, 9, 10)) or
                utils.contains(mobID, utils.slice(ID.mob.TROLL_IRONWORKER, 10, 11)) or
                utils.contains(mobID, utils.slice(ID.mob.TROLL_ENGRAVER, 10, 11)) or
                utils.contains(mobID, utils.slice(ID.mob.TROLL_GEMOLOGIST, 5, 8)) or
                utils.contains(mobID, utils.slice(ID.mob.TROLL_LAPIDARIST, 4, 5)) or
                utils.contains(mobID, utils.slice(ID.mob.TROLL_ENGRAVER, 12, 13)) or
                utils.contains(mobID,
                {
                    ID.mob.TROLL_CAMEIST[7],
                    ID.mob.TROLL_GEMOLOGIST[3],
                    ID.mob.TROLL_SMELTER[7],
                    ID.mob.TROLL_LAPIDARIST[3],
                })
            then -- Northeast, NorthCentral
                return xi.item.HUMILUS_CELL, xi.item.SPISSATUS_CELL,
                equipCells[math.random(1, #equipCells)],
                equipCells[math.random(1, #equipCells)]
            elseif utils.contains(mobID, utils.slice(ID.mob.BLACK_PUDDING, 1, 7)) then -- Southeast
                return xi.item.DUPLICATUS_CELL, xi.item.PRAECIPITATIO_CELL,
                equipCells[math.random(1, #equipCells)]
            end
        end
    end
end
