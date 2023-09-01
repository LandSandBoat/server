-----------------------------------
-- Attachment: Volt Gun
-----------------------------------
local attachmentObject = {}

attachmentObject.onEquip = function(pet)
    local skill = math.max(pet:getSkillLevel(xi.skill.AUTOMATON_MELEE), pet:getSkillLevel(xi.skill.AUTOMATON_RANGED), pet:getSkillLevel(xi.skill.AUTOMATON_MAGIC))
    pet:addMod(xi.mod.ENSPELL, xi.element.THUNDER)
    pet:addMod(xi.mod.ENSPELL_DMG, skill * 0.1)
    pet:addMod(xi.mod.ENSPELL_CHANCE, 20)
end

attachmentObject.onUnequip = function(pet)
    pet:delMod(xi.mod.ENSPELL, xi.element.THUNDER)
    pet:delMod(xi.mod.ENSPELL_DMG, pet:getMod(xi.mod.ENSPELL_DMG))
    pet:delMod(xi.mod.ENSPELL_CHANCE, 20)
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
    local skill = math.max(pet:getSkillLevel(xi.skill.AUTOMATON_MELEE), pet:getSkillLevel(xi.skill.AUTOMATON_RANGED), pet:getSkillLevel(xi.skill.AUTOMATON_MAGIC))
    pet:addMod(xi.mod.ENSPELL_DMG, skill * 0.05)
    pet:addMod(xi.mod.ENSPELL_CHANCE, 15)
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
    local skill = math.max(pet:getSkillLevel(xi.skill.AUTOMATON_MELEE), pet:getSkillLevel(xi.skill.AUTOMATON_RANGED), pet:getSkillLevel(xi.skill.AUTOMATON_MAGIC))
    pet:delMod(xi.mod.ENSPELL_DMG, skill * 0.05)
    pet:delMod(xi.mod.ENSPELL_CHANCE, 15)

    -- Hacky way of keeping xi.mod.ENSPELL_DMG from going negative by simply resetting it
    if maneuvers == 1 and pet:getMod(xi.mod.ENSPELL_DMG) < 0 then
        pet:delMod(xi.mod.ENSPELL, pet:getMod(xi.mod.ENSPELL))
        pet:delMod(xi.mod.ENSPELL_DMG, pet:getMod(xi.mod.ENSPELL_DMG))
        pet:delMod(xi.mod.ENSPELL_CHANCE, pet:getMod(xi.mod.ENSPELL_CHANCE))
        attachmentObject.onEquip(pet)
    end
end

return attachmentObject
