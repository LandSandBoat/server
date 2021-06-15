-----------------------------------
-- Soultrapper (18721)
-- !additem 18721
-- Blank Soul Plate: !additem 18722
-- Used Soul Plate: !additem 2477
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    -- TODO: Check "ammo" (soul plates)
    -- TODO: Check inventory space -- player:getFreeSlotsCount()
    return 0
end

item_object.onItemUse = function(target, user, item)
end 

return item_object
