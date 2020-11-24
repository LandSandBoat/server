-----------------------------------
-- Attachment: Volt Gun
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onEquip(pet)
    local skill = math.max(pet:getSkillLevel(tpz.skill.AUTOMATON_MELEE), pet:getSkillLevel(tpz.skill.AUTOMATON_RANGED), pet:getSkillLevel(tpz.skill.AUTOMATON_MAGIC))
    pet:addMod(tpz.mod.ENSPELL, tpz.magic.element.THUNDER)
    pet:addMod(tpz.mod.ENSPELL_DMG, skill * 0.1)
    pet:addMod(tpz.mod.ENSPELL_CHANCE, 20)
end

function onUnequip(pet)
    pet:delMod(tpz.mod.ENSPELL, tpz.magic.element.THUNDER)
    pet:delMod(tpz.mod.ENSPELL_DMG, pet:getMod(tpz.mod.ENSPELL_DMG))
    pet:delMod(tpz.mod.ENSPELL_CHANCE, 20)
end

function onManeuverGain(pet, maneuvers)
    local skill = math.max(pet:getSkillLevel(tpz.skill.AUTOMATON_MELEE), pet:getSkillLevel(tpz.skill.AUTOMATON_RANGED), pet:getSkillLevel(tpz.skill.AUTOMATON_MAGIC))
    pet:addMod(tpz.mod.ENSPELL_DMG, skill * 0.05)
    pet:addMod(tpz.mod.ENSPELL_CHANCE, 15)
end

function onManeuverLose(pet, maneuvers)
    local skill = math.max(pet:getSkillLevel(tpz.skill.AUTOMATON_MELEE), pet:getSkillLevel(tpz.skill.AUTOMATON_RANGED), pet:getSkillLevel(tpz.skill.AUTOMATON_MAGIC))
    pet:delMod(tpz.mod.ENSPELL_DMG, skill * 0.05)
    pet:delMod(tpz.mod.ENSPELL_CHANCE, 15)

    -- Hacky way of keeping tpz.mod.ENSPELL_DMG from going negative by simply resetting it
    if maneuvers == 1 and pet:getMod(tpz.mod.ENSPELL_DMG) < 0 then
        pet:delMod(tpz.mod.ENSPELL, pet:getMod(tpz.mod.ENSPELL))
        pet:delMod(tpz.mod.ENSPELL_DMG, pet:getMod(tpz.mod.ENSPELL_DMG))
        pet:delMod(tpz.mod.ENSPELL_CHANCE, pet:getMod(tpz.mod.ENSPELL_CHANCE))
        onEquip(pet)
    end
end
