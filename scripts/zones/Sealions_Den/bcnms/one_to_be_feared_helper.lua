-----------------------------------
-- Helper file for "One to be Feared" Battlefield
-----------------------------------
local ID = zones[xi.zone.SEALIONS_DEN]
-----------------------------------
local oneToBeFeared = {}
-- Note:
-- This battlefield uses the old BCNM "instance" system.
-- That means there are several copies of the area and we are placed randomly in one.
-- Not to be confused with an actual instance.

local function healCharacter(player)
    player:setHP(player:getMaxHP())
    player:setMP(player:getMaxMP())
    player:setTP(0)
end

local function returnToAirship(player)
    local battlefield = player:getBattlefield()
    local instance    = battlefield:getArea()

    if instance == 1 then
        player:setPos(-780.010, -103.348, -86.327, 193)
    elseif instance == 2 then
        player:setPos(-140.029, -23.348, -446.376, 193)
    elseif instance == 3 then
        player:setPos(499.969, 56.652, -806.132, 193)
    end
end

-----------------------------------
-- Battle 1: 5 Mammets
-----------------------------------
oneToBeFeared.handleMammetDeath = function(mob, player, optParams)
    -- Find mob offset for given battlefield instance
    local battlefield      = mob:getBattlefield()
    local mammetOffset     = ID.mob.ONE_TO_BE_FEARED_OFFSET + (7 * (battlefield:getArea() - 1))
    local mammetDeathCount = 0

    -- If all five mammets in this instance are dead, start event.
    for i = mammetOffset + 0, mammetOffset + 4 do
        if GetMobByID(i):isDead() then
            mammetDeathCount = mammetDeathCount + 1
        else
            break
        end
    end

    if
        mammetDeathCount == 5 and
        player:hasStatusEffect(xi.effect.BATTLEFIELD) and
        player:getLocalVar('[OTBF]MammetCS') == 0
    then
        player:setLocalVar('[OTBF]MammetCS', 1) -- Safety check to not trigger CS more than once when killing multile Mammets at the same time.
        player:startEvent(10)
    end
end

oneToBeFeared.handleMammetBattleEnding = function(player, csid, option, npc)
    if csid == 10 then
        -- Players are healed in between fights, but their TP is set to 0
        player:addTitle(xi.title.BRANDED_BY_LIGHTNING)
        healCharacter(player)

        -- Move player to instance start. End battle 1.
        player:setLocalVar('[OTBF]battleCompleted', 1)
        returnToAirship(player)
    end
end

-----------------------------------
-- Battle 2: Omega
-----------------------------------
oneToBeFeared.handleOmegaDeath = function(mob, player, optParams)
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        player:startEvent(11)
    end
end

oneToBeFeared.handleOmegaBattleEnding = function(player, csid, option, npc)
    if csid == 11 then
        -- Players are healed in between fights, but their TP is set to 0.
        player:addTitle(xi.title.OMEGA_OSTRACIZER)
        healCharacter(player)

        -- Move player to instance start. End battle 2.
        player:setLocalVar('[OTBF]battleCompleted', 2)
        returnToAirship(player)
    end
end

-----------------------------------
-- Battle 3: Ultima
-----------------------------------
oneToBeFeared.handleUltimaDeath = function(mob, player, optParams)
    player:addTitle(xi.title.ULTIMA_UNDERTAKER)
    player:setLocalVar('[OTBF]battleCompleted', 0)
end

-----------------------------------
-- While on Airship
-----------------------------------
oneToBeFeared.handleAirshipDoorTrigger = function(player, npc)
    player:startEvent(32003, npc:getID() - ID.npc.AIRSHIP_DOOR_OFFSET + 1, player:getLocalVar('[OTBF]battleCompleted') * 2)
end

oneToBeFeared.handleOnEventUpdate = function(player, csid, option, npc)
    local battlefield = player:getBattlefield()

    -- Spawn Omega for given instance.
    if csid == 1 and option == 0 then
        local omegaId = ID.mob.ONE_TO_BE_FEARED_OFFSET + (7 * (battlefield:getArea() - 1)) + 5
        if omegaId and not GetMobByID(omegaId):isSpawned() then
            SpawnMob(omegaId)
        end

    -- Spawn Ultima for given instance.
    elseif csid == 2 and option == 0 then
        local ultimaId = ID.mob.ONE_TO_BE_FEARED_OFFSET + (7 * (battlefield:getArea() - 1)) + 6
        if not GetMobByID(ultimaId):isSpawned() then
            SpawnMob(ultimaId)
            battlefield:setLocalVar('phaseChange', 0)
        end
    end
end

oneToBeFeared.handleOnEventFinish = function(player, csid, option, npc)
    if csid == 32003 then
        if option >= 100 and option <= 102 then
            local party = player:getParty()

            if party ~= nil then
                for _, v in pairs(party) do
                    if v:hasStatusEffect(xi.effect.BATTLEFIELD) then
                        v:startEvent(v:getLocalVar('[OTBF]battleCompleted'), option - 99)
                    end
                end
            else
                player:startEvent(player:getLocalVar('[OTBF]battleCompleted'), option - 99)
            end

        -- Leave battlefield.
        elseif option == 4 then
            if player:getBattlefield() then
                player:leaveBattlefield(1)
                player:setLocalVar('[OTBF]battleCompleted', 0)
                player:setLocalVar('[OTBF]MammetCS', 0)
            end
        end
    end
end

return oneToBeFeared
