-----------------------------------
-- Chocobo Racing: Grandstand entrance
-----------------------------------
xi = xi or {}
xi.chocoboRacing = xi.chocoboRacing or {}

local vars =
{
    STANDS_PAID = '[ChocoboCircuit]StandsPaid',
}

local standsAdmissionFee = 50

xi.chocoboRacing.onStandsEntranceTrigger = function(player, index)
    local hasPass = 0
    if player:hasKeyItem(xi.keyItem.CHOCOBO_CIRCUIT_GRANDSTAND_PASS) then
        hasPass = 1
    end

    player:setLocalVar(vars.STANDS_PAID, 0)
    player:startEvent(
        261 + index,
        hasPass,
        index, -- Grandstand arrival, in attendant order
        0      -- TODO: This is set to 1 if you have free entry
    )
end

xi.chocoboRacing.onStandsEntranceEventUpdate = function(player, csid, option, npc)
    if option == 16 then
        if player:hasKeyItem(xi.keyItem.CHOCOBO_CIRCUIT_GRANDSTAND_PASS) then
            player:delKeyItem(xi.keyItem.CHOCOBO_CIRCUIT_GRANDSTAND_PASS)
            player:setLocalVar(vars.STANDS_PAID, 1)
        end

        player:updateEvent(0)
    elseif option == 17 then
        if player:delGil(standsAdmissionFee) then
            player:setLocalVar(vars.STANDS_PAID, 1)
            player:updateEvent(0)
        else
            player:updateEvent(1)
        end
    end

    if player:getLocalVar(vars.STANDS_PAID) == 0 then
        player:setLocalVar('noPosUpdate', 1)
    end
end

xi.chocoboRacing.onStandsEntranceEventFinish = function(player, csid, option, npc)
    player:setLocalVar('noPosUpdate', 0)
    player:setLocalVar(vars.STANDS_PAID, 0)
end

xi.chocoboRacing.onStandsExitTrigger = function(player, index)
    player:startEvent(
        327 + index,
        index -- Circuit arrival, in attendant order
    )
end
