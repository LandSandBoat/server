-----------------------------------
-- Attachment: Flame Holder
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

local validskills = {
    [1940] = true,
    [1941] = true,
    [1942] = true,
    [1943] = true,
    [2065] = true,
    [2066] = true,
    [2067] = true,
    [2299] = true,
    [2300] = true,
    [2301] = true,
    [2743] = true,
    [2744] = true
}

attachment_object.onEquip = function(pet)
    pet:addListener("WEAPONSKILL_STATE_ENTER", "AUTO_FLAME_HOLDER_START", function(pet, skill)
        if not validskills[skill] then return end
        local master = pet:getMaster()
        local maneuvers = master:countEffect(tpz.effect.FIRE_MANEUVER)
        local amount = 0
        if maneuvers == 1 then
            amount = 25
            pet:setLocalVar("flameholdermaneuvers", 1)
        elseif maneuvers == 2 then
            amount = 50
            pet:setLocalVar("flameholdermaneuvers", 2)
        elseif maneuvers == 3 then
            amount = 75
            pet:setLocalVar("flameholdermaneuvers", 3)
        else
            return
        end
        pet:addMod(tpz.mod.WEAPONSKILL_DAMAGE_BASE, amount)
        pet:setLocalVar("flameholder", amount)
    end)
    pet:addListener("WEAPONSKILL_STATE_EXIT", "AUTO_FLAME_HOLDER_END", function(pet, skill)
        local master = pet:getMaster()
        local toremove = pet:getLocalVar("flameholdermaneuvers")
        if toremove == 0 then return end
        for i = 1, toremove do
            master:delStatusEffectSilent(tpz.effect.FIRE_MANEUVER)
        end
        pet:delMod(tpz.mod.WEAPONSKILL_DAMAGE_BASE, pet:getLocalVar("flameholder"))
        pet:setLocalVar("flameholder", 0)
        pet:setLocalVar("flameholdermaneuvers", 0)
    end)
end

attachment_object.onUnequip = function(pet)
    pet:removeListener("AUTO_FLAME_HOLDER_START")
    pet:removeListener("AUTO_FLAME_HOLDER_END")
end

attachment_object.onManeuverGain = function(pet, maneuvers)
end

attachment_object.onManeuverLose = function(pet, maneuvers)
end

return attachment_object
