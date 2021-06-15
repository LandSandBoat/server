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
    local name = target:getName()
    local hpp = target:getHPP()
    local family = target:getSystem()
    local isNM = target:isNM()
    local distance = 10 -- TODO
    local angle = 10 -- TODO
    
    -- TODO: Determine a skill, and get its index
    local skillIndex = 0x09B -- <VIT +25>

    -- TODO: Determine FP value
    local fp = 17

    local plate = user:addSoulPlate(name, skillIndex, fp)
end 

return item_object
