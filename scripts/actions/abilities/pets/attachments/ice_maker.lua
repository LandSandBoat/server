-----------------------------------
-- Attachment: Ice Maker
-----------------------------------
local attachmentObject = {}

attachmentObject.onEquip = function(automaton)
    automaton:addListener('MAGIC_START', 'AUTO_ICE_MAKER_START', function(pet, spell, action)
        if spell:getSkillType() ~= xi.skill.ELEMENTAL_MAGIC then
            return
        end

        local master    = pet:getMaster()
        local maneuvers = utils.clamp(master:countEffect(xi.effect.ICE_MANEUVER), 0, 3)
        local amount    = 0

        -- Values updated in https://wiki.ffo.jp/html/34039.html version update.
        if maneuvers > 0 then
            amount = 25 + 25 * maneuvers
        end

        pet:setMod(xi.mod.AUTO_MAB_COEFFICIENT, amount)
        pet:setLocalVar('iceMakerManeuvers', maneuvers)
    end)

    automaton:addListener('MAGIC_STATE_EXIT', 'AUTO_ICE_MAKER_END', function(pet, spell)
        local master   = pet:getMaster()
        local toRemove = pet:getLocalVar('iceMakerManeuvers')

        if toRemove == 0 then
            return
        end

        for i = 1, toRemove do
            master:delStatusEffectSilent(xi.effect.ICE_MANEUVER)
        end

        pet:setMod(xi.mod.AUTO_MAB_COEFFICIENT, 0)
        pet:setLocalVar('iceMakerManeuvers', 0)
    end)
end

attachmentObject.onUnequip = function(pet)
    pet:removeListener('AUTO_ICE_MAKER_START')
    pet:removeListener('AUTO_ICE_MAKER_END')
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
end

return attachmentObject
