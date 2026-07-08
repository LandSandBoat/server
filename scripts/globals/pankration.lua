-----------------------------------
-- Pankration System + Helpers
-----------------------------------
require('scripts/globals/magic')
-----------------------------------
xi = xi or {}
xi.pankration = xi.pankration or {}

-- https://www.bg-wiki.com/ffxi/Category:Pankration#Prohibited_Monsters
-- Uses xi.mobFamily IDs (checked against mob:getFamily())
-- This table looks unused but update with new families anyway.
xi.pankration.prohibitedFamilies =
set{
    -- All Beastmen
    xi.mobFamily.ANTICA,
    xi.mobFamily.BUGBEAR,
    xi.mobFamily.GIGAS,
    xi.mobFamily.GOBLIN,
    xi.mobFamily.LAMIAE,
    xi.mobFamily.MAMOOL_JA,
    xi.mobFamily.ORC,
    xi.mobFamily.ORCISH_WARMACHINE,
    xi.mobFamily.POROGGO,
    xi.mobFamily.QIQIRN,
    xi.mobFamily.QUADAV,
    xi.mobFamily.SAHAGIN,
    xi.mobFamily.TONBERRY,
    xi.mobFamily.TROLL,
    xi.mobFamily.YAGUDO,

    -- All Empty
    xi.mobFamily.CRAVER,
    xi.mobFamily.GORGER,
    xi.mobFamily.RECEPTACLE,
    xi.mobFamily.SEETHER,
    xi.mobFamily.THINKER,
    xi.mobFamily.WANDERER,
    xi.mobFamily.WEEPER,

    -- All Luminians
    xi.mobFamily.AERN,
    xi.mobFamily.EUVHI,
    xi.mobFamily.HPEMDE,
    xi.mobFamily.PHUABO,
    xi.mobFamily.XZOMIT,
    xi.mobFamily.YOVRA,

    -- All Luminions
    xi.mobFamily.GHRAH,
    xi.mobFamily.ZDEI,

    -- Avatar
    xi.mobFamily.AVATAR,

    -- Biotechnological Weapons
    xi.mobFamily.OMEGA,
    xi.mobFamily.ULTIMA,

    xi.mobFamily.ADAMANTOISE,
    xi.mobFamily.AUTOMATON,
    xi.mobFamily.BEHEMOTH,
    xi.mobFamily.CARDIAN,
    xi.mobFamily.CERBERUS,

    xi.mobFamily.DEMON,
    xi.mobFamily.DVERGR,

    xi.mobFamily.FOMOR,
    xi.mobFamily.HIPPOGRYPH,
    xi.mobFamily.HYDRA,

    -- xi.mobFamily.KHIMAIRA,

    xi.mobFamily.WYVERN_PET,
    xi.mobFamily.URAGNITE,
    xi.mobFamily.VAMPYR,

    xi.mobFamily.WYRM,
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
