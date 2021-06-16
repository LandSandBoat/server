-----------------------------------
-- Zeni NM System + Helpers
-- Soultrapper                 : !additem 18721
-- Blank Soul Plate            : !additem 18722
-- Soultrapper 2000            : !additem 18724
-- Blank High-Speed Soul Plate : !additem 18725
-- Used Soul Plate             : !additem 2477
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/common")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------

xi = xi or {}
xi.znm = xi.znm or {}

-- https://github.com/Windower/Lua/blob/dev/addons/libs/extdata.lua
xi.znm.soulPlates = {
    [0x001] = "Main Job: Warrior",
    [0x002] = "Main Job: Monk",
    [0x003] = "Main Job: White Mage",
    [0x004] = "Main Job: Black Mage",
    [0x005] = "Main Job: Red Mage",
    [0x006] = "Main Job: Thief",
    [0x007] = "Main Job: Paladin",
    [0x008] = "Main Job: Dark Knight",
    [0x009] = "Main Job: Beastmaster",
    [0x00A] = "Main Job: Bard",
    [0x00B] = "Main Job: Ranger",
    [0x00C] = "Main Job: Samurai",
    [0x00D] = "Main Job: Ninja",
    [0x00E] = "Main Job: Dragoon",
    [0x00F] = "Main Job: Summoner",
    [0x010] = "Main Job: Blue Mage",
    [0x011] = "Main Job: Corsair",
    [0x012] = "Main Job: Puppetmaster",
    
    [0x01F] = "Support Job: Warrior",
    [0x020] = "Support Job: Monk",
    [0x021] = "Support Job: White Mage",
    [0x022] = "Support Job: Black Mage",
    [0x023] = "Support Job: Red Mage",
    [0x024] = "Support Job: Thief",
    [0x025] = "Support Job: Paladin",
    [0x026] = "Support Job: Dark Knight",
    [0x027] = "Support Job: Beastmaster",
    [0x028] = "Support Job: Bard",
    [0x029] = "Support Job: Ranger",
    [0x02A] = "Support Job: Samurai",
    [0x02B] = "Support Job: Ninja",
    [0x02C] = "Support Job: Dragoon",
    [0x02D] = "Support Job: Summoner",
    [0x02E] = "Support Job: Blue Mage",
    [0x02F] = "Support Job: Corsair",
    [0x030] = "Support Job: Puppetmaster",
    
    [0x03D] = "Job Ability: Warrior",
    [0x03E] = "Job Ability: Monk",
    [0x03F] = "Job Ability: White Mage",
    [0x040] = "Job Ability: Black Mage",
    [0x041] = "Job Ability: Red Mage",
    [0x042] = "Job Ability: Thief",
    [0x043] = "Job Ability: Paladin",
    [0x044] = "Job Ability: Dark Knight",
    [0x045] = "Job Ability: Beastmaster",
    [0x046] = "Job Ability: Bard",
    [0x047] = "Job Ability: Ranger",
    [0x048] = "Job Ability: Samurai",
    [0x049] = "Job Ability: Ninja",
    [0x04A] = "Job Ability: Dragoon",
    [0x04B] = "Job Ability: Summoner",
    [0x04C] = "Job Ability: Blue Mage",
    [0x04D] = "Job Ability: Corsair",
    [0x04E] = "Job Ability: Puppetmaster",
    
    [0x05B] = "Job Trait: Warrior",
    [0x05C] = "Job Trait: Monk",
    [0x05D] = "Job Trait: White Mage",
    [0x05E] = "Job Trait: Black Mage",
    [0x05F] = "Job Trait: Red Mage",
    [0x060] = "Job Trait: Thief",
    [0x061] = "Job Trait: Paladin",
    [0x062] = "Job Trait: Dark Knight",
    [0x063] = "Job Trait: Beastmaster",
    [0x064] = "Job Trait: Bard",
    [0x065] = "Job Trait: Ranger",
    [0x066] = "Job Trait: Samurai",
    [0x067] = "Job Trait: Ninja",
    [0x068] = "Job Trait: Dragoon",
    [0x069] = "Job Trait: Summoner",
    [0x06A] = "Job Trait: Blue Mage",
    [0x06B] = "Job Trait: Corsair",
    [0x06C] = "Job Trait: Puppetmaster",
    
    [0x079] = "White Magic Scrolls",
    [0x07A] = "Black Magic Scrolls",
    [0x07B] = "Bard Scrolls",
    [0x07C] = "Ninjutsu Scrolls",
    [0x07D] = "Avatar Scrolls",
    [0x07E] = "Blue Magic Scrolls",
    [0x07F] = "Corsair Dice",
    
    [0x08D] = "HP Max Bonus",
    [0x08E] = "HP Max Bonus II",
    [0x08F] = "HP Max +50",
    [0x090] = "HP Max +100",
    [0x091] = "MP Max Bonus",
    [0x092] = "MP Max Bonus II",
    [0x093] = "MP Max +50",
    [0x094] = "MP Max +100",
    [0x095] = "STR Bonus",
    [0x096] = "STR Bonus II",
    [0x097] = "STR +25",
    [0x098] = "STR +50",
    [0x099] = "VIT Bonus",
    [0x09A] = "VIT Bonus II",
    [0x09B] = "VIT +25",
    [0x09C] = "VIT +50",
    [0x09D] = "AGI Bonus",
    [0x09E] = "AGI Bonus II",
    [0x09F] = "AGI +25",
    [0x0A0] = "AGI +50",
    [0x0A1] = "DEX Bonus",
    [0x0A2] = "DEX Bonus II",
    [0x0A3] = "DEX +25",
    [0x0A4] = "DEX +50",
    [0x0A5] = "INT Bonus",
    [0x0A6] = "INT Bonus II",
    [0x0A7] = "INT +25",
    [0x0A8] = "INT +50",
    [0x0A9] = "MND Bonus",
    [0x0AA] = "MND Bonus II",
    [0x0AB] = "MND +25",
    [0x0AC] = "MND +50",
    [0x0AD] = "CHR Bonus",
    [0x0AE] = "CHR Bonus II",
    [0x0AF] = "CHR +25",
    [0x0B0] = "CHR +50",
    
    [0x0C9] = "Monster Level Bonus",
    [0x0CA] = "Monster Level Bonus II",
    [0x0CB] = "Monster Level +2",
    [0x0CC] = "Monster Level +4",
    [0x0CD] = "Skill Level Bonus",
    [0x0CE] = "Skill Level Bonus II",
    [0x0CF] = "Skill Level +4",
    [0x0D0] = "Skill Level +8",
    [0x0D1] = "HP Max Rate Bonus",
    [0x0D2] = "HP Max Rate Bonus II",
    [0x0D3] = "HP Max +15%",
    [0x0D4] = "HP Max +30%",
    [0x0D5] = "MP Max Rate Bonus",
    [0x0D6] = "MP Max Rate Bonus II",
    [0x0D7] = "MP Max +15%",
    [0x0D8] = "MP Max +30%",
    [0x0D9] = "Attack Bonus",
    [0x0DA] = "Attack Bonus II",
    [0x0DB] = "Attack +15%",
    [0x0DC] = "Attack +30%",
    [0x0DD] = "Defense Bonus",
    [0x0DE] = "Defense Bonus II",
    [0x0DF] = "Defense +15%",
    [0x0E0] = "Defense +30%",
    [0x0E1] = "Magic Attack Bonus",
    [0x0E2] = "Magic Attack Bonus II",
    [0x0E3] = "Magic Attack +15%",
    [0x0E4] = "Magic Attack +30%",
    [0x0E5] = "Magic Defense Bonus",
    [0x0E6] = "Magic Defense Bonus II",
    [0x0E7] = "Magic Defense +15%",
    [0x0E8] = "Magic Defense +30%",
    [0x0E9] = "Accuracy Bonus",
    [0x0EA] = "Accuracy Bonus II",
    [0x0EB] = "Accuracy +15%",
    [0x0EC] = "Accuracy +30%",
    [0x0ED] = "Magic Accuracy Bonus",
    [0x0EE] = "Magic Accuracy Bonus II",
    [0x0EF] = "Magic Accuracy +15%",
    [0x0F0] = "Magic Accuracy +30%",
    [0x0F1] = "Evasion Bonus",
    [0x0F2] = "Evasion Bonus II",
    [0x0F3] = "Evasion +15%",
    [0x0F4] = "Evasion +30%",
    [0x0F5] = "Critical Hit Bonus",
    [0x0F6] = "Critical Hit Bonus II",
    [0x0F7] = "Critical Hit Rate +10%",
    [0x0F8] = "Critical Hit Rate +20%",
    [0x0F9] = "Interruption Rate Bonus",
    [0x0FA] = "Interruption Rate Bonus II",
    [0x0FB] = "Interruption Rate -25%",
    [0x0FC] = "Interruption Rate -50%",
    [0x0FD] = "Auto Regen",
    [0x0FE] = "Auto Regen II",
    [0x0FF] = "Auto Regen +5",
    [0x100] = "Auto Regen +10",
    [0x101] = "Auto Refresh",
    [0x102] = "Auto Refresh II",
    [0x103] = "Auto Refresh +5",
    [0x104] = "Auto Refresh +10",
    [0x105] = "Auto Regain",
    [0x106] = "Auto Regain II",
    [0x107] = "Auto Regain +3",
    [0x108] = "Auto Regain +6",
    [0x109] = "Store TP",
    [0x10A] = "Store TP II",
    [0x10B] = "Store TP +10%",
    [0x10C] = "Store TP +20%",
    [0x10D] = "Healing Magic Bonus",
    [0x10E] = "Healing Magic Bonus II",
    [0x10F] = "Healing Magic Skill +10%",
    [0x110] = "Healing Magic Skill +20%",
    [0x111] = "Divine Magic Bonus",
    [0x112] = "Divine Magic Bonus II",
    [0x113] = "Divine Magic Skill +10%",
    [0x114] = "Divine Magic Skill +20%",
    [0x115] = "Enhancing Magic Bonus",
    [0x116] = "Enhancing Magic Bonus II",
    [0x117] = "Enhancing Magic Skill +10%",
    [0x118] = "Enhancing Magic Skill +20%",
    [0x119] = "Enfeebling Magic Bonus",
    [0x11A] = "Enfeebling Magic Bonus II",
    [0x11B] = "Enfeebling Magic Skill +10%",
    [0x11C] = "Enfeebling Magic Skill +20%",
    [0x11D] = "Elemental Magic Bonus",
    [0x11E] = "Elemental Magic Bonus II",
    [0x11F] = "Elemental Magic Skill +10%",
    [0x120] = "Elemental Magic Skill +20%",
    [0x121] = "Dark Magic Bonus",
    [0x122] = "Dark Magic Bonus II",
    [0x123] = "Dark Magic Skill +10%",
    [0x124] = "Dark Magic Skill +20%",
    [0x125] = "Singing Bonus",
    [0x126] = "Singing Bonus II",
    [0x127] = "Singing Skill +10%",
    [0x128] = "Singing Skill +20%",
    [0x129] = "Ninjutsu Bonus",
    [0x12A] = "Ninjutsu Bonus II",
    [0x12B] = "Ninjutsu Skill +10%",
    [0x12C] = "Ninjutsu Skill +20%",
    [0x12D] = "Summoning Magic Bonus",
    [0x12E] = "Summoning Magic Bonus II",
    [0x12F] = "Summoning Magic Skill +10%",
    [0x130] = "Summoning Magic Skill +20%",
    [0x131] = "Blue Magic Bonus",
    [0x132] = "Blue Magic Bonus II",
    [0x133] = "Blue Magic Skill +10%",
    [0x134] = "Blue Magic Skill +20%",
    [0x135] = "Movement Speed Bonus",
    [0x136] = "Movement Speed Bonus II",
    [0x137] = "Movement Speed +5",
    [0x138] = "Movement Speed +10",
    [0x139] = "Attack Speed Bonus",
    [0x13A] = "Attack Speed Bonus II",
    [0x13B] = "Attack Speed +50",
    [0x13C] = "Attack Speed +100",
    [0x13D] = "Magic Frequency Bonus",
    [0x13E] = "Magic Frequency Bonus II",
    [0x13F] = "Magic Frequency +3",
    [0x140] = "Magic Frequency +6",
    [0x141] = "Ability Speed Bonus",
    [0x142] = "Ability Speed Bonus II",
    [0x143] = "Ability Speed +15%",
    [0x144] = "Ability Speed +30%",
    [0x145] = "Magic Casting Speed Bonus",
    [0x146] = "Magic Casting Speed Bonus II",
    [0x147] = "Magic Casting Speed +15%",
    [0x148] = "Magic Casting Speed +30%",
    [0x149] = "Ability Recast Speed Bonus",
    [0x14A] = "Ability Recast Speed Bonus II",
    [0x14B] = "Ability Recast Speed +15%",
    [0x14C] = "Ability Recast Speed +30%",
    [0x14D] = "Magic Recast Bonus",
    [0x14E] = "Magic Recast Bonus II",
    [0x14F] = "Magic Recast Speed +25%",
    [0x150] = "Magic Recast Speed +50%",
    [0x151] = "Ability Range Bonus",
    [0x152] = "Ability Range Bonus II",
    [0x153] = "Ability Range +2",
    [0x154] = "Ability Range +4",
    [0x155] = "Magic Range Bonus",
    [0x156] = "Magic Range Bonus II",
    [0x157] = "Magic Range +2",
    [0x158] = "Magic Range +4",
    [0x159] = "Ability Acquisition Bonus",
    [0x15A] = "Ability Acquisition Bonus II",
    [0x15B] = "Ability Acquisition Level -5",
    [0x15C] = "Ability Acquisition Level -10",
    [0x15D] = "Magic Acquisition Bonus",
    [0x15E] = "Magic Acquisition Bonus II",
    [0x15F] = "Magic Acquisition Level -5",
    [0x160] = "Magic Acquisition Level -10",
}

xi.znm.soultrapperOnItemCheck = function(target, user)
    if not user:isFacing(target) then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    local id = user:getEquipID(xi.slot.AMMO)
    if
        id ~= xi.items.BLANK_SOUL_PLATE and
        id ~= xi.items.BLANK_HIGH_SPEED_SOUL_PLATE
    then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end
    
    if user:getFreeSlotsCount() == 0 then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end
    
    return 0
end

xi.znm.soultrapperOnItemUse = function(target, user)
    local name = target:getName()
    local hpp = target:getHPP()
    local system = target:getSystem()
    local isNM = target:isNM()
    local distance = user:checkDistance(target)
    local isFacing = target:isFacing(user)
    
    -- TODO: Determine a skill, and get its index
    local skillIndex = 0x09B -- <VIT +25>

    -- Determine FP value
    local fp = 5

    -- HP% Component: x1 at 100%, x10 at 1%
    fp = fp * math.min(100 / hpp, 10)

    -- In-Demand System Component
    -- TODO: Make rotating server var
    local inDemandSystem = 10 -- Dragons
    if system == inDemandSystem then
        fp = fp * 1.5
    end

    -- NM/Rarity Component
    if isNM then
        fp = fp * 1.5
    end
    
    -- Distance Component
    fp = fp * math.max((1 / distance) * 2, 1)

    -- Angle/Facing Component
    if isFacing then
        fp = fp * 1.5
    end

    local plate = user:addSoulPlate(name, skillIndex, fp)
    local data = plate:getSoulPlateData()
    utils.unused(data)
    
    -- print("Stats:")
    -- print("Name: " .. name .. ", HPP: " .. hpp .. ", System: " .. system)
    -- print("Distance: " .. distance .. ", isFacing: " .. tostring(isFacing).. ", isNM: " .. tostring(isNM))
    -- print("Soul Plate:")
    -- print("Name: " .. data.name .. ", Skill: " .. data.skillIndex .. ", FP: " .. data.fp)
end
