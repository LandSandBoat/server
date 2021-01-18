-----------------------------------
-- Attachment: Pattern Reader
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

attachment_object.onEquip = function(pet)
    pet:addListener("ENGAGE", "AUTO_PATTERN_READER_ENGAGE", function(pet, target)
        pet:setLocalVar("patternreadertick", VanadielTime())
    end)
    pet:addListener("AUTOMATON_AI_TICK", "AUTO_PATTERN_READER_TICK", function(pet, target)
        if pet:getLocalVar("patternreadertick") > 0 then
            local master = pet:getMaster()
            local maneuvers = master:countEffect(tpz.effect.WIND_MANEUVER)
            local lasttick = pet:getLocalVar("patternreadertick")
            local tick = VanadielTime()
            local dt = tick - lasttick
            local prevamount = pet:getLocalVar("patternreader")
            local amount = 0
            if maneuvers > 0 then
                amount = maneuvers * dt
                if (amount + prevamount) > 30 then
                    amount = 30 - prevamount
                end
                if amount ~= 0 then
                    pet:addMod(tpz.mod.EVA, amount)
                end
            else
                amount = -1 * dt
                if (amount + prevamount) < 0 then
                    amount = -prevamount
                end
                if amount ~= 0 then
                    pet:delMod(tpz.mod.EVA, -amount)
                end
            end
            if amount ~= 0 then
                pet:setLocalVar("patternreader", prevamount + amount)
            end
            pet:setLocalVar("patternreadertick", tick)
        end
    end)
    pet:addListener("DISENGAGE", "AUTO_PATTERN_READER_DISENGAGE", function(pet)
        if pet:getLocalVar("patternreader") > 0 then
            pet:delMod(tpz.mod.EVA, pet:getLocalVar("patternreader"))
            pet:setLocalVar("patternreader", 0)
        end
        pet:setLocalVar("patternreadertick", 0)
    end)
end

attachment_object.onUnequip = function(pet)
    pet:removeListener("AUTO_PATTERN_READER_ENGAGE")
    pet:removeListener("AUTO_PATTERN_READER_TICK")
    pet:removeListener("AUTO_PATTERN_READER_DISENGAGE")
end

attachment_object.onManeuverGain = function(pet, maneuvers)
end

attachment_object.onManeuverLose = function(pet, maneuvers)
end

return attachment_object
