-----------------------------------
-- Area: QuBia_Arena
-- Globals
-----------------------------------
local ID = require("scripts/zones/QuBia_Arena/IDs")
local global = {}

-----------------------------------
-- Mission 9-2 San d'Oria
-- BCNM: Heir to the light
-----------------------------------

local phaseInfo =
{
    -- Trion Spawn              -- Player Position
    { { -403, -201,  413, 58 }, { -400, -201,  419, 61 }, },
    { {   -3,   -1,    4, 61 }, {    0,   -1,   10, 61 }, },
    { {  397,  198, -395, 64 }, {  399,  198, -381, 57 }, },
}

global.tryPhaseChange = function(player)
    local battlefield = player:getBattlefield()
    local inst = battlefield:getArea()
    local instOffset = ID.mob.HEIR_TO_THE_LIGHT_OFFSET + (14 * (inst - 1))
    local allMobsDead = true

    for i = instOffset + 3, instOffset + 13 do
        if not GetMobByID(i):isDead() then
            allMobsDead = false
        end
    end

    if allMobsDead and player:getLocalVar('secondPhase') == 0 then
        player:setLocalVar('secondPhase', 1)
        player:startEvent(32004, 0, 0, 4)
    end
end

global.phaseEventFinish = function(player, csid)
    if csid == 32004 then
        local battlefield = player:getBattlefield()
        local bfArea = battlefield:getArea()

        for i = 1, 3 do
            SpawnMob(ID.mob.HEIR_TO_THE_LIGHT_OFFSET + 14 * (bfArea - 1) + i)
        end

        local trion = battlefield:insertEntity(75, true, true)
        trion:setSpawn(unpack(phaseInfo[bfArea][1]))
        trion:spawn()
        player:setPos(unpack(phaseInfo[bfArea][2]))
    end
end

return global
