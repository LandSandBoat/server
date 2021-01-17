-----------------------------------
-- Attachment: Tactical Processor
-- Not enough information to accurately recreate!
-- Also, not implemented, increased tendency to overload prior to 2015!
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    pet:addMod(tpz.mod.AUTO_DECISION_DELAY, 50) -- -0.5s
end

function onUnequip(pet)
    pet:delMod(tpz.mod.AUTO_DECISION_DELAY, 50)
end

function onManeuverGain(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(tpz.mod.AUTO_DECISION_DELAY, 20) -- -0.70s ?
    elseif maneuvers == 2 then
        pet:addMod(tpz.mod.AUTO_DECISION_DELAY, 15) -- -0.85s ?
    elseif maneuvers == 3 then
        pet:addMod(tpz.mod.AUTO_DECISION_DELAY, 30) -- -1.15s
    end
end

function onManeuverLose(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(tpz.mod.AUTO_DECISION_DELAY, 20)
    elseif maneuvers == 2 then
        pet:delMod(tpz.mod.AUTO_DECISION_DELAY, 15)
    elseif maneuvers == 3 then
        pet:delMod(tpz.mod.AUTO_DECISION_DELAY, 30)
    end
end

return attachment_object
