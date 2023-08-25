---------------------------------------------------------------------------------------------------
-- func: gettraits
-- desc: prints list of all traits
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 3,
    parameters = ""
}

-- function onTrigger(player, extendedMode)
function onTrigger(player)
    local traitNames = {}

    traitNames =
    {
        [1  ] = "[Accuracy Bonus]",
        [2  ] = "[Evasion Bonus]",
        [3  ] = "[Attack Bonus]",
        [4  ] = "[Defense Bonus]",
        [5  ] = "[Magic Attack Bonus]",
        [6  ] = "[Magic Defense Bonus]",
        [7  ] = "[Max HP Boost]",
        [8  ] = "[Max MP Boost]",
        [9  ] = "[Auto Regen]",
        [10 ] = "[Auto Refresh]",
        [11 ] = "[Rapid Shot]",
        [12 ] = "[Fast Cast]",
        [13 ] = "[Conserve MP]",
        [14 ] = "[Store TP]",
        [15 ] = "[Double Attack]",
        [16 ] = "[Triple Attack]",
        [17 ] = "[Counter]",
        [18 ] = "[Dual Wield]",
        [19 ] = "[Treasure Hunter]",
        [20 ] = "[Gilfinder]",
        [21 ] = "[Alertness]",
        [22 ] = "[Stealth]",
        [23 ] = "[Martial Arts]",
        [24 ] = "[Clear Mind]",
        [25 ] = "[Shield Mastery]",
        [32 ] = "[Beast Killer]",
        [33 ] = "[Plantoid Killer]",
        [34 ] = "[Vermin Killer]",
        [35 ] = "[Lizard Killer]",
        [36 ] = "[Bird Killer]",
        [37 ] = "[Amorph Killer]",
        [38 ] = "[Aquan Killer]",
        [39 ] = "[Undead Killer]",
        [41 ] = "[Arcana Killer]",
        [42 ] = "[Demon Killer]",
        [43 ] = "[Dragon Killer]",
        [48 ] = "[Resist Sleep]",
        [49 ] = "[Resist Poison]",
        [50 ] = "[Resist Paralyze]",
        [51 ] = "[Resist Blind]",
        [52 ] = "[Resist Silence]",
        [53 ] = "[Resist Petrify]",
        [54 ] = "[Resist Virus]",
        [55 ] = "[Resist Curse]",
        [56 ] = "[Resist Stun]",
        [57 ] = "[Resist Bind]",
        [58 ] = "[Resist Gravity]",
        [59 ] = "[Resist Slow]",
        [60 ] = "[Resist Charm]",
        [63 ] = "[Resist Amnesia]",
        [64 ] = "[Treasure Hunter II]",
        [65 ] = "[Treasure Hunter III]",
        [66 ] = "[Kick Attacks]",
        [67 ] = "[Subtle Blow]",
        [68 ] = "[Assassin]",
        [69 ] = "[Divine Veil]",
        [70 ] = "[Zanshin]",
        [71 ] = "[Savagery]",
        [72 ] = "[Aggressive Aim]",
        [73 ] = "[Invigorate]",
        [74 ] = "[Penance]",
        [75 ] = "[Aura Steal]",
        [76 ] = "[Ambush]",
        [77 ] = "[Iron Will]",
        [78 ] = "[Guardian]",
        [79 ] = "[Muted Soul]",
        [80 ] = "[Desperate Blows]",
        [81 ] = "[Beast Affinity]",
        [82 ] = "[Beast Healer]",
        [83 ] = "[Snapshot]",
        [84 ] = "[Recycle]",
        [85 ] = "[Ikishoten]",
        [86 ] = "[Overwhelm]",
        [87 ] = "[Ninja Tool Expertise]",
        [88 ] = "[Empathy]",
        [89 ] = "[Strafe]",
        [90 ] = "[Enchainment]",
        [91 ] = "[Assimilation]",
        [92 ] = "[Winning Streak]",
        [93 ] = "[Loaded Deck]",
        [94 ] = "[Fine Tuning]",
        [95 ] = "[Optimization]",
        [96 ] = "[Closed Position]",
        [97 ] = "[Stormsurge]",
        [98 ] = "[Critical Attack Bonus]",
        [99 ] = "[Critical Defense Bonus]",
        [100] = "[Tactical Parry]",
        [101] = "[Tactical Guard]",
        [102] = "[Shield Defense Bonus]",
        [103] = "[Stout Servant]",
        [104] = "[True Shot]",
        [105] = "[Blood Boon]",
        [106] = "[Skillchain Bonus]",
        [107] = "[Fencer]",
        [108] = "[Conserve TP]",
        [109] = "[Occult Acumen]",
        [110] = "[Magic Burst Bonus]",
        [111] = "[Divine Benison]",
        [112] = "[Elemental Celerity]",
        [113] = "[Dead Aim]",
        [114] = "[Tranquil Heart]",
        [115] = "[Stalwart Soul]",
        [116] = "[Cardinal Chant]",
        [117] = "[Tenacity]",
        [118] = "[Inquartata]",
        [119] = "[C Recantation]",
        [120] = "[Primeval Zeal]",
        [121] = "[Inspiration]",
        [122] = "[Sleight of Sword]",
        [123] = "[Daken]",
        [124] = "[Superior]",
        [125] = "[Magic Accuracy Bonus]",
        [126] = "[Magic Evasion Bonus]",
        [127] = "[Smite]",
    }

    local target = player:getCursorTarget()
    if target == nil then
        player:PrintToPlayer("Target something first.")
        return
    end

    local targetType = target:getObjType()

    if targetType == xi.objType.NPC then
        player:PrintToPlayer("Target something other than an NPC..They don't have stats!")
        return
    end

    local traits = target:getTraits()
    if traits then
        player:PrintToPlayer(string.format("Showing Active Traits for: %s", target:getName()), xi.msg.channel.SYSTEM_3)
        player:PrintToPlayer("(id) [Trait Name] = Value", xi.msg.channel.SYSTEM_3)
        for _, t in pairs(traits) do
            player:PrintToPlayer(string.format("(%-3s): %s = %s", t["id"], traitNames[t["id"]], t["value"]), xi.msg.channel.SYSTEM_3)
        end
    else
        player:PrintToPlayer("No active traits found!")
    end
end
