-----------------------------------
-- Tables and Functions Used at Multiple Places within Aht Urgan Whitegate
-----------------------------------
require("scripts/globals/settings")

-- Lua Set Initializer http://www.lua.org/pil/11.5.html
function Set (list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

-- Set of Royal Palace Approved Armor
ROYAL_PALACE_ALLOWED_BODY_ARMORS = Set{
    12548, -- Adaman Cuirass Lv. 73 WAR / PLD
    13746, -- Gem Cuirass Lv. 73 WAR / PLD
    13742, -- Aketon Lv. 60 MNK / WHM / RDM / THF / PLD / BST / BRD / DRG / SMN / BLU / COR / PUP / DNC
    13743, -- Aketon +1 Lv. 60 MNK / WHM / RDM / THF / PLD / BST / BRD / DRG / SMN / BLU / COR / PUP / DNC
    14525, -- Amir Korazin Lv. 72 WAR / PLD / DRK / SAM /DRG
    13795, -- Arhat's Gi Lv. 64 MNK / SAM / NIN
    13802, -- Arhat's Gi +1 Lv. 64 MNK / SAM / NIN
    14416, -- Barone Corazza Lv. 70 WAR / DRG
    14417, -- Conte Corazza Lv. 70 WAR / DRG
    13779, -- Black Cloak Lv. 68 BLM
    13780, -- Demon's Cloak Lv. 68 BLM
    13754, -- Black Cotehardie Lv. 59 MNK / WHM / BLM / RDM / THF / BST / BRD / RNG / NIN / SMN / BLU / PUP / DNC / SCH
    13755, -- Flora Cotehardie Lv. 59 MNK / WHM / BLM / RDM / THF / BST / BRD / RNG / NIN / SMN / BLU / PUP / DNC / SCH
    14436, -- Blessed Briault Lv. 70 WHM
    14438, -- Blessed Briault +1 Lv. 70 WHM
    13775, -- Blue Cotehardie Lv. 69 RDM / THF / RNG / NIN / COR / DNC
    13776, -- Blue Cotehardie +1 Lv. 69 RDM / THF / RNG / NIN / COR / DNC
    13740, -- Byrnie Lv. 60 WAR / PLD / DRK / BST / SAM / NIN
    13741, -- Byrnie +1 Lv. 60 WAR / PLD / DRK / BST / SAM / NIN
    13703, -- Brigandine Lv. 45 WAR / RDM / THF / PLD / DRK / BST / BRD / RNG / SAM / NIN / DRG / BLU / COR / DNC
    13710, -- Brigandine +1 Lv. 45 WAR / RDM / THF / PLD / DRK / BST / BRD / RNG / SAM / NIN / DRG / BLU / COR / DNC
    14372, -- Cardinal Vest Lv. 73 WAR / RDM / THF / PLD / DRK / BST / BRD / RNG / SAM / NIN / DRG / BLU / COR / DNC
    14373, -- Bachelor Vest Lv. 73 WAR / RDM / THF / PLD / DRK / BST / BRD / RNG / SAM / NIN / DRG / BLU / COR / DNC
    14440, -- Chasuble Lv. 72 RDM
    14441, -- Chasuble +1 Lv. 72 RDM
    12573, -- Dusk Jerkin Lv. 72 WAR / RDM / THF / PLD / DRK / BST /BRD / RNG / SAM / NIN / DRG / BLU / COR / DNC
    14391, -- Dusk Jerkin +1 Lv. 72 WAR / RDM / THF / PLD / DRK / BST /BRD / RNG / SAM / NIN / DRG / BLU / COR / DNC
    14389, -- Dragon Harness Lv. 73 THF
    14390, -- Dragon Harness +1 Lv. 73 THF
    14380, -- Errant Houppelande Lv. 72 WHM / BLM / RDM / BRD / SMN / BLU / PUP / SCH
    14381, -- Mahatma Houppelande Lv. 72 WHM / BLM / RDM / BRD / SMN / BLU / PUP / SCH
    14437, -- Hachiman Domaru Lv. 70 SAM
    14439, -- Hachiman Domaru +1 Lv. 70 SAM
    12555, -- Haubergeon Lv. 59 WAR / PLD / DRK / BST / SAM /NIN
    13735, -- Haubergeon Lv. 59 WAR / PLD / DRK / BST / SAM /NIN
    12556, -- Hauberk Lv. 69 WAR / DRK / BST
    13793, -- Hauberk +1 Lv. 69 WAR / DRK / BST
    13812, -- Holy Breastplate Lv. 40 WHM
    13813, -- Divine Breastplate Lv. 40 WHM
    14488, -- Homam Corazza Lv. 75 THF / PLD / DRK / DRG / BLU
    14420, -- Igqira Weskit Lv. 73 BLM
    14421, -- Genie Weskit Lv. 73 BLM
    14526, -- Jaridah Peti Lv. 55 WAR / RDM / THF / PLD / DRK / BST / BRD / RNG / SAM / NIN / DRG / BLU / COR / DNC
    14529, -- Akinji Peti Lv. 55 WAR / RDM / THF / PLD / DRK / BST / BRD / RNG / SAM / NIN / DRG / BLU / COR / DNC
    13744, -- Justaucorps Lv. 58 MNK / WHM / BLM / RDM / THF / DRK / BRD / RNG / SMN / BLU / COR / PUP / DNC / SCH
    13745, -- Justaucorps +1 Lv. 58 MNK / WHM / BLM / RDM / THF / DRK / BRD / RNG / SMN / BLU / COR / PUP / DNC / SCH
    14489, -- Nashira Manteel Lv. 75 WHM / BLM / RDM / SMN / BLU
    12605, -- Noble's Tunic Lv. 68 WHM
    13774, -- Aristocrat's Coat Lv. 68 WHM
    14530, -- Pahluwan Khazagand Lv. 72 MNK / RDM / THF / BST / RNG / NIN / DRG / COR / PUP / DNC
    14382, -- Plastron Lv. 71 DRK
    14383, -- Plastron +1 Lv. 71 DRK
    14376, -- Rasetsu Samue Lv. 72 MNK / SAM / NIN
    14377, -- Rasetsu Samue +1 Lv. 72 MNK / SAM / NIN
    13748, -- Vermillion Cloak Lv. 59 MNK / WHM / BLM / RDM / PLD / BRD / RNG / SMN / BLU / PUP / SCH
    13749, -- Royal Cloak Lv. 59 MNK / WHM / BLM / RDM / PLD / BRD / RNG / SMN / BLU / PUP / SCH
    12579, -- Scorpion Harness Lv. 57 WAR / MNK / RDM / THF / PLD / DRK / BST / BRD / SAM / NIN / DRG / BLU / COR / DNC
    13734, -- Scorpion Harness +1 Lv. 57 WAR / MNK / RDM / THF / PLD / DRK / BST / BRD / SAM / NIN / DRG / BLU / COR / DNC
    14524, -- Sipahi Jawshan Lv. 59 WAR / PLD / DRK / BST / SAM
    14528, -- Abtal Jawshan Lv. 59 WAR / PLD / DRK / BST / SAM
    14414, -- Sha'ir Manteel Lv. 72 BRD
    14415 -- Sheikh Manteel Lv. 72 BRD
}

-- Function to check if the player is wearing armor that is appropriate for the royal palace.
function doRoyalPalaceArmorCheck(player)
    local bodyArmor = player:getEquipID(tpz.slot.BODY)
    local check = (ROYAL_PALACE_ALLOWED_BODY_ARMORS[bodyArmor] ~= nil)

    local hasHandArmor = player:getEquipID(tpz.slot.HANDS)
    local hasLegArmor = player:getEquipID(tpz.slot.LEGS)
    local hasFeetArmor = player:getEquipID(tpz.slot.FEET)

    if (hasHandArmor == 0 or hasLegArmor == 0 or hasFeetArmor == 0) then
        check = false
        -- printf("Royal Palace Armor Check for Player <%s> -> Missing Required Hand/Leg/Feet Armor", player:getName())
    end

    -- printf("Royal Palace Armor Check for Player <%s> with Body Armor <%u>, allowed = %s", player:getName(), bodyArmor, check)

    return check
end
