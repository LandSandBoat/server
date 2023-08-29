-----------------------------------
-- Pankration System + Helpers
-----------------------------------
require('scripts/globals/magic')
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.pankration = xi.pankration or {}

-- https://www.bg-wiki.com/ffxi/Category:Pankration#Prohibited_Monsters
-- IDs from mob_family_system.sql
-- We only store the family, not the ecosystem, so we have to lookup
-- based on that
xi.pankration.prohibitedFamilies =
{
    -- All Beastmen
    25, -- Antica
    59, -- Bugbear
    126, 127, 128, 129, 130, -- Gigas
    133, -- Goblin
    171, -- Lamiae
    176, 177, -- Mamool Ja
    189, -- Orc
    190, -- Orcish Warmachine
    196, -- Poroggo
    199, -- Qiqirn
    200, 201, 202, -- Quadav
    213, -- Sahagin
    243, 244, -- Tonbery
    246, -- Troll
    270, -- Yagudo

    -- All Empty
    78, -- Craver
    137, 138, -- Gorger
    181, -- Receptacle
    220, -- Seether
    241, -- Thinker
    255, -- Wanderer
    256, -- Weeper

    -- All Luminians
    3, -- Aern
    109, -- Euvhi
    144, -- Hpemde
    194, -- Phuabo
    269, -- Xzomit
    271, -- Yorva

    -- All Luminions
    122, 123, 124, -- Ghrah
    272, -- Zdei

    -- Avatar
    34, -- Carbuncle
    35, -- Diabolos
    37, -- Garuda
    38, -- Ifrit
    40, -- Leviathan
    43, -- Ramuh
    44, -- Shiva
    45, -- Titan

    -- Biotechnological Weapons
    54, -- Omega & Ultima

    2, -- Adamantoise
    28, 29, 30, 31, -- Automation
    51, -- Behemoth
    61, -- Cardian
    62, -- Cerberus
    -- Demon
    -- Devrgr
    115, 359, -- Fomor
    140, 141, -- Hippogryph
    163, 164, -- Hydra
    -- Khamaira
    193, -- Pet Wyvern
    251, -- Uragnite
    252, -- Vampyr
    259, 260, 261, 262, 263, 264, 391, 392, 393, -- Wyrm
}

-- https://github.com/Windower/Lua/blob/dev/addons/libs/extdata.lua
-- https://www.bg-wiki.com/ffxi/Feral_Skills_Guide_by_Shoya
-- https://ffxiclopedia.fandom.com/wiki/Category:Feral_Skills
xi.pankration.feralSkills =
{
    [0x001] = { text = 'Main Job: Warrior',      fp = 8 },
    [0x002] = { text = 'Main Job: Monk',         fp = 8 },
    [0x003] = { text = 'Main Job: White Mage',   fp = 8 },
    [0x004] = { text = 'Main Job: Black Mage',   fp = 8 },
    [0x005] = { text = 'Main Job: Red Mage',     fp = 8 },
    [0x006] = { text = 'Main Job: Thief',        fp = 8 },
    [0x007] = { text = 'Main Job: Paladin',      fp = 8 },
    [0x008] = { text = 'Main Job: Dark Knight',  fp = 8 },
    [0x009] = { text = 'Main Job: Beastmaster',  fp = 8 },
    [0x00A] = { text = 'Main Job: Bard',         fp = 8 },
    [0x00B] = { text = 'Main Job: Ranger',       fp = 8 },
    [0x00C] = { text = 'Main Job: Samurai',      fp = 8 },
    [0x00D] = { text = 'Main Job: Ninja',        fp = 8 },
    [0x00E] = { text = 'Main Job: Dragoon',      fp = 8 },
    [0x00F] = { text = 'Main Job: Summoner',     fp = 8 },
    [0x010] = { text = 'Main Job: Blue Mage',    fp = 8 },
    [0x011] = { text = 'Main Job: Corsair',      fp = 8 },
    [0x012] = { text = 'Main Job: Puppetmaster', fp = 8 },
    -- Intentional Gap
    [0x01F] = { text = 'Support Job: Warrior',      fp = 8 },
    [0x020] = { text = 'Support Job: Monk',         fp = 8 },
    [0x021] = { text = 'Support Job: White Mage',   fp = 8 },
    [0x022] = { text = 'Support Job: Black Mage',   fp = 8 },
    [0x023] = { text = 'Support Job: Red Mage',     fp = 8 },
    [0x024] = { text = 'Support Job: Thief',        fp = 8 },
    [0x025] = { text = 'Support Job: Paladin',      fp = 8 },
    [0x026] = { text = 'Support Job: Dark Knight',  fp = 8 },
    [0x027] = { text = 'Support Job: Beastmaster',  fp = 8 },
    [0x028] = { text = 'Support Job: Bard',         fp = 8 },
    [0x029] = { text = 'Support Job: Ranger',       fp = 8 },
    [0x02A] = { text = 'Support Job: Samurai',      fp = 8 },
    [0x02B] = { text = 'Support Job: Ninja',        fp = 8 },
    [0x02C] = { text = 'Support Job: Dragoon',      fp = 8 },
    [0x02D] = { text = 'Support Job: Summoner',     fp = 8 },
    [0x02E] = { text = 'Support Job: Blue Mage',    fp = 8 },
    [0x02F] = { text = 'Support Job: Corsair',      fp = 8 },
    [0x030] = { text = 'Support Job: Puppetmaster', fp = 8 },
    -- Intentional Gap
    [0x03D] = { text = 'Job Ability: Warrior',      fp = 8 },
    [0x03E] = { text = 'Job Ability: Monk',         fp = 8 },
    [0x03F] = { text = 'Job Ability: White Mage',   fp = 8 },
    [0x040] = { text = 'Job Ability: Black Mage',   fp = 8 },
    [0x041] = { text = 'Job Ability: Red Mage',     fp = 8 },
    [0x042] = { text = 'Job Ability: Thief',        fp = 8 },
    [0x043] = { text = 'Job Ability: Paladin',      fp = 8 },
    [0x044] = { text = 'Job Ability: Dark Knight',  fp = 8 },
    [0x045] = { text = 'Job Ability: Beastmaster',  fp = 8 },
    [0x046] = { text = 'Job Ability: Bard',         fp = 8 },
    [0x047] = { text = 'Job Ability: Ranger',       fp = 8 },
    [0x048] = { text = 'Job Ability: Samurai',      fp = 8 },
    [0x049] = { text = 'Job Ability: Ninja',        fp = 8 },
    [0x04A] = { text = 'Job Ability: Dragoon',      fp = 8 },
    [0x04B] = { text = 'Job Ability: Summoner',     fp = 8 },
    [0x04C] = { text = 'Job Ability: Blue Mage',    fp = 8 },
    [0x04D] = { text = 'Job Ability: Corsair',      fp = 8 },
    [0x04E] = { text = 'Job Ability: Puppetmaster', fp = 8 },
    -- Intentional Gap
    [0x05B] = { text = 'Job Trait: Warrior',      fp = 12 },
    [0x05C] = { text = 'Job Trait: Monk',         fp = 12 },
    [0x05D] = { text = 'Job Trait: White Mage',   fp = 12 },
    [0x05E] = { text = 'Job Trait: Black Mage',   fp = 12 },
    [0x05F] = { text = 'Job Trait: Red Mage',     fp = 12 },
    [0x060] = { text = 'Job Trait: Thief',        fp = 12 },
    [0x061] = { text = 'Job Trait: Paladin',      fp = 12 },
    [0x062] = { text = 'Job Trait: Dark Knight',  fp = 12 },
    [0x063] = { text = 'Job Trait: Beastmaster',  fp = 12 },
    [0x064] = { text = 'Job Trait: Bard',         fp = 12 },
    [0x065] = { text = 'Job Trait: Ranger',       fp = 12 },
    [0x066] = { text = 'Job Trait: Samurai',      fp = 12 },
    [0x067] = { text = 'Job Trait: Ninja',        fp = 12 },
    [0x068] = { text = 'Job Trait: Dragoon',      fp = 12 },
    [0x069] = { text = 'Job Trait: Summoner',     fp = 12 },
    [0x06A] = { text = 'Job Trait: Blue Mage',    fp = 12 },
    [0x06B] = { text = 'Job Trait: Corsair',      fp = 12 },
    [0x06C] = { text = 'Job Trait: Puppetmaster', fp = 12 },
    -- Intentional Gap
    [0x079] = { text = 'White Magic Scrolls', fp = 17 },
    [0x07A] = { text = 'Black Magic Scrolls', fp = 17 },
    [0x07B] = { text = 'Bard Scrolls',        fp = 17 },
    [0x07C] = { text = 'Ninjutsu Scrolls',    fp = 17 },
    [0x07D] = { text = 'Avatar Scrolls',      fp = 17 },
    [0x07E] = { text = 'Blue Magic Scrolls',  fp = 17 },
    [0x07F] = { text = 'Corsair Dice',        fp = 17 },
    -- Intentional Gap
    [0x08D] = { text = 'HP Max Bonus',    fp = 8 },
    [0x08E] = { text = 'HP Max Bonus II', fp = 8 },
    [0x08F] = { text = 'HP Max +50',      fp = 8 },
    [0x090] = { text = 'HP Max +100',     fp = 8 },
    [0x091] = { text = 'MP Max Bonus',    fp = 8 },
    [0x092] = { text = 'MP Max Bonus II', fp = 8 },
    [0x093] = { text = 'MP Max +50',      fp = 8 },
    [0x094] = { text = 'MP Max +100',     fp = 8 },
    [0x095] = { text = 'STR Bonus',       fp = 8 },
    [0x096] = { text = 'STR Bonus II',    fp = 8 },
    [0x097] = { text = 'STR +25',         fp = 8 },
    [0x098] = { text = 'STR +50',         fp = 8 },
    [0x099] = { text = 'VIT Bonus',       fp = 8 },
    [0x09A] = { text = 'VIT Bonus II',    fp = 8 },
    [0x09B] = { text = 'VIT +25',         fp = 8 },
    [0x09C] = { text = 'VIT +50',         fp = 8 },
    [0x09D] = { text = 'AGI Bonus',       fp = 8 },
    [0x09E] = { text = 'AGI Bonus II',    fp = 8 },
    [0x09F] = { text = 'AGI +25',         fp = 8 },
    [0x0A0] = { text = 'AGI +50',         fp = 8 },
    [0x0A1] = { text = 'DEX Bonus',       fp = 8 },
    [0x0A2] = { text = 'DEX Bonus II',    fp = 8 },
    [0x0A3] = { text = 'DEX +25',         fp = 8 },
    [0x0A4] = { text = 'DEX +50',         fp = 8 },
    [0x0A5] = { text = 'INT Bonus',       fp = 8 },
    [0x0A6] = { text = 'INT Bonus II',    fp = 8 },
    [0x0A7] = { text = 'INT +25',         fp = 8 },
    [0x0A8] = { text = 'INT +50',         fp = 8 },
    [0x0A9] = { text = 'MND Bonus',       fp = 8 },
    [0x0AA] = { text = 'MND Bonus II',    fp = 8 },
    [0x0AB] = { text = 'MND +25',         fp = 8 },
    [0x0AC] = { text = 'MND +50',         fp = 8 },
    [0x0AD] = { text = 'CHR Bonus',       fp = 8 },
    [0x0AE] = { text = 'CHR Bonus II',    fp = 8 },
    [0x0AF] = { text = 'CHR +25',         fp = 8 },
    [0x0B0] = { text = 'CHR +50',         fp = 8 },
    -- Intentional Gap
    [0x0C9] = { text = 'Monster Level Bonus',             fp = 8 },
    [0x0CA] = { text = 'Monster Level Bonus II',          fp = 8 },
    [0x0CB] = { text = 'Monster Level +2',                fp = 8 },
    [0x0CC] = { text = 'Monster Level +4',                fp = 8 },
    [0x0CD] = { text = 'Skill Level Bonus',               fp = 8 },
    [0x0CE] = { text = 'Skill Level Bonus II',            fp = 8 },
    [0x0CF] = { text = 'Skill Level +4',                  fp = 8 },
    [0x0D0] = { text = 'Skill Level +8',                  fp = 8 },
    [0x0D1] = { text = 'HP Max Rate Bonus',               fp = 8 },
    [0x0D2] = { text = 'HP Max Rate Bonus II',            fp = 8 },
    [0x0D3] = { text = 'HP Max +15%',                     fp = 8 },
    [0x0D4] = { text = 'HP Max +30%',                     fp = 8 },
    [0x0D5] = { text = 'MP Max Rate Bonus',               fp = 8 },
    [0x0D6] = { text = 'MP Max Rate Bonus II',            fp = 8 },
    [0x0D7] = { text = 'MP Max +15%',                     fp = 8 },
    [0x0D8] = { text = 'MP Max +30%',                     fp = 8 },
    [0x0D9] = { text = 'Attack Bonus',                    fp = 8 },
    [0x0DA] = { text = 'Attack Bonus II',                 fp = 8 },
    [0x0DB] = { text = 'Attack +15%',                     fp = 8 },
    [0x0DC] = { text = 'Attack +30%',                     fp = 8 },
    [0x0DD] = { text = 'Defense Bonus',                   fp = 8 },
    [0x0DE] = { text = 'Defense Bonus II',                fp = 8 },
    [0x0DF] = { text = 'Defense +15%',                    fp = 8 },
    [0x0E0] = { text = 'Defense +30%',                    fp = 8 },
    [0x0E1] = { text = 'Magic Attack Bonus',              fp = 8 },
    [0x0E2] = { text = 'Magic Attack Bonus II',           fp = 8 },
    [0x0E3] = { text = 'Magic Attack +15%',               fp = 8 },
    [0x0E4] = { text = 'Magic Attack +30%',               fp = 8 },
    [0x0E5] = { text = 'Magic Defense Bonus',             fp = 8 },
    [0x0E6] = { text = 'Magic Defense Bonus II',          fp = 8 },
    [0x0E7] = { text = 'Magic Defense +15%',              fp = 8 },
    [0x0E8] = { text = 'Magic Defense +30%',              fp = 8 },
    [0x0E9] = { text = 'Accuracy Bonus',                  fp = 8 },
    [0x0EA] = { text = 'Accuracy Bonus II',               fp = 8 },
    [0x0EB] = { text = 'Accuracy +15%',                   fp = 8 },
    [0x0EC] = { text = 'Accuracy +30%',                   fp = 8 },
    [0x0ED] = { text = 'Magic Accuracy Bonus',            fp = 8 },
    [0x0EE] = { text = 'Magic Accuracy Bonus II',         fp = 8 },
    [0x0EF] = { text = 'Magic Accuracy +15%',             fp = 8 },
    [0x0F0] = { text = 'Magic Accuracy +30%',             fp = 8 },
    [0x0F1] = { text = 'Evasion Bonus',                   fp = 8 },
    [0x0F2] = { text = 'Evasion Bonus II',                fp = 8 },
    [0x0F3] = { text = 'Evasion +15%',                    fp = 8 },
    [0x0F4] = { text = 'Evasion +30%',                    fp = 8 },
    [0x0F5] = { text = 'Critical Hit Bonus',              fp = 8 },
    [0x0F6] = { text = 'Critical Hit Bonus II',           fp = 8 },
    [0x0F7] = { text = 'Critical Hit Rate +10%',          fp = 8 },
    [0x0F8] = { text = 'Critical Hit Rate +20%',          fp = 8 },
    [0x0F9] = { text = 'Interruption Rate Bonus',         fp = 8 },
    [0x0FA] = { text = 'Interruption Rate Bonus II',      fp = 8 },
    [0x0FB] = { text = 'Interruption Rate -25%',          fp = 8 },
    [0x0FC] = { text = 'Interruption Rate -50%',          fp = 8 },
    [0x0FD] = { text = 'Auto Regen',                      fp = 8 },
    [0x0FE] = { text = 'Auto Regen II',                   fp = 8 },
    [0x0FF] = { text = 'Auto Regen +5',                   fp = 8 },
    [0x100] = { text = 'Auto Regen +10',                  fp = 8 },
    [0x101] = { text = 'Auto Refresh',                    fp = 8 },
    [0x102] = { text = 'Auto Refresh II',                 fp = 8 },
    [0x103] = { text = 'Auto Refresh +5',                 fp = 8 },
    [0x104] = { text = 'Auto Refresh +10',                fp = 8 },
    [0x105] = { text = 'Auto Regain',                     fp = 8 },
    [0x106] = { text = 'Auto Regain II',                  fp = 8 },
    [0x107] = { text = 'Auto Regain +3',                  fp = 8 },
    [0x108] = { text = 'Auto Regain +6',                  fp = 8 },
    [0x109] = { text = 'Store TP',                        fp = 8 },
    [0x10A] = { text = 'Store TP II',                     fp = 8 },
    [0x10B] = { text = 'Store TP +10%',                   fp = 8 },
    [0x10C] = { text = 'Store TP +20%',                   fp = 8 },
    [0x10D] = { text = 'Healing Magic Bonus',             fp = 8 },
    [0x10E] = { text = 'Healing Magic Bonus II',          fp = 8 },
    [0x10F] = { text = 'Healing Magic Skill +10%',        fp = 8 },
    [0x110] = { text = 'Healing Magic Skill +20%',        fp = 8 },
    [0x111] = { text = 'Divine Magic Bonus',              fp = 8 },
    [0x112] = { text = 'Divine Magic Bonus II',           fp = 8 },
    [0x113] = { text = 'Divine Magic Skill +10%',         fp = 8 },
    [0x114] = { text = 'Divine Magic Skill +20%',         fp = 8 },
    [0x115] = { text = 'Enhancing Magic Bonus',           fp = 8 },
    [0x116] = { text = 'Enhancing Magic Bonus II',        fp = 8 },
    [0x117] = { text = 'Enhancing Magic Skill +10%',      fp = 8 },
    [0x118] = { text = 'Enhancing Magic Skill +20%',      fp = 8 },
    [0x119] = { text = 'Enfeebling Magic Bonus',          fp = 8 },
    [0x11A] = { text = 'Enfeebling Magic Bonus II',       fp = 8 },
    [0x11B] = { text = 'Enfeebling Magic Skill +10%',     fp = 8 },
    [0x11C] = { text = 'Enfeebling Magic Skill +20%',     fp = 8 },
    [0x11D] = { text = 'Elemental Magic Bonus',           fp = 8 },
    [0x11E] = { text = 'Elemental Magic Bonus II',        fp = 8 },
    [0x11F] = { text = 'Elemental Magic Skill +10%',      fp = 8 },
    [0x120] = { text = 'Elemental Magic Skill +20%',      fp = 8 },
    [0x121] = { text = 'Dark Magic Bonus',                fp = 8 },
    [0x122] = { text = 'Dark Magic Bonus II',             fp = 8 },
    [0x123] = { text = 'Dark Magic Skill +10%',           fp = 8 },
    [0x124] = { text = 'Dark Magic Skill +20%',           fp = 8 },
    [0x125] = { text = 'Singing Bonus',                   fp = 8 },
    [0x126] = { text = 'Singing Bonus II',                fp = 8 },
    [0x127] = { text = 'Singing Skill +10%',              fp = 8 },
    [0x128] = { text = 'Singing Skill +20%',              fp = 8 },
    [0x129] = { text = 'Ninjutsu Bonus',                  fp = 8 },
    [0x12A] = { text = 'Ninjutsu Bonus II',               fp = 8 },
    [0x12B] = { text = 'Ninjutsu Skill +10%',             fp = 8 },
    [0x12C] = { text = 'Ninjutsu Skill +20%',             fp = 8 },
    [0x12D] = { text = 'Summoning Magic Bonus',           fp = 8 },
    [0x12E] = { text = 'Summoning Magic Bonus II',        fp = 8 },
    [0x12F] = { text = 'Summoning Magic Skill +10%',      fp = 8 },
    [0x130] = { text = 'Summoning Magic Skill +20%',      fp = 8 },
    [0x131] = { text = 'Blue Magic Bonus',                fp = 8 },
    [0x132] = { text = 'Blue Magic Bonus II',             fp = 8 },
    [0x133] = { text = 'Blue Magic Skill +10%',           fp = 8 },
    [0x134] = { text = 'Blue Magic Skill +20%',           fp = 8 },
    [0x135] = { text = 'Movement Speed Bonus',            fp = 8 },
    [0x136] = { text = 'Movement Speed Bonus II',         fp = 8 },
    [0x137] = { text = 'Movement Speed +5',               fp = 8 },
    [0x138] = { text = 'Movement Speed +10',              fp = 8 },
    [0x139] = { text = 'Attack Speed Bonus',              fp = 8 },
    [0x13A] = { text = 'Attack Speed Bonus II',           fp = 8 },
    [0x13B] = { text = 'Attack Speed +50',                fp = 8 },
    [0x13C] = { text = 'Attack Speed +100',               fp = 8 },
    [0x13D] = { text = 'Magic Frequency Bonus',           fp = 8 },
    [0x13E] = { text = 'Magic Frequency Bonus II',        fp = 8 },
    [0x13F] = { text = 'Magic Frequency +3',              fp = 8 },
    [0x140] = { text = 'Magic Frequency +6',              fp = 8 },
    [0x141] = { text = 'Ability Speed Bonus',             fp = 8 },
    [0x142] = { text = 'Ability Speed Bonus II',          fp = 8 },
    [0x143] = { text = 'Ability Speed +15%',              fp = 8 },
    [0x144] = { text = 'Ability Speed +30%',              fp = 8 },
    [0x145] = { text = 'Magic Casting Speed Bonus',       fp = 8 },
    [0x146] = { text = 'Magic Casting Speed Bonus II',    fp = 8 },
    [0x147] = { text = 'Magic Casting Speed +15%',        fp = 8 },
    [0x148] = { text = 'Magic Casting Speed +30%',        fp = 8 },
    [0x149] = { text = 'Ability Recast Speed Bonus',      fp = 8 },
    [0x14A] = { text = 'Ability Recast Speed Bonus II',   fp = 8 },
    [0x14B] = { text = 'Ability Recast Speed +15%',       fp = 8 },
    [0x14C] = { text = 'Ability Recast Speed +30%',       fp = 8 },
    [0x14D] = { text = 'Magic Recast Bonus',              fp = 8 },
    [0x14E] = { text = 'Magic Recast Bonus II',           fp = 8 },
    [0x14F] = { text = 'Magic Recast Speed +25%',         fp = 8 },
    [0x150] = { text = 'Magic Recast Speed +50%',         fp = 8 },
    [0x151] = { text = 'Ability Range Bonus',             fp = 8 },
    [0x152] = { text = 'Ability Range Bonus II',          fp = 8 },
    [0x153] = { text = 'Ability Range +2',                fp = 8 },
    [0x154] = { text = 'Ability Range +4',                fp = 8 },
    [0x155] = { text = 'Magic Range Bonus',               fp = 8 },
    [0x156] = { text = 'Magic Range Bonus II',            fp = 8 },
    [0x157] = { text = 'Magic Range +2',                  fp = 8 },
    [0x158] = { text = 'Magic Range +4',                  fp = 8 },
    [0x159] = { text = 'Ability Acquisition Bonus',       fp = 8 },
    [0x15A] = { text = 'Ability Acquisition Bonus II',    fp = 8 },
    [0x15B] = { text = 'Ability Acquisition Level -5',    fp = 8 },
    [0x15C] = { text = 'Ability Acquisition Level -10',   fp = 8 },
    [0x15D] = { text = 'Magic Acquisition Bonus',         fp = 8 },
    [0x15E] = { text = 'Magic Acquisition Bonus II',      fp = 8 },
    [0x15F] = { text = 'Magic Acquisition Level -5',      fp = 8 },
    [0x160] = { text = 'Magic Acquisition Level -10',     fp = 8 },
    [0x161] = { text = 'Healing Potency Bonus',           fp = 8 },
    [0x162] = { text = 'Healing Potency Bonus II',        fp = 8 },
    [0x163] = { text = 'Healing Potency +40',             fp = 8 },
    [0x164] = { text = 'Healing Potency +80',             fp = 8 },
    [0x165] = { text = 'MP Recovery Bonus',               fp = 8 },
    [0x166] = { text = 'MP Recovery Bonus II',            fp = 8 },
    [0x167] = { text = 'MP Recovery +25',                 fp = 8 },
    [0x168] = { text = 'MP Recovery +50',                 fp = 8 },
    [0x169] = { text = 'TP Recovery Bonus',               fp = 8 },
    [0x16A] = { text = 'TP Recovery Bonus II',            fp = 8 },
    [0x16B] = { text = 'TP Recovery +25',                 fp = 8 },
    [0x16C] = { text = 'TP Recovery +50',                 fp = 8 },
    [0x16D] = { text = '50% MP Conserve Rate Bonus',      fp = 8 },
    [0x16E] = { text = '50% MP Conserve Rate Bonus II',   fp = 8 },
    [0x16F] = { text = '50% MP Conserve Rate +15%',       fp = 8 },
    [0x170] = { text = '50% MP Conserve Rate +30%',       fp = 8 },
    [0x171] = { text = '100% MP Conserve Rate Bonus',     fp = 8 },
    [0x172] = { text = '100% MP Conserve Rate Bonus II',  fp = 8 },
    [0x173] = { text = '100% MP Conserve Rate +15%',      fp = 8 },
    [0x174] = { text = '100% MP Conserve Rate +30%',      fp = 8 },
    [0x175] = { text = '50% TP Conserve Rate Bonus',      fp = 8 },
    [0x176] = { text = '50% TP Conserve Rate Bonus II',   fp = 8 },
    [0x177] = { text = '50% TP Conserve Rate +15%',       fp = 8 },
    [0x178] = { text = '50% TP Conserve Rate +30%',       fp = 8 },
    [0x179] = { text = '100% TP Conserve Rate Bonus',     fp = 8 },
    [0x17A] = { text = '100% TP Conserve Rate Bonus II',  fp = 8 },
    [0x17B] = { text = '100% TP Conserve Rate +15%',      fp = 8 },
    [0x17C] = { text = '100% TP Conserve Rate +30%',      fp = 8 },
    [0x17D] = { text = 'EXP Bonus',                       fp = 8 },
    [0x17E] = { text = 'EXP Bonus II',                    fp = 8 },
    [0x17F] = { text = 'EXP +15%',                        fp = 8 },
    [0x180] = { text = 'EXP +30%',                        fp = 8 },
    [0x181] = { text = 'Skill Improvement Rate Bonus',    fp = 8 },
    [0x182] = { text = 'Skill Improvement Rate Bonus II', fp = 8 },
    [0x183] = { text = 'Skill Improvement Rate +15%',     fp = 8 },
    [0x184] = { text = 'Skill Improvement Rate +30%',     fp = 8 },
    [0x185] = { text = 'Trust Bonus',                     fp = 8 },
    [0x186] = { text = 'Trust Bonus II',                  fp = 8 },
    [0x187] = { text = 'Trust +15',                       fp = 8 },
    [0x188] = { text = 'Trust +30',                       fp = 8 },
    -- Intentional Gap
    [0x195] = { text = 'Embiggen',    fp = 8 },
    [0x196] = { text = 'Embiggen II', fp = 8 },
    [0x197] = { text = 'Minimize',    fp = 8 },
    [0x198] = { text = 'Minimize II', fp = 8 },
    -- Intentional Gap
    [0x19D] = { text = 'Gradual HP Max Bonus',                fp = 8 },
    [0x19E] = { text = 'Diminishing HP Max Bonus',            fp = 8 },
    [0x19F] = { text = 'Gradual MP Max Bonus',                fp = 8 },
    [0x1A0] = { text = 'Diminishing MP Max Bonus',            fp = 8 },
    [0x1A1] = { text = 'Gradual Attack Bonus',                fp = 8 },
    [0x1A2] = { text = 'Diminishing Attack Bonus',            fp = 8 },
    [0x1A3] = { text = 'Gradual Defense Bonus',               fp = 8 },
    [0x1A4] = { text = 'Diminishing Defense Bonus',           fp = 8 },
    [0x1A5] = { text = 'Gradual Magic Attack Bonus',          fp = 8 },
    [0x1A6] = { text = 'Diminishing Magic Attack Bonus',      fp = 8 },
    [0x1A7] = { text = 'Gradual Magic Defense Bonus',         fp = 8 },
    [0x1A8] = { text = 'Diminishing Magic Defense Bonus',     fp = 8 },
    [0x1A9] = { text = 'Gradual Accuracy Bonus',              fp = 8 },
    [0x1B0] = { text = 'Diminishing Accuracy Bonus',          fp = 8 },
    [0x1B1] = { text = 'Gradual Magic Accuracy Bonus',        fp = 8 },
    [0x1B2] = { text = 'Diminishing Magic Accuracy Bonus',    fp = 8 },
    [0x1B3] = { text = 'Gradual Evasion Bonus',               fp = 8 },
    [0x1B4] = { text = 'Diminishing Evasion Bonus',           fp = 8 },
    [0x1B5] = { text = 'Gradual Critial Hit Rate Bonus',      fp = 8 },
    [0x1B6] = { text = 'Diminishing Critial Hit Rate Bonus',  fp = 8 },
    [0x1B7] = { text = 'Gradual Interruption Rate Bonus',     fp = 8 },
    [0x1B8] = { text = 'Diminishing Interruption Rate Bonus', fp = 8 },
    [0x1B9] = { text = 'Gradual EXP Bonus',                   fp = 8 },
    [0x1BA] = { text = 'Diminishing EXP Bonus',               fp = 8 },
    [0x1BB] = { text = 'Resist Poison',                       fp = 8 },
    [0x1BC] = { text = 'Resist Sleep',                        fp = 8 },
    [0x1BD] = { text = 'Resist Blind',                        fp = 8 },
    [0x1BE] = { text = 'Resist Slow',                         fp = 8 },
    [0x1BF] = { text = 'Resist Paralysis',                    fp = 8 },
    [0x1C0] = { text = 'Resist Bind',                         fp = 8 },
    [0x1C1] = { text = 'Resist Silence',                      fp = 8 },
    [0x1C2] = { text = 'Bird Killer',                         fp = 8 },
    [0x1C3] = { text = 'Amorph Killer',                       fp = 8 },
    [0x1C4] = { text = 'Lizard Killer',                       fp = 8 },
    [0x1C5] = { text = 'Aquan Killer',                        fp = 8 },
    [0x1C6] = { text = 'Plantoid Killer',                     fp = 8 },
    [0x1C7] = { text = 'Beast Killer',                        fp = 8 },
    [0x1C8] = { text = 'Demon Killer',                        fp = 8 },
    [0x1C9] = { text = 'Dragon Killer',                       fp = 8 },
    [0x1CA] = { text = 'Double Attack',                       fp = 8 },
    [0x1CB] = { text = 'Double Attack II',                    fp = 8 },
    [0x1CC] = { text = 'Double Attack Rate +15%',             fp = 8 },
    [0x1CD] = { text = 'Double Attack Rate +30%',             fp = 8 },
    [0x1CE] = { text = 'Triple Attack',                       fp = 8 },
    [0x1CF] = { text = 'Triple Attack II',                    fp = 8 },
    [0x1D0] = { text = 'Triple Attack Rate +15%',             fp = 8 },
    [0x1D1] = { text = 'Triple Attack Rate +30%',             fp = 8 },
    [0x1D2] = { text = 'Counter',                             fp = 8 },
    [0x1D3] = { text = 'Counter II',                          fp = 8 },
    [0x1D4] = { text = 'Counter Rate +15%',                   fp = 8 },
    [0x1D5] = { text = 'Counter Rate +30%',                   fp = 8 },
    [0x1D6] = { text = 'Subtle Blow',                         fp = 8 },
    [0x1D7] = { text = 'Subtle Blow II',                      fp = 8 },
    [0x1D8] = { text = 'Subtle Blow Rate +15%',               fp = 8 },
    [0x1D9] = { text = 'Subtle Blow Rate +30%',               fp = 8 },
    [0x1DA] = { text = 'Savagery',                            fp = 8 },
    [0x1DB] = { text = 'Aggressive Aim',                      fp = 8 },
    [0x1DC] = { text = 'Martial Arts',                        fp = 8 },
    [0x1DD] = { text = 'Kick Attacks',                        fp = 8 },
    [0x1DE] = { text = 'Invigorate',                          fp = 8 },
    [0x1DF] = { text = 'Penance',                             fp = 8 },
    [0x1E0] = { text = 'Clear Mind',                          fp = 8 },
    [0x1E1] = { text = 'Divine Veil',                         fp = 8 },
    [0x1E2] = { text = 'Assassin',                            fp = 8 },
    [0x1E3] = { text = 'Aura Steal',                          fp = 8 },
    [0x1E4] = { text = 'Ambush',                              fp = 8 },
    [0x1E5] = { text = 'Shield Mastery',                      fp = 8 },
    [0x1E6] = { text = 'Iron Will',                           fp = 8 },
    [0x1E7] = { text = 'Guardian',                            fp = 8 },
    [0x1E8] = { text = 'Muted Soul',                          fp = 8 },
    [0x1E9] = { text = 'Desperate Blows',                     fp = 8 },
    [0x1EA] = { text = 'Carrot Broth',                        fp = 8 },
    [0x1EB] = { text = 'Herbal Broth',                        fp = 8 },
    [0x1EC] = { text = 'Fish Broth',                          fp = 8 },
    [0x1ED] = { text = 'Alchemist\'s Water',                  fp = 8 },
    [0x1EE] = { text = 'Meat Broth',                          fp = 8 },
    [0x1EF] = { text = 'Bug Broth',                           fp = 8 },
    [0x1F0] = { text = 'Carrion Broth',                       fp = 8 },
    [0x1F1] = { text = 'Seedbed Soil',                        fp = 8 },
    [0x1F2] = { text = 'Tree Sap',                            fp = 8 },
    [0x1F3] = { text = 'Beast Affinity',                      fp = 8 },
    [0x1F4] = { text = 'Beast Healer',                        fp = 8 },
    [0x1F5] = { text = 'Alertness',                           fp = 8 },
    [0x1F6] = { text = 'Recycle',                             fp = 8 },
    [0x1F7] = { text = 'Rapid Shot',                          fp = 8 },
    [0x1F8] = { text = 'Snapshot',                            fp = 8 },
    [0x1F9] = { text = 'Zanshin',                             fp = 8 },
    [0x1FA] = { text = 'Overwhelm',                           fp = 8 },
    [0x1FB] = { text = 'Ikishoten',                           fp = 8 },
    [0x1FC] = { text = 'Stealth',                             fp = 8 },
    [0x1FD] = { text = 'Dual Wield',                          fp = 8 },
    [0x1FE] = { text = 'Ninja Tool Expertise',                fp = 8 },
    [0x1FF] = { text = 'Ninja Tool Supply',                   fp = 8 },

    -- NOTE: The maths inside get/setSoulPlateData() is a little wonky
    --       and wraps around at 0x200. There are many more feral
    --       skills that are not yet mapped!
}
