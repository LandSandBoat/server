-----------------------------------
-- Area: Sealion's Den
--  NPC: Airship_Door
-----------------------------------
local ID = zones[xi.zone.SEALIONS_DEN]
-----------------------------------

local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(32003, npc:getID() - ID.npc.AIRSHIP_DOOR_OFFSET + 1, player:getLocalVar('[OTBF]battleCompleted') * 2)
end

entity.onEventUpdate = function(player, csid, option, npc)
    local battlefield = player:getBattlefield()

    -- Spawn Omega for given instance.
    if csid == 1 and option == 0 then
        local omegaId = ID.mob.MAMMET_22_ZETA + (7 * (battlefield:getArea() - 1)) + 5
        if not GetMobByID(omegaId):isSpawned() then
            SpawnMob(omegaId)
        end

    -- Spawn Ultima for given instance.
    elseif csid == 2 and option == 0 then
        local ultimaId = ID.mob.MAMMET_22_ZETA + (7 * (battlefield:getArea() - 1)) + 6
        if not GetMobByID(ultimaId):isSpawned() then
            SpawnMob(ultimaId)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
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
            end
        end
    end
end

return entity
