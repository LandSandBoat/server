-----------------------------------
-- Pankration System + Helpers
-----------------------------------
require('scripts/globals/magic')
-----------------------------------
xi = xi or {}
xi.pankration = xi.pankration or {}

-- https://www.bg-wiki.com/ffxi/Category:Pankration#Prohibited_Monsters
-- IDs from mob_family_system.sql
-- We only store the family, not the ecosystem, so we have to lookup
-- based on that
xi.pankration.prohibitedFamilies =
set{
    -- All Beastmen
    25, -- Antica
    59, -- Bugbear
    126, -- Gigas
    127,
    128,
    129,
    130,
    133, -- Goblin
    171, -- Lamiae
    176, -- Mamool Ja
    177,
    189, -- Orc
    190, -- Orcish Warmachine
    196, -- Poroggo
    199, -- Qiqirn
    200, -- Quadav
    201,
    202,
    213, -- Sahagin
    243, -- Tonberries
    244,
    246, -- Troll
    270, -- Yagudo

    -- All Empty
    78, -- Craver
    137, -- Gorgers
    138,
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
    28, 29, -- Automations
    30, 31,
    51, -- Behemoth
    61, -- Cardian
    62, -- Cerberus

    -- Demon
    -- Devrgr

    115, 359, 360, -- Fomor
    140, 141, -- Hippogryph
    163, 164, -- Hydra

    -- Khamaira

    193, -- Pet Wyvern
    251, -- Uragnite
    252, -- Vampyr

    259, 260, 261, -- Wyrms
    262, 263, 264,
    391, 392, 393,
}

xi.pankration.getRandomFeralSkill = function(mob)
    -- TODO: This is made up and definitely not supposed to be THAT random.
    local equippable = {}
    for id, entry in pairs(xi.data.pankration.feralSkills) do
        -- Exclude native skills (0 FP) - they are attributed at reflector creation
        -- Exclude uncaptured/undocumented skills (99 FP)
        if entry.fp > 0 and entry.fp < 99 then
            equippable[id] = entry
        end
    end

    return utils.randomEntryIdx(equippable)
end
