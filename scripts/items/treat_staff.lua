-----------------------------------
-- ID: 17566
-- Treat Staff
-- Outside the festival: full moon, Darksday, and nighttime.
-- https://wiki.ffo.jp/html/3736.html
-- Proc rates and delay are estimates.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemAdditionalEffect = function(player, target, baseAttackDamage, item)
    if player:getLocalVar('TreatStaffWarpPending') ~= 0 then
        return 0, 0, 0
    end

    local moon = VanadielMoonPhase()
    local hour = VanadielHour()
    if
        not xi.events.harvestFestival.isEnabled() and
        not (
            VanadielDayOfTheWeek() == xi.day.DARKSDAY and
            (moon >= 95 or moon >= 90 and VanadielMoonDirection() == 2) and
            (hour >= 18 or hour < 6)
        )
    then
        return 0, 0, 0
    end

    local chance = 10
    if target:getMainLvl() > player:getMainLvl() then
        chance = 20
    end

    if math.randomInt(1, 100) <= chance then
        player:setLocalVar('TreatStaffWarpPending', 1)
        player:timer(2500, function(playerArg)
            playerArg:setLocalVar('TreatStaffWarpPending', 0)
            playerArg:warp()
        end)
    end

    return 0, 0, 0
end

return itemObject
