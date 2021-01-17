-----------------------------------
-- Attachment: Mana Channeler II
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    pet:addMod(tpz.mod.MATT, 20)  -- Values unknown, best guess based on other attachment methods
    pet:addMod(tpz.mod.AUTO_MAGIC_DELAY, -3)
end

function onUnequip(pet)
    pet:delMod(tpz.mod.MATT, 20)
    pet:delMod(tpz.mod.AUTO_MAGIC_DELAY, -3)
end

function onManeuverGain(pet, maneuvers)
    if maneuvers == 1 then
        pet:addMod(tpz.mod.MATT, 10)
        pet:addMod(tpz.mod.AUTO_MAGIC_DELAY, -3)
    elseif maneuvers == 2 then
        pet:addMod(tpz.mod.MATT, 10)
        pet:addMod(tpz.mod.AUTO_MAGIC_DELAY, -3)
    elseif maneuvers == 3 then
        pet:addMod(tpz.mod.MATT, 10)
        pet:addMod(tpz.mod.AUTO_MAGIC_DELAY, -3)
    end
end

function onManeuverLose(pet, maneuvers)
    if maneuvers == 1 then
        pet:delMod(tpz.mod.MATT, 10)
        pet:delMod(tpz.mod.AUTO_MAGIC_DELAY, -3)
    elseif maneuvers == 2 then
        pet:delMod(tpz.mod.MATT, 10)
        pet:delMod(tpz.mod.AUTO_MAGIC_DELAY, -3)
    elseif maneuvers == 3 then
        pet:delMod(tpz.mod.MATT, 10)
        pet:delMod(tpz.mod.AUTO_MAGIC_DELAY, -3)
    end
end

return attachment_object
