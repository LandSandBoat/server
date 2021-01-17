-----------------------------------
-- Attachment: Ice Maker
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local attachment_object = {}

function onEquip(pet)
    pet:addListener("MAGIC_START", "AUTO_ICE_MAKER_START", function(pet, spell, action)
        if spell:getSkillType() ~= tpz.skill.ELEMENTAL_MAGIC then return end
        local master = pet:getMaster()
        local maneuvers = master:countEffect(tpz.effect.ICE_MANEUVER)
        local amount = 100 + pet:getMod(tpz.mod.MATT)
        if maneuvers == 1 then
            amount = amount * 0.2
            pet:setLocalVar("icemakermaneuvers", 1)
        elseif maneuvers == 2 then
            amount = amount * 0.4
            pet:setLocalVar("icemakermaneuvers", 2)
        elseif maneuvers == 3 then
            amount = amount * 0.6
            pet:setLocalVar("icemakermaneuvers", 3)
        else
            return
        end
        amount = math.floor(amount)
        pet:addMod(tpz.mod.MATT, amount)
        pet:setLocalVar("icemaker", amount)
    end)
    pet:addListener("MAGIC_STATE_EXIT", "AUTO_ICE_MAKER_END", function(pet, spell)
        local master = pet:getMaster()
        local toremove = pet:getLocalVar("icemakermaneuvers")
        if toremove == 0 then return end
        for i = 1, toremove do
            master:delStatusEffectSilent(tpz.effect.ICE_MANEUVER)
        end
        pet:delMod(tpz.mod.MATT, pet:getLocalVar("icemaker"))
        pet:setLocalVar("icemaker", 0)
        pet:setLocalVar("icemakermaneuvers", 0)
    end)
end

function onUnequip(pet)
    pet:removeListener("AUTO_ICE_MAKER_START")
    pet:removeListener("AUTO_ICE_MAKER_END")
end

function onManeuverGain(pet, maneuvers)
end

function onManeuverLose(pet, maneuvers)
end

return attachment_object
