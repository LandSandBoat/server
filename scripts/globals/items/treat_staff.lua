-----------------------------------------
--  ID: 17566
--  Treat staff
--  Chance to transport the user to their Home Point on hit
-----------------------------------------
require("scripts/globals/events/harvest_festivals")
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    local totd = VanadielTOTD()
    local warp = math.random() < 0.15

    if warp and (isHalloweenEnabled() ~= 0 or (VanadielDayOfTheWeek() == xi.day.DARKSDAY and IsMoonFull() and (totd == xi.time.NIGHT or totd == xi.time.MIDNIGHT))) then
        player:warp()
    end
end

return item_object
