-----------------------------------
-- Attachment: Eraser
-- Removes up to 3 status effects from the Automaton or its Master based on the number of Light Maneuvers active.
-- Automaton will prioritize itself over its Master.
-- Cannot remove Venom, Death Sentence, Charm or Gradual Petrification.
-- TODO: Verify all effects that Eraser can remove. Included categories from JP Wiki : https://wiki.ffo.jp/html/5365.html
-----------------------------------
---@type TAttachment
local attachmentObject = {}

local removables =
{
    -- Songs
    xi.effect.ELEGY,
    xi.effect.REQUIEM,
    xi.effect.THRENODY,

    -- Enfeebling
    xi.effect.BLINDNESS,
    xi.effect.PARALYSIS,
    xi.effect.SILENCE,
    xi.effect.CURSE_I,
    xi.effect.CURSE_II,
    xi.effect.DISEASE,
    xi.effect.PLAGUE,
    xi.effect.WEIGHT,
    xi.effect.BIND,
    xi.effect.ADDLE,
    xi.effect.SLOW,
    xi.effect.PETRIFICATION,

    -- DoTs
    xi.effect.POISON,
    xi.effect.BIO,
    xi.effect.DIA,
    xi.effect.BURN,
    xi.effect.FROST,
    xi.effect.CHOKE,
    xi.effect.RASP,
    xi.effect.SHOCK,
    xi.effect.DROWN,

    -- Main Stat Downs
    xi.effect.STR_DOWN,
    xi.effect.DEX_DOWN,
    xi.effect.VIT_DOWN,
    xi.effect.AGI_DOWN,
    xi.effect.INT_DOWN,
    xi.effect.MND_DOWN,
    xi.effect.CHR_DOWN,

    -- Combat Stat Downs
    xi.effect.ACCURACY_DOWN,
    xi.effect.ATTACK_DOWN,
    xi.effect.EVASION_DOWN,
    xi.effect.DEFENSE_DOWN,

    -- Magic Stat Downs
    xi.effect.MAGIC_ACC_DOWN,
    xi.effect.MAGIC_ATK_DOWN,
    xi.effect.MAGIC_EVASION_DOWN,
    xi.effect.MAGIC_DEF_DOWN,

    -- HP/MP/TP Stat Downs
    xi.effect.MAX_TP_DOWN,
    xi.effect.MAX_MP_DOWN,
    xi.effect.MAX_HP_DOWN
}

local function checkEffects(entity)
    for _, status in pairs(removables) do
        if entity:hasStatusEffect(status) then
            return true
        end
    end

    return false
end

attachmentObject.onEquip = function(pet)
    pet:addListener('AUTOMATON_ATTACHMENT_CHECK', 'ATTACHMENT_ERASER', function(automaton, target)
        if automaton:hasRecast(xi.recast.ABILITY, xi.mobSkill.ERASER_AUTOMATON) then
            return
        end

        local master = automaton:getMaster()

        if not master then
            return
        end

        if master:countEffect(xi.effect.LIGHT_MANEUVER) == 0 then
            return
        end

        local eraserTarget = false

        -- Automaton prioritizes itself over its Master.
        if checkEffects(automaton) then
            eraserTarget = automaton
        elseif
            automaton:checkDistance(master) < (7 + master:getHitboxSize() + automaton:getHitboxSize()) and -- needs verification
            checkEffects(master)
        then
            eraserTarget = master
        end

        if not eraserTarget then
            return
        end

        automaton:useMobAbility(xi.mobSkill.ERASER_AUTOMATON, eraserTarget)
    end)
end

attachmentObject.onUnequip = function(pet)
    pet:removeListener('ATTACHMENT_ERASER')
end

attachmentObject.onManeuverGain = function(pet, maneuvers)
end

attachmentObject.onManeuverLose = function(pet, maneuvers)
end

return attachmentObject
