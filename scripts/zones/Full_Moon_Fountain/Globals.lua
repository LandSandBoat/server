-----------------------------------
-- Area: Full_Moon_Fountain
-- Globals
-----------------------------------
local ID = zones[xi.zone.FULL_MOON_FOUNTAIN]
local global = {}

-----------------------------------
-- Mission 9-2 Windurst
-- BCNM: Moon Reading
-----------------------------------

local phaseInfo =
{
        --  Ajido Spawn                                                   Player Position
    [1] = { ajidoPos = { 340.117,   48.752, -383.747, 64 }, playerPos = {  340.220,  48.557, -386.114, 190 } },
    [2] = { ajidoPos = {  -59.98,   10.752,    16.22, 64 }, playerPos = {  -59.877,  10.577,   13.853, 190 } },
    [3] = { ajidoPos = { -379.826, -51.248,  376.227, 64 }, playerPos = { -459.974, -51.423,   373.86, 190 } },
}

global.tryPhaseChange = function(player)
    local battlefield = player:getBattlefield()
    local inst = battlefield:getArea()
    local instOffset = ID.mob.MOON_READING_OFFSET + (6 * (inst - 1))
    local allMobsDead = true

    for i = instOffset, instOffset + 3 do
        if not GetMobByID(i):isDead() then
            allMobsDead = false
        end
    end

    if allMobsDead and player:getLocalVar('secondPhase') == 0 then
        player:setLocalVar('secondPhase', 1)
        player:startEvent(32004, 1, 0, 1, 0, 1)
    end
end

global.phaseEventFinish = function(player, csid)
    if csid == 32004 then
        local battlefield = player:getBattlefield()
        if battlefield then
            local inst = battlefield:getArea()
            local instOffset = ID.mob.MOON_READING_OFFSET + (6 * (inst - 1))

            -- spawn Yali and Yatzlwurm
            for i = instOffset + 4, instOffset + 5 do
                SpawnMob(i)
            end

            -- spawn Ajido-Marujido and set ally positions
            local allies = battlefield:getAllies()
            if #allies == 0 then
                local ajido = battlefield:insertEntity(33, true, true)
                ajido:setSpawn(unpack(phaseInfo[inst].ajidoPos))
                ajido:spawn()
            end

            player:setPos(unpack(phaseInfo[inst].playerPos))
        end
    end
end

return global
