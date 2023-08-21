-----------------------------------
-- Gear sets
-- Allows the use of gear sets with modifiers
-----------------------------------
xi = xi or {}
xi.gear_sets = xi.gear_sets or {}

-- Table Notes:
-- minEquipped and maxEquipped are optional parameters.  If not set, minEquipped will be set to
-- a value of 2, and maxEquipped will be set to 0 (not limited).  Mod parameters are the total value
-- of currently equipped pieces from minEquipped..N (Where N is maxEquipped or the maximum number)
-- of matches defined within the items table.

local gearSets =
{
    [1] = -- Usukane's set (5% Haste)
    {
        items =
        {
            xi.item.USUKANE_SOMEN,
            xi.item.USUKANE_HARAMAKI,
            xi.item.USUKANE_GOTE,
            xi.item.USUKANE_HIZAYOROI,
            xi.item.USUKANE_SUNE_ATE,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.HASTE_GEAR, 500 },
        },
    },

    [2] = -- Skadi's set (5% critrate is guess)
    {
        items =
        {
            xi.item.SKADIS_VISOR,
            xi.item.SKADIS_CUIRIE,
            xi.item.SKADIS_BAZUBANDS,
            xi.item.SKADIS_CHAUSSES,
            xi.item.SKADIS_JAMBEAUX,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.CRITHITRATE, 5 },
        },
    },

    [3] = -- Ares's set (5% DA)
    {
        items =
        {
            xi.item.ARES_MASK,
            xi.item.ARES_CUIRASS,
            xi.item.ARES_GAUNTLETS,
            xi.item.ARES_FLANCHARD,
            xi.item.ARES_SOLLERETS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.DOUBLE_ATTACK, 5 },
        },
    },

    [4] = -- Denali Jacket Set (Increases Accuracy +20)
    {
        items =
        {
            xi.item.DENALI_BONNET,
            xi.item.DENALI_JACKET,
            xi.item.DENALI_WRISTBANDS,
            xi.item.DENALI_KECKS,
            xi.item.DENALI_GAMASHES,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.ACC, 20 },
        },
    },

    [5] = -- Askar Korazin Set (Max HP Boost %10)
    {
        items =
        {
            xi.item.ASKAR_ZUCCHETTO,
            xi.item.ASKAR_KORAZIN,
            xi.item.ASKAR_MANOPOLAS,
            xi.item.ASKAR_DIRS,
            xi.item.ASKAR_GAMBIERAS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.HPP, 10 },
        },
    },

    [6] = -- Pahluwan Khazagand Set (Needs Verification)
    {
        items =
        {
            xi.item.PAHLUWAN_QALANSUWA,
            xi.item.PAHLUWAN_KHAZAGAND,
            xi.item.PAHLUWAN_DASTANAS,
            xi.item.PAHLUWAN_SERAWEELS,
            xi.item.PAHLUWAN_CRACKOWS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.SUBTLE_BLOW, 8 },
        },
    },

    [7] = -- Morrigan's Robe Set (+5 Magic. Atk Bonus)
    {
        items =
        {
            xi.item.MORRIGANS_CORONAL,
            xi.item.MORRIGANS_ROBE,
            xi.item.MORRIGANS_CUFFS,
            xi.item.MORRIGANS_SLOPS,
            xi.item.MORRIGANS_PIGACHES,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.MATT, 5 },
        },
    },

    [8] = -- Marduk's Jubbah Set (5% fastcast)
    {
        items =
        {
            xi.item.MARDUKS_TIARA,
            xi.item.MARDUKS_JUBBAH,
            xi.item.MARDUKS_DASTANAS,
            xi.item.MARDUKS_SHALWAR,
            xi.item.MARDUKS_CRACKOWS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.FASTCAST, 5 },
        },
    },

    [9] = -- Goliard Saio Set - Total Set Bonus +10% Magic Def. Bonus
    {
        items =
        {
            xi.item.GOLIARD_CHAPEAU,
            xi.item.GOLIARD_SAIO,
            xi.item.GOLIARD_CUFFS,
            xi.item.GOLIARD_TREWS,
            xi.item.GOLIARD_CLOGS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.MDEF, 10 },
        },
    },

    [10] = -- Yigit Gomlek Set (1mp per tick) Adds "Refresh" effect
    {
        items =
        {
            xi.item.YIGIT_TURBAN,
            xi.item.YIGIT_GOMLEK,
            xi.item.YIGIT_GAGES,
            xi.item.YIGIT_SERAWEELS,
            xi.item.YIGIT_CRACKOWS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.REFRESH, 1 },
        },
    },

    [11] = -- Perle Hauberk Set (Haste +5%)
    {
        items =
        {
            xi.item.PERLE_SALADE,
            xi.item.PERLE_HAUBERK,
            xi.item.PERLE_MOUFLES,
            xi.item.PERLE_BRAYETTES,
            xi.item.PERLE_SOLLERETS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.HASTE_GEAR, 500 },
        },
    },

    [12] = -- Aurore Doublet Set (Store TP +8)
    {
        items =
        {
            xi.item.AURORE_BERET,
            xi.item.AURORE_DOUBLET,
            xi.item.AURORE_GLOVES,
            xi.item.AURORE_BRAIS,
            xi.item.AURORE_GAITERS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.STORETP, 8 }
        },
    },

    [13] = -- Teal Set: Fast Cast +4-10%
    {
        items =
        {
            xi.item.TEAL_CHAPEAU,
            xi.item.TEAL_SAIO,
            xi.item.TEAL_CUFFS,
            xi.item.TEAL_SLOPS,
            xi.item.TEAL_PIGACHES,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.FASTCAST, 4, 6, 8, 10 },
        },
    },

    [14] = -- Calma Armor Set haste%6
    {
        items =
        {
            xi.item.CALMA_ARMET,
            xi.item.CALMA_BREASTPLATE,
            xi.item.CALMA_GAUNTLETS,
            xi.item.CALMA_HOSE,
            xi.item.CALMA_LEGGINGS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.HASTE_GEAR, 600 },
        },
    },

    [15] = -- Magavan Armor Set  magic accuracy +5
    {
        items =
        {
            xi.item.MAGAVAN_BERET,
            xi.item.MAGAVAN_FROCK,
            xi.item.MAGAVAN_MITTS,
            xi.item.MAGAVAN_SLOPS,
            xi.item.MAGAVAN_CLOGS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.MACC, 5 },
        },
    },

    [16] = -- Mustela Harness Set  crit rate 5%
    {
        items =
        {
            xi.item.MUSTELA_MASK,
            xi.item.MUSTELA_HARNESS,
            xi.item.MUSTELA_GLOVES,
            xi.item.MUSTELA_BRAIS,
            xi.item.MUSTELA_BOOTS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.CRITHITRATE, 5 },
        },
    },

    [17] = -- Bowman's set: Ranged atk +15
    {
        items =
        {
            xi.item.BOWMANS_MASK,
            xi.item.BOWMANS_LEDELSENS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.RATT, 15 },
        },
    },

    [18] = -- Fourth Division Brune Set
    {
        items =
        {
            xi.item.FOURTH_DIVISION_HAUBE,
            xi.item.FOURTH_DIVISION_BRUNNE,
            xi.item.FOURTH_DIVISION_HENTZES,
            xi.item.FOURTH_DIVISION_SCHOSS,
            xi.item.FOURTH_DIVISION_SCHUHS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ATT, 1, 5, 10, 15 },
        },
    },

    [19] = -- Cobra Unit Harness Set (Needs Verification)
    {
        items =
        {
            xi.item.COBRA_UNIT_CAP,
            xi.item.COBRA_UNIT_HARNESS,
            xi.item.COBRA_UNIT_MITTENS,
            xi.item.COBRA_UNIT_SUBLIGAR,
            xi.item.COBRA_UNIT_LEGGINGS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.COUNTER, 1, 2, 3, 4 },
        },
    },

    [20] = -- Cobra Unit Robe Set (Needs Verification)
    {
        items =
        {
            xi.item.COBRA_UNIT_CLOCHE,
            xi.item.COBRA_UNIT_ROBE,
            xi.item.COBRA_UNIT_GLOVES,
            xi.item.COBRA_UNIT_TREWS,
            xi.item.COBRA_UNIT_CRACKOWS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.MACC, 1, 2, 3, 4 },
        },
    },

    [21] = -- Iron Ram Chainmail Set.
    {
        items =
        {
            xi.item.IRON_RAM_HELM,
            xi.item.IRON_RAM_CHAINMAIL,
            xi.item.IRON_RAM_MUFFLERS,
            xi.item.IRON_RAM_BREECHES,
            xi.item.IRON_RAM_SOLLERETS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ACC, 1, 2, 3, 4 },
            { xi.mod.ATT, 1, 2, 3, 4 },
        },
    },

    [22] = -- Fourth Division Cuirass Set
    {
        items =
        {
            xi.item.FOURTH_DIVISION_ARMET,
            xi.item.FOURTH_DIVISION_CUIRASS,
            xi.item.FOURTH_DIVISION_GAUNTLETS,
            xi.item.FOURTH_DIVISION_CUISSES,
            xi.item.FOURTH_DIVISION_SABATONS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.HP, 10, 20, 30, 40 },
        },
    },

    [23] = -- Cobra Unit Coat Set
    {
        items =
        {
            xi.item.COBRA_UNIT_HAT,
            xi.item.COBRA_UNIT_COAT,
            xi.item.COBRA_UNIT_CUFFS,
            xi.item.COBRA_UNIT_SLOPS,
            xi.item.COBRA_UNIT_PIGACHES,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.MP, 10, 20, 30, 40 },
        },
    },

    [24] = -- Amir Korazin Set
    {
        items =
        {
            xi.item.AMIR_PUGGAREE,
            xi.item.AMIR_KORAZIN,
            xi.item.AMIR_KOLLUKS,
            xi.item.AMIR_DIRS,
            xi.item.AMIR_BOOTS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.UDMGBREATH, -800 },
            { xi.mod.UDMGMAGIC,  -800 },
        },
    },

    [25] = -- Hachiryu Haramaki Set - Store TP
    {
        items =
        {
            xi.item.HACHIRYU_HARAMAKI,
            xi.item.HACHIRYU_KOTE,
            xi.item.HACHIRYU_HAIDATE,
            xi.item.HACHIRYU_SUNE_ATE,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.STORETP, 5, 10, 20 },
        },
    },

    [26] = -- Ravager's Armor +2 Set - Double attack double damage chance
    {
        items =
        {
            xi.item.RAVAGERS_MASK_P2,
            xi.item.RAVAGERS_LORICA_P2,
            xi.item.RAVAGERS_MUFFLERS_P2,
            xi.item.RAVAGERS_CUISSES_P2,
            xi.item.RAVAGERS_CALLIGAE_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DA_DOUBLE_DMG_RATE, 2, 3, 4, 5 },
        },
    },

    [27] = -- Fazheluo Mail Set. Set Bonus: "Double Attack"+5%. Active with any 2 pieces.
    {
        items =
        {
            xi.item.FAZHELUO_HELM,
            xi.item.FAZHELUO_HELM_P1,
            xi.item.FAZHELUO_MAIL,
            xi.item.FAZHELUO_RADIANT_MAIL,
            xi.item.FAZHELUO_MAIL_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DOUBLE_ATTACK, 5 },
        },
    },

    [28] = -- Cuauhtli Harness Set. Set Bonus: Haste+8%. Active with any 2 pieces.
    {
        items =
        {
            xi.item.CUAUHTLI_HEADPIECE,
            xi.item.CUAUHTLI_HEADPIECE_P1,
            xi.item.CUAUHTLI_HARNESS,
            xi.item.MEXTLI_HARNESS,
            xi.item.CUAUHTLI_HARNESS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.HASTE_GEAR, 800 },
        },
    },

    [29] = -- Hyskos Robe Set. Set Bonus: Magic Accuracy+5. Active with any 2 pieces.
    {
        items =
        {
            xi.item.HYKSOS_KHAT,
            xi.item.HYKSOS_KHAT_P1,
            xi.item.HYKSOS_ROBE,
            xi.item.ANHUR_ROBE,
            xi.item.HYKSOS_ROBE_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.MACC, 5 },
        },
    },

    [30] = -- Ogier's Armor Set. Set Bonus: Adds "Refresh" xi.effect. Provides 1 mp/tick for 2-3 pieces worn, 2 mp/tick for 4-5 pieces worn.
    {
        items =
        {
            xi.item.OGIERS_HELM,
            xi.item.OGIERS_SURCOAT,
            xi.item.OGIERS_GAUNTLETS,
            xi.item.OGIERS_BREECHES,
            xi.item.OGIERS_LEGGINGS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.REFRESH, 1, 1, 2, 2 },
        },
    },

    [31] = -- Athos's Armor Set. Set Bonus: Increases rate of critical hits. Gives +3% for the first 2 pieces and +1% for every additional piece.
    {
        items =
        {
            xi.item.ATHOSS_CHAPEAU,
            xi.item.ATHOSS_TABARD,
            xi.item.ATHOSS_GLOVES,
            xi.item.ATHOSS_TIGHTS,
            xi.item.ATHOSS_BOOTS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.CRITHITRATE, 3, 4, 5, 6 },
        },
    },

    [32] = -- Rubeus Armor Set. Set Bonus: Enhances "Fast Cast" effect. 2 or 3 pieces equipped: Fast Cast +4, 4 or 5 pieces equipped: Fast Cast +10
    {
        items =
        {
            xi.item.RUBEUS_BANDEAU,
            xi.item.RUBEUS_JACKET,
            xi.item.RUBEUS_GLOVES,
            xi.item.RUBEUS_SPATS,
            xi.item.RUBEUS_BOOTS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.FASTCAST, 4, 4, 10, 10 },
        },
    },

    [33] = -- Navarch's Attire +2 Set. Set Bonus: Augments "Quick Draw". Quick Draw will occasionally deal triple damage.
    {
        items =
        {
            xi.item.NAVARCHS_TRICORNE_P2,
            xi.item.NAVARCHS_FRAC_P2,
            xi.item.NAVARCHS_GANTS_P2,
            xi.item.NAVARCHS_CULOTTES_P2,
            xi.item.NAVARCHS_BOTTES_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.QUICK_DRAW_TRIPLE_DAMAGE, 2, 3, 4, 5 },
        },
    },

    [34] = -- Charis Attire +2 Set. Set Bonus: Augments "Samba". Occasionally doubles damage with Samba up. Adds approximately 1-2% per piece past the first.
    {
        items =
        {
            xi.item.CHARIS_TIARA_P2,
            xi.item.CHARIS_CASAQUE_P2,
            xi.item.CHARIS_BANGLES_P2,
            xi.item.CHARIS_TIGHTS_P2,
            xi.item.CHARIS_TOE_SHOES_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.SAMBA_DOUBLE_DAMAGE, 2, 3, 4, 5 },
        },
    },

    [35] = -- Iga Garb +2 Set. Set Bonus: Augments "Dual Wield". Attacks made while dual wielding occasionally add an extra attack
    {
        items =
        {
            xi.item.IGA_ZUKIN_P2,
            xi.item.IGA_NINGI_P2,
            xi.item.IGA_TEKKO_P2,
            xi.item.IGA_HAKAMA_P2,
            xi.item.IGA_KYAHAN_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.EXTRA_DUAL_WIELD_ATTACK, 2, 3, 4, 5 },
        }
    },

    [36] = -- Sylvan Attire +2 Set. Set Bonus: Augments "Rapid Shot". Rapid Shots occasionally deal double damage.
    {
        items =
        {
            xi.item.SYLVAN_GAPETTE_P2,
            xi.item.SYLVAN_CABAN_P2,
            xi.item.SYLVAN_GLOVELETTES_P2,
            xi.item.SYLVAN_BRAGUES_P2,
            xi.item.SYLVAN_BOTTILLONS_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.RAPID_SHOT_DOUBLE_DAMAGE, 2, 3, 4, 5 },
        },
    },

    [37] = -- Creed Armor +2 Set. Set Bonus: Occasionally absorbs damage taken. Set proc believed to be somewhere around 5%, more testing needed. Verification Needed Absorb rate likely varies with # of set pieces.
    {
        items =
        {
            xi.item.CREED_ARMET_P2,
            xi.item.CREED_CUIRASS_P2,
            xi.item.CREED_GAUNTLETS_P2,
            xi.item.CREED_CUISSES_P2,
            xi.item.CREED_SABATONS_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ABSORB_DMG_CHANCE, 2, 3, 4, 5 },
        },
    },

    [38] = -- Unkai Domaru +2 Set. Set Bonus: Augments "Zanshin". Zanshin attacks will occasionally deal double damage.
    {
        items =
        {
            xi.item.UNKAI_KABUTO_P2,
            xi.item.UNKAI_DOMARU_P2,
            xi.item.UNKAI_KOTE_P2,
            xi.item.UNKAI_HAIDATE_P2,
            xi.item.UNKAI_SUNE_ATE_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ZANSHIN_DOUBLE_DAMAGE, 2, 3, 4, 5 },
        },
    },

    [39] = -- Tantra Attire +2 Set. Set Bonus: Augments "Kick Attacks". Occasionally allows a second Kick Attack during an attack round without the use of Footwork.
    {
        items =
        {
            xi.item.TANTRA_CROWN_P2,
            xi.item.TANTRA_CYCLAS_P2,
            xi.item.TANTRA_GLOVES_P2,
            xi.item.TANTRA_HOSE_P2,
            xi.item.TANTRA_GAITERS_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.EXTRA_KICK_ATTACK, 2, 3, 4, 5 },
        },
    },

    [40] = -- Raider's Attire +2 Set. Set Bonus: Augments "Triple Attack". Occasionally causes the second and third hits of a Triple Attack to deal triple damage.Verification Needed Requires a minimum of two pieces.
    {
        items =
        {
            xi.item.RAIDERS_BONNET_P2,
            xi.item.RAIDERS_VEST_P2,
            xi.item.RAIDERS_ARMLETS_P2,
            xi.item.RAIDERS_CULOTTES_P2,
            xi.item.RAIDERS_POULAINES_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.TA_TRIPLE_DMG_RATE, 2, 3, 4, 5 },
        },
    },

    [41] = -- Orison Attire +2 Set. Set Bonus: Augments elemental resistance spells. Bar Elemental spells will occasionally nullify damage of the same element.
    {
        items =
        {
            xi.item.ORISON_CAP_P2,
            xi.item.ORISON_BLIAUD_P2,
            xi.item.ORISON_MITTS_P2,
            xi.item.ORISON_PANTALOONS_P2,
            xi.item.ORISON_DUCKBILLS_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.BAR_ELEMENT_NULL_CHANCE, 2, 3, 4, 5 },
        },
    },

    [42] = -- Savant's Attire +2 Set. Set Bonus: Augments Grimoire. Spells that match your current Arts will occasionally cast instantly, without recast.
    {
        items =
        {
            xi.item.SAVANTS_BONNET_P2,
            xi.item.SAVANTS_GOWN_P2,
            xi.item.SAVANTS_BRACERS_P2,
            xi.item.SAVANTS_PANTS_P2,
            xi.item.SAVANTS_LOAFERS_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.GRIMOIRE_INSTANT_CAST, 2, 3, 4, 5 },
        },
    },

    [43] = -- Paramount Earring Sets. Set Bonus: HP+30, VIT+6, Accuracy+6, Ranged Accuracy+6. Set Bonus is active with any 2 items(Earring+Weapon or Weapon+Weapon)
    {
        items =
        {
            xi.item.PARAMOUNT_EARRING,
            xi.item.SINFENDER,
            xi.item.FLEETWING,
            xi.item.KEBBIE,
            xi.item.USESHI,
            xi.item.FARSEER,
            xi.item.AMANOKAKOYUMI,
            xi.item.OSORAKU,
            xi.item.BALISARDE,
        },
        minEquipped = 2,
        maxEquipped = 2,
        mods =
        {
            { xi.mod.HP,  30 },
            { xi.mod.VIT,  6 },
            { xi.mod.ACC,  6 },
            { xi.mod.RACC, 6 },
        },
    },

    [44] = -- Supremacy Earring Sets. Set Bonus: STR+6, Attack+4, Ranged Attack+4, "Magic Atk. Bonus"+2. Active with any 2 items(Earring+Weapon)
    {
        items =
        {
            xi.item.SUPREMACY_EARRING,
            xi.item.ACANTHA_SHAVERS,
            xi.item.CATALYST,
            xi.item.MERVEILLEUSE,
            xi.item.MURDERER,
            xi.item.SKYSTRIDER,
            xi.item.SPARTH,
            xi.item.VENDETTA,
        },
        minEquipped = 2,
        maxEquipped = 2,
        mods =
        {
            { xi.mod.STR,  6 },
            { xi.mod.ATT,  4 },
            { xi.mod.RATT, 4 },
            { xi.mod.MATT, 2 },
        },
    },

    [45] = -- Brilliant Earring Set. Set Bonus: Evasion, HP Recovered while healing, Reduces Emnity. Active with any 2 items(Earring+Weapon)
    {
        items =
        {
            xi.item.BRILLIANT_EARRING,
            xi.item.MUKADEMARU,
            xi.item.ALASTOR,
            xi.item.GRANDEUR,
            xi.item.CLEARPATH,
            xi.item.FAUCHEUSE,
            xi.item.SILKTONE,
            xi.item.BASILISK,
            xi.item.YAGENTOSHIRO,
        },
        minEquipped = 2,
        maxEquipped = 2,
        mods =
        {
            { xi.mod.EVA,    10 },
            { xi.mod.HPHEAL, 10 },
            { xi.mod.ENMITY, -5 },
        }
    },

    [46] = -- Twilight Mail Set. Set Bonus: Auto-Reraise
    {
        items =
        {
            xi.item.TWILIGHT_HELM,
            xi.item.TWILIGHT_MAIL,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.RERAISE_III, 1 },
        },
    },

    [47] = -- Begin Jailer weapons: Set is weapon + Virtue stone, bonus 50% extra melee swing.
    {
        items =
        {
            xi.item.VIRTUE_STONE,
            xi.item.HOPE_STAFF,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50 },
        },
    },

    [48] =
    {
        items =
        {
            xi.item.VIRTUE_STONE,
            xi.item.JUSTICE_SWORD,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50 },
        },
    },

    [49] =
    {
        items =
        {
            xi.item.VIRTUE_STONE,
            xi.item.TEMPERANCE_AXE,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50 },
        },
    },

    [50] =
    {
        items =
        {
            xi.item.VIRTUE_STONE,
            xi.item.LOVE_HALBERD,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50 },
        },
    },

    [51] =
    {
        items =
        {
            xi.item.VIRTUE_STONE,
            xi.item.FORTITUDE_AXE,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50 },
        },
    },

    [52] =
    {
        items =
        {
            xi.item.VIRTUE_STONE,
            xi.item.FAITH_BAGHNAKHS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50 },
        },
    },

    [53] = -- End Jailer weapons
    {
        items =
        {
            xi.item.VIRTUE_STONE,
            xi.item.PRUDENCE_ROD,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50 },
        },
    },

    [54] = -- Bladeborn/Steelflash Earrings
    {
        items =
        {
            xi.item.STEELFLASH_EARRING,
            xi.item.BLADEBORN_EARRING,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DOUBLE_ATTACK, 7 },
        },
    },

    [55] = -- Dudgeon/Heartseeker Earrings
    {
        items =
        {
            xi.item.DUDGEON_EARRING,
            xi.item.HEARTSEEKER_EARRING,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DUAL_WIELD, 7 },
        },
    },

    [56] = -- Psystorm/Lifestorm Earrings
    {
        items =
        {
            xi.item.LIFESTORM_EARRING,
            xi.item.PSYSTORM_EARRING,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.MACC, 12 },
        },
    },

    [57] = -- Samurai 109/119 af3
    {
        items =
        {
            xi.item.KASUGA_DOMARU,
            xi.item.KASUGA_DOMARU_P1,
            xi.item.KASUGA_SUNE_ATE_P1,
            xi.item.KASUGA_HAIDATE,
            xi.item.KASUGA_HAIDATE_P1,
            xi.item.KASUGA_KABUTO,
            xi.item.KASUGA_KABUTO_P1,
            xi.item.KASUGA_KOTE,
            xi.item.KASUGA_KOTE_P1,
            xi.item.KASUGA_SUNE_ATE,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ZANSHIN_DOUBLE_DAMAGE, 2, 3, 4, 5 },
        },
    },

    [58] = -- MNK 109/119 af3
    {
        items =
        {
            xi.item.BHIKKU_GAITERS_P1,
            xi.item.BHIKKU_GAITERS,
            xi.item.BHIKKU_HOSE_P1,
            xi.item.BHIKKU_HOSE,
            xi.item.BHIKKU_GLOVES_P1,
            xi.item.BHIKKU_GLOVES,
            xi.item.BHIKKU_CYCLAS_P1,
            xi.item.BHIKKU_CYCLAS,
            xi.item.BHIKKU_CROWN_P1,
            xi.item.BHIKKU_CROWN,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.EXTRA_KICK_ATTACK, 2, 3, 4, 5 },
        },
    },

    [59] = -- 109/119 WAR AF3
    {
        items =
        {
            xi.item.BOII_MASK,
            xi.item.BOII_MASK_P1,
            xi.item.BOII_CALLIGAE,
            xi.item.BOII_CALLIGAE_P1,
            xi.item.BOII_CUISSES_P1,
            xi.item.BOII_CUISSES,
            xi.item.BOII_MUFFLERS_P1,
            xi.item.BOII_MUFFLERS,
            xi.item.BOII_LORICA_P1,
            xi.item.BOII_LORICA,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DA_DOUBLE_DMG_RATE, 2, 3, 4, 5 },
        },
    },

    [60] = -- 109/119 THF AF3
    {
        items =
        {
            xi.item.SKULKERS_BONNET,
            xi.item.SKULKERS_BONNET_P1,
            xi.item.SKULKERS_POULAINES,
            xi.item.SKULKERS_POULAINES_P1,
            xi.item.SKULKERS_CULOTTES,
            xi.item.SKULKERS_CULOTTES_P1,
            xi.item.SKULKERS_ARMLETS_P1,
            xi.item.SKULKERS_ARMLETS,
            xi.item.SKULKERS_VEST,
            xi.item.SKULKERS_VEST_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.TA_TRIPLE_DMG_RATE, 2, 3, 4, 5 },
        },
    },

    [61] = -- 109/119 RNG AF3
    {
        items =
        {
            xi.item.AMINI_CABAN,
            xi.item.AMINI_CABAN_P1,
            xi.item.AMINI_GAPETTE_P1,
            xi.item.AMINI_GAPETTE,
            xi.item.AMINI_BOTTILLONS,
            xi.item.AMINI_BOTTILLONS_P1,
            xi.item.AMINI_BRAGUE,
            xi.item.AMINI_BRAGUE_P1,
            xi.item.AMINI_GLOVELETTES,
            xi.item.AMINI_GLOVELETTES_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.RAPID_SHOT_DOUBLE_DAMAGE, 2, 3, 4, 5 },
        },
    },

    [62] = -- 109/119 PLD AF3
    {
        items =
        {
            xi.item.CHEVALIERS_CUIRASS,
            xi.item.CHEVALIERS_CUIRASS_P1,
            xi.item.CHEVALIERS_ARMET,
            xi.item.CHEVALIERS_ARMET_P1,
            xi.item.CHEVALIERS_SABATONS_P1,
            xi.item.CHEVALIERS_SABATONS,
            xi.item.CHEVALIERS_GAUNTLETS,
            xi.item.CHEVALIERS_GAUNTLETS_P1,
            xi.item.CHEVALIERS_CUISSES,
            xi.item.CHEVALIERS_CUISSES_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ABSORB_DMG_CHANCE, 2, 3, 4, 5 },
        },
    },

    [63] = -- 109/119 NIN AF3
    {
        items =
        {
            xi.item.HATTORI_NINGI,
            xi.item.HATTORI_NINGI_P1,
            xi.item.HATTORI_ZUKIN,
            xi.item.HATTORI_ZUKIN_P1,
            xi.item.HATTORI_TEKKO,
            xi.item.HATTORI_TEKKO_P1,
            xi.item.HATTORI_HAKAMA,
            xi.item.HATTORI_HAKAMA_P1,
            xi.item.HATTORI_KYAHAN,
            xi.item.HATTORI_KYAHAN_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.EXTRA_DUAL_WIELD_ATTACK, 2, 3, 4, 5 },
        },
    },

    [64] = -- 109/119 COR AF3
    {
        items =
        {
            xi.item.CHASSEURS_BOTTES,
            xi.item.CHASSEURS_BOTTES_P1,
            xi.item.CHASSEURS_TRICORNE,
            xi.item.CHASSEURS_TRICORNE_P1,
            xi.item.CHASSEURS_FRAC,
            xi.item.CHASSEURS_FRAC_P1,
            xi.item.CHASSEURS_GANTS,
            xi.item.CHASSEURS_GANTS_P1,
            xi.item.CHASSEURS_CULOTTES,
            xi.item.CHASSEURS_CULOTTES_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.QUICK_DRAW_TRIPLE_DAMAGE, 2, 3, 4, 5 },
        },
    },

    [65] = -- 109/119 SCH AF3
    {
        items =
        {
            xi.item.ARBATEL_PANTS,
            xi.item.ARBATEL_PANTS_P1,
            xi.item.ARBATEL_LOAFERS,
            xi.item.ARBATEL_LOAFERS_P1,
            xi.item.ARBATEL_BONNET,
            xi.item.ARBATEL_BONNET_P1,
            xi.item.ARBATEL_GOWN,
            xi.item.ARBATEL_GOWN_P1,
            xi.item.ARBATEL_BRACERS,
            xi.item.ARBATEL_BRACERS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.GRIMOIRE_INSTANT_CAST, 2, 3, 4, 5 },
        },
    },

    [66] = -- 109/119 WHM AF3
    {
        items =
        {
            xi.item.EBERS_PANTALOONS,
            xi.item.EBERS_PANTALOONS_P1,
            xi.item.EBERS_DUCKBILLS,
            xi.item.EBERS_DUCKBILLS_P1,
            xi.item.EBERS_CAP,
            xi.item.EBERS_CAP_P1,
            xi.item.EBERS_BLIAUD,
            xi.item.EBERS_BLIAUD_P1,
            xi.item.EBERS_MITTS,
            xi.item.EBERS_MITTS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.BAR_ELEMENT_NULL_CHANCE, 2, 3, 4, 5 },
        },
    },

    [67] = -- Heka/Nefer body + NQ or HQ Khat = 2 tick refresh
    {
        items =
        {
            xi.item.HEKAS_KALASIRIS,
            xi.item.NEFER_KHAT,
            xi.item.NEFER_KHAT_P1,
            xi.item.NEFER_KALASIRIS,
            xi.item.NEFER_KALASIRIS_P1,
        },
        minEquipped = 2,
        maxEquipped = 2,
        mods =
        {
            { xi.mod.REFRESH, 3 },
        },
    },

    [68] = -- Dasra's/Nasatya's Ring set gives HP/MP +50
    {
        items =
        {
            xi.item.NASATYAS_RING,
            xi.item.DASRAS_RING,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.HP, 50 },
            { xi.mod.MP, 50 },
        },
    },

    [69] = -- Helenus's/Cassandra's earring set: Mag atk bonus+5 and Mag acc +5
    {
        items =
        {
            xi.item.HELENUSS_EARRING,
            xi.item.CASSANDRAS_EARRING,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.MATT, 5 },
            { xi.mod.MACC, 5 },
        },
    },

    [70] = -- Lava's/Kusha's earring set: Atk+6/Acc+12
    {
        items =
        {
            xi.item.LAVAS_RING,
            xi.item.KUSHAS_RING,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ATT,  6 },
            { xi.mod.ACC, 12 },
            { xi.mod.DEF,  6 },
        },
    },

    [71] = -- Iron Ram Haubert Set
    {
        items =
        {
            xi.item.IRON_RAM_SALLET,
            xi.item.IRON_RAM_HAUBERK,
            xi.item.IRON_RAM_DASTANAS,
            xi.item.IRON_RAM_HOSE,
            xi.item.IRON_RAM_GREAVES,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.FIRE_MEVA,    5, 10, 15, 30 },
            { xi.mod.ICE_MEVA,     5, 10, 15, 30 },
            { xi.mod.WIND_MEVA,    5, 10, 15, 30 },
            { xi.mod.EARTH_MEVA,   5, 10, 15, 30 },
            { xi.mod.THUNDER_MEVA, 5, 10, 15, 30 },
            { xi.mod.WATER_MEVA,   5, 10, 15, 30 },
            { xi.mod.LIGHT_MEVA,   5, 10, 15, 30 },
            { xi.mod.DARK_MEVA,    5, 10, 15, 30 },
        },
    },

    [72] = -- Altdorf's/Wilhelm's earring: AGI+8
    {
        items =
        {
            xi.item.ALTDORFS_EARRING,
            xi.item.WILHELMS_EARRING,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AGI, 8 },
        },
    },

    [73] = -- Gothic Gauntlets/Sabatons: Atk/RAtk +5
    {
        items =
        {
            xi.item.GOTHIC_GAUNTLETS,
            xi.item.GOTHIC_SABATONS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ATT,  5 },
            { xi.mod.RATT, 5 },
        },
    },

    [74] = -- Teal Set +1: Fast Cast +4-10%
    {
        items =
        {
            xi.item.TEAL_CHAPEAU_P1,
            xi.item.TEAL_SAIO_P1,
            xi.item.TEAL_CUFFS_P1,
            xi.item.TEAL_SLOPS_P1,
            xi.item.TEAL_PIGACHES_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.FASTCAST, 4, 6, 8, 10 },
        },
    },

    [75] = -- Aurore Set +1: Store TP +2-8
    {
        items =
        {
            xi.item.AURORE_BERET_P1,
            xi.item.AURORE_DOUBLET_P1,
            xi.item.AURORE_GLOVES_P1,
            xi.item.AURORE_BRAIS_P1,
            xi.item.AURORE_GAITERS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.STORETP, 2, 4, 6, 8 },
        },
    },

    [76] = -- Perle Set +1: Haste +2-5%
    {
        items =
        {
            xi.item.PERLE_SALADE_P1,
            xi.item.PERLE_HAUBERK_P1,
            xi.item.PERLE_MOUFLES_P1,
            xi.item.PERLE_BRAYETTES_P1,
            xi.item.PERLE_SOLLERETS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.HASTE_GEAR, 2, 3, 4, 5 },
        },
    },

    [77] = -- Morrigan's Attire Set +1: Magic Atk. Bonus +3-9%
    {
        items =
        {
            xi.item.MORRIGANS_CORONAL_P1,
            xi.item.MORRIGANS_ROBE_P1,
            xi.item.MORRIGANS_CUFFS_P1,
            xi.item.MORRIGANS_SLOPS_P1,
            xi.item.MORRIGANS_PIGACHES_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.MATT, 3, 5, 7, 9 },
        },
    },

    [78] = -- Marduk's Attire Set +1: Fast Cast +3-9%
    {
        items =
        {
            xi.item.MARDUKS_TIARA_P1,
            xi.item.MARDUKS_JUBBAH_P1,
            xi.item.MARDUKS_DASTANAS_P1,
            xi.item.MARDUKS_SHALWAR_P1,
            xi.item.MARDUKS_CRACKOWS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.FASTCAST, 3, 5, 7, 9 },
        },
    },

    [79] = -- Usukane Armor Set +1: Haste +3-9%
    {
        items =
        {
            xi.item.USUKANE_SOMEN_P1,
            xi.item.USUKANE_HARAMAKI_P1,
            xi.item.USUKANE_GOTE_P1,
            xi.item.USUKANE_HIZAYOROI_P1,
            xi.item.USUKANE_SUNE_ATE_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.HASTE_GEAR, 300, 500, 700, 900 },
        },
    },

    [80] = -- Skadi's Attire Set +1: Critical hit rate +3-9%
    {
        items =
        {
            xi.item.SKADIS_VISOR_P1,
            xi.item.SKADIS_CUIRIE_P1,
            xi.item.SKADIS_BAZUBANDS_P1,
            xi.item.SKADIS_CHAUSSES_P1,
            xi.item.SKADIS_JAMBEAUX_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.CRITHITRATE, 3, 5, 7, 9 },
        },
    },

    [81] = -- Ares' Armor Set +1: Double Attack +3-9%
    {
        items =
        {
            xi.item.ARES_MASK_P1,
            xi.item.ARES_CUIRASS_P1,
            xi.item.ARES_GAUNTLETS_P1,
            xi.item.ARES_FLANCHARD_P1,
            xi.item.ARES_SOLLERETS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DOUBLE_ATTACK, 3, 5, 7, 9 },
        },
    },

    [82] = -- Alcedo Cuisses and Gauntlets: Magic damage taken -5%
    {
        items =
        {
            xi.item.ALCEDO_GAUNTLETS,
            xi.item.ALCEDO_CUISSES,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DMGMAGIC, -500 },
        },
    },

    [83] = -- Sulevia's Armor Set +2: Subtle Blow +5-20
    {
        items =
        {
            xi.item.SULEVIAS_RING,
            xi.item.SULEVIAS_MASK_P2,
            xi.item.SULEVIAS_PLATEMAIL_P2,
            xi.item.SULEVIAS_GAUNTLETS_P2,
            xi.item.SULEVIAS_CUISSES_P2,
            xi.item.SULEVIAS_LEGGINGS_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.SUBTLE_BLOW, 5, 10, 15, 20 },
        },
    },

    [84] = -- Hizamaru Armor Set +2: Counter +4-16%
    {
        items =
        {
            xi.item.HIZAMARU_RING,
            xi.item.HIZAMARU_SOMEN_P2,
            xi.item.HIZAMARU_HARAMAKI_P2,
            xi.item.HIZAMARU_KOTE_P2,
            xi.item.HIZAMARU_HIZAYOROI_P2,
            xi.item.HIZAMARU_SUNE_ATE_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.COUNTER, 4, 8, 12, 16 },
        },
    },

    [85] = -- Inyanga Armor Set +2: Refresh +1-4
    {
        items =
        {
            xi.item.INYANGA_RING,
            xi.item.INYANGA_TIARA_P2,
            xi.item.INYANGA_JUBBAH_P2,
            xi.item.INYANGA_DASTANAS_P2,
            xi.item.INYANGA_SHALWAR_P2,
            xi.item.INYANGA_CRACKOWS_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.REFRESH, 1, 2, 3, 4 },
        },
    },

    [86] = -- Meghanada Armor Set +2: Regen +3-12
    {
        items =
        {
            xi.item.MEGHANADA_RING,
            xi.item.MEGHANADA_VISOR_P2,
            xi.item.MEGHANADA_CUIRIE_P2,
            xi.item.MEGHANADA_GLOVES_P2,
            xi.item.MEGHANADA_CHAUSSES_P2,
            xi.item.MEGHANADA_JAMBEAUX_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.REGEN, 3, 6, 9, 12 },
        },
    },

    [87] = -- Jhakri Armor Set +2: Fast Cast +1-4%
    {
        items =
        {
            xi.item.JHAKRI_RING,
            xi.item.JHAKRI_CORONAL_P2,
            xi.item.JHAKRI_ROBE_P2,
            xi.item.JHAKRI_CUFFS_P2,
            xi.item.JHAKRI_SLOPS_P2,
            xi.item.JHAKRI_PIGACHES_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.FAST_CAST, 1, 2, 3, 4 },
        },
    },

    [88] = -- Flamma Armor Set +2 STR/DEX/VIT +8-32
    {
        items =
        {
            xi.item.FLAMMA_RING,
            xi.item.FLAMMA_ZUCCHETTO_P2,
            xi.item.FLAMMA_KORAZIN_P2,
            xi.item.FLAMMA_MANOPOLAS_P2,
            xi.item.FLAMMA_DIRS_P2,
            xi.item.FLAMMA_GAMBIERAS_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.STR, 8, 16, 24, 32 },
            { xi.mod.DEX, 8, 16, 24, 32 },
            { xi.mod.VIT, 8, 16, 24, 32 },
        },
    },

    [89] = -- Tali'ah Armor Set +2 DEX/VIT/CHR +8-32
    {
        items =
        {
            xi.item.TALIAH_RING,
            xi.item.TALIAH_TURBAN_P2,
            xi.item.TALIAH_MANTEEL_P2,
            xi.item.TALIAH_GAGES_P2,
            xi.item.TALIAH_SERAWEELS_P2,
            xi.item.TALIAH_CRACKOWS_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.DEX, 8, 16, 24, 32 },
            { xi.mod.VIT, 8, 16, 24, 32 },
            { xi.mod.CHR, 8, 16, 24, 32 },
        }
    },

    [90] = -- Mummu Armor Set +2 DEX/AGI/CHR +8-32
    {
        items =
        {
            xi.item.MUMMU_RING,
            xi.item.MUMMU_BONNET_P2,
            xi.item.MUMMU_JACKET_P2,
            xi.item.MUMMU_WRISTS_P2,
            xi.item.MUMMU_KECKS_P2,
            xi.item.MUMMU_GAMASHES_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.DEX, 8, 16, 24, 32 },
            { xi.mod.AGI, 8, 16, 24, 32 },
            { xi.mod.CHR, 8, 16, 24, 32 },
        },
    },

    [91] = -- Ayanmo Armor Set +2 STR/VIT/MND +8-32
    {
        items =
        {
            xi.item.AYANMO_RING,
            xi.item.AYANMO_ZUCCHETTO_P2,
            xi.item.AYANMO_CORAZZA_P2,
            xi.item.AYANMO_MANOPOLAS_P2,
            xi.item.AYANMO_COSCIALES_P2,
            xi.item.AYANMO_GAMBIERAS_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.STR, 8, 16, 24, 32 },
            { xi.mod.VIT, 8, 16, 24, 32 },
            { xi.mod.MND, 8, 16, 24, 32 },
        }
    },

    [92] = -- Mallquis Armor Set +2 VIT/INT/MND +8-32
    {
        items =
        {
            xi.item.MALLQUIS_RING,
            xi.item.MALLQUIS_CHAPEAU_P2,
            xi.item.MALLQUIS_SAIO_P2,
            xi.item.MALLQUIS_CUFFS_P2,
            xi.item.MALLQUIS_TREWS_P2,
            xi.item.MALLQUIS_CLOGS_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.VIT, 8, 16, 24, 32 },
            { xi.mod.INT, 8, 16, 24, 32 },
            { xi.mod.MND, 8, 16, 24, 32 },
        }
    },

    [93] = -- AF1 119 +2/3 WAR
    {
        items =
        {
            xi.item.REGAL_RING,
            xi.item.PUMMELERS_CALLIGAE_P2,
            xi.item.PUMMELERS_CALLIGAE_P3,
            xi.item.PUMMELERS_CUISSES_P2,
            xi.item.PUMMELERS_CUISSES_P3,
            xi.item.PUMMELERS_MUFFLERS_P2,
            xi.item.PUMMELERS_MUFFLERS_P3,
            xi.item.PUMMELERS_LORICA_P2,
            xi.item.PUMMELERS_LORICA_P3,
            xi.item.PUMMELERS_MASK_P2,
            xi.item.PUMMELERS_MASK_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [94] = -- AF1 119 +2/3 MNK
    {
        items =
        {
            xi.item.REGAL_RING,
            xi.item.ANCHORITES_GAITERS_P2,
            xi.item.ANCHORITES_GAITERS_P3,
            xi.item.ANCHORITES_HOSE_P2,
            xi.item.ANCHORITES_HOSE_P3,
            xi.item.ANCHORITES_GLOVES_P2,
            xi.item.ANCHORITES_GLOVES_P3,
            xi.item.ANCHORITES_CYCLAS_P2,
            xi.item.ANCHORITES_CYCLAS_P3,
            xi.item.ANCHORITES_CROWN_P2,
            xi.item.ANCHORITES_CROWN_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [95] = -- AF1 119 +2/3 WHM
    {
        items =
        {
            xi.item.REGAL_EARRING,
            xi.item.THEOPHANY_DUCKBILLS_P2,
            xi.item.THEOPHANY_DUCKBILLS_P3,
            xi.item.THEOPHANY_PANTALOONS_P2,
            xi.item.THEOPHANY_PANTALOONS_P3,
            xi.item.THEOPHANY_MITTS_P2,
            xi.item.THEOPHANY_MITTS_P3,
            xi.item.THEOPHANY_BRIAULT_P2,
            xi.item.THEOPHANY_BRIAULT_P3,
            xi.item.THEOPHANY_CAP_P2,
            xi.item.THEOPHANY_CAP_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [96] = -- AF1 119 +2/3 BLM
    {
        items =
        {
            xi.item.REGAL_EARRING,
            xi.item.SPAEKONAS_SABOTS_P2,
            xi.item.SPAEKONAS_SABOTS_P3,
            xi.item.SPAEKONAS_TONBAN_P2,
            xi.item.SPAEKONAS_TONBAN_P3,
            xi.item.SPAEKONAS_GLOVES_P2,
            xi.item.SPAEKONAS_GLOVES_P3,
            xi.item.SPAEKONAS_COAT_P2,
            xi.item.SPAEKONAS_COAT_P3,
            xi.item.SPAEKONAS_PETASOS_P2,
            xi.item.SPAEKONAS_PETASOS_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [97] = -- AF1 119 +2/3 RDM
    {
        items =
        {
            xi.item.REGAL_EARRING,
            xi.item.ATROPHY_BOOTS_P2,
            xi.item.ATROPHY_BOOTS_P3,
            xi.item.ATROPHY_TIGHTS_P2,
            xi.item.ATROPHY_TIGHTS_P3,
            xi.item.ATROPHY_GLOVES_P2,
            xi.item.ATROPHY_GLOVES_P3,
            xi.item.ATROPHY_TABARD_P2,
            xi.item.ATROPHY_TABARD_P3,
            xi.item.ATROPHY_CHAPEAU_P2,
            xi.item.ATROPHY_CHAPEAU_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [98] = -- AF1 119 +2/3 THF
    {
        items =
        {
            xi.item.REGAL_RING,
            xi.item.PILLAGERS_POULAINES_P2,
            xi.item.PILLAGERS_POULAINES_P3,
            xi.item.PILLAGERS_CULOTTES_P2,
            xi.item.PILLAGERS_CULOTTES_P3,
            xi.item.PILLAGERS_ARMLETS_P2,
            xi.item.PILLAGERS_ARMLETS_P3,
            xi.item.PILLAGERS_VEST_P2,
            xi.item.PILLAGERS_VEST_P3,
            xi.item.PILLAGERS_BONNET_P2,
            xi.item.PILLAGERS_BONNET_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [99] = -- AF1 119 +2/3 PLD
    {
        items =
        {
            xi.item.REGAL_RING,
            xi.item.REVERENCE_LEGGINGS_P2,
            xi.item.REVERENCE_LEGGINGS_P3,
            xi.item.REVERENCE_BREECHES_P2,
            xi.item.REVERENCE_BREECHES_P3,
            xi.item.REVERENCE_GAUNTLETS_P2,
            xi.item.REVERENCE_GAUNTLETS_P3,
            xi.item.REVERENCE_SURCOAT_P2,
            xi.item.REVERENCE_SURCOAT_P3,
            xi.item.REVERENCE_CORONET_P2,
            xi.item.REVERENCE_CORONET_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [100] = -- AF1 119 +2/3 DRK
    {
        items =
        {
            xi.item.REGAL_RING,
            xi.item.IGNOMINY_SOLLERETS_P2,
            xi.item.IGNOMINY_SOLLERETS_P3,
            xi.item.IGNOMINY_FLANCHARD_P2,
            xi.item.IGNOMINY_FLANCHARD_P3,
            xi.item.IGNOMINY_GAUNTLETS_P2,
            xi.item.IGNOMINY_GAUNTLETS_P3,
            xi.item.IGNOMINY_CUIRASS_P2,
            xi.item.IGNOMINY_CUIRASS_P3,
            xi.item.IGNOMINY_BURGEONET_P2,
            xi.item.IGNOMINY_BURGEONET_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [101] = -- AF1 119 +2/3 BST
    {
        items =
        {
            xi.item.REGAL_RING,
            xi.item.TOTEMIC_GAITERS_P2,
            xi.item.TOTEMIC_GAITERS_P3,
            xi.item.TOTEMIC_TROUSERS_P2,
            xi.item.TOTEMIC_TROUSERS_P3,
            xi.item.TOTEMIC_GLOVES_P2,
            xi.item.TOTEMIC_GLOVES_P3,
            xi.item.TOTEMIC_JACKCOAT_P2,
            xi.item.TOTEMIC_JACKCOAT_P3,
            xi.item.TOTEMIC_HELM_P2,
            xi.item.TOTEMIC_HELM_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [102] = -- AF1 119 +2/3 BRD
    {
        items =
        {
            xi.item.REGAL_EARRING,
            xi.item.BRIOSO_SLIPPERS_P2,
            xi.item.BRIOSO_SLIPPERS_P3,
            xi.item.BRIOSO_CANNIONS_P2,
            xi.item.BRIOSO_CANNIONS_P3,
            xi.item.BRIOSO_CUFFS_P2,
            xi.item.BRIOSO_CUFFS_P3,
            xi.item.BRIOSO_JUSTAUCORPS_P2,
            xi.item.BRIOSO_JUSTAUCORPS_P3,
            xi.item.BRIOSO_ROUNDLET_P2,
            xi.item.BRIOSO_ROUNDLET_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [103] = -- AF1 119 +2/3 RNG
    {
        items =
        {
            xi.item.REGAL_RING,
            xi.item.ORION_SOCKS_P2,
            xi.item.ORION_SOCKS_P3,
            xi.item.ORION_BRACCAE_P2,
            xi.item.ORION_BRACCAE_P3,
            xi.item.ORION_BRACERS_P2,
            xi.item.ORION_BRACERS_P3,
            xi.item.ORION_JERKIN_P2,
            xi.item.ORION_JERKIN_P3,
            xi.item.ORION_BERET_P2,
            xi.item.ORION_BERET_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [104] = -- AF1 119 +2/3 SAM
    {
        items =
        {
            xi.item.REGAL_RING,
            xi.item.WAKIDO_SUNE_ATE_P2,
            xi.item.WAKIDO_SUNE_ATE_P3,
            xi.item.WAKIDO_HAIDATE_P2,
            xi.item.WAKIDO_HAIDATE_P3,
            xi.item.WAKIDO_KOTE_P2,
            xi.item.WAKIDO_KOTE_P3,
            xi.item.WAKIDO_DOMARU_P2,
            xi.item.WAKIDO_DOMARU_P3,
            xi.item.WAKIDO_KABUTO_P2,
            xi.item.WAKIDO_KABUTO_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [105] = -- AF1 119 +2/3 NIN
    {
        items =
        {
            xi.item.REGAL_RING,
            xi.item.HACHIYA_KYAHAN_P2,
            xi.item.HACHIYA_KYAHAN_P3,
            xi.item.HACHIYA_HAKAMA_P2,
            xi.item.HACHIYA_HAKAMA_P3,
            xi.item.HACHIYA_TEKKO_P2,
            xi.item.HACHIYA_TEKKO_P3,
            xi.item.HACHIYA_CHAINMAIL_P2,
            xi.item.HACHIYA_CHAINMAIL_P3,
            xi.item.HACHIYA_HATSUBURI_P2,
            xi.item.HACHIYA_HATSUBURI_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        }
    },

    [106] = -- AF1 119 +2/3 DRG
    {
        items =
        {
            xi.item.REGAL_RING,
            xi.item.VISHAP_GREAVES_P2,
            xi.item.VISHAP_GREAVES_P3,
            xi.item.VISHAP_BRAIS_P2,
            xi.item.VISHAP_BRAIS_P3,
            xi.item.VISHAP_FINGER_GAUNTLETS_P2,
            xi.item.VISHAP_FINGER_GAUNTLETS_P3,
            xi.item.VISHAP_MAIL_P2,
            xi.item.VISHAP_MAIL_P3,
            xi.item.VISHAP_ARMET_P2,
            xi.item.VISHAP_ARMET_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [107] = -- AF1 119 +2/3 SMN
    {
        items =
        {
            xi.item.REGAL_BELT,
            xi.item.CONVOKERS_PIGACHES_P2,
            xi.item.CONVOKERS_PIGACHES_P3,
            xi.item.CONVOKERS_SPATS_P2,
            xi.item.CONVOKERS_SPATS_P3,
            xi.item.CONVOKERS_BRACERS_P2,
            xi.item.CONVOKERS_BRACERS_P3,
            xi.item.CONVOKERS_DOUBLET_P2,
            xi.item.CONVOKERS_DOUBLET_P3,
            xi.item.CONVOKERS_HORN_P2,
            xi.item.CONVOKERS_HORN_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        }
    },

    [108] = -- AF1 119 +2/3 BLU
    {
        items =
        {
            xi.item.REGAL_EARRING,
            xi.item.ASSIMILATORS_CHARUQS_P2,
            xi.item.ASSIMILATORS_CHARUQS_P3,
            xi.item.ASSIMILATORS_SHALWAR_P2,
            xi.item.ASSIMILATORS_SHALWAR_P3,
            xi.item.ASSIMILATORS_BAZUBANDS_P2,
            xi.item.ASSIMILATORS_BAZUBANDS_P3,
            xi.item.ASSIMILATORS_JUBBAH_P2,
            xi.item.ASSIMILATORS_JUBBAH_P3,
            xi.item.ASSIMILATORS_KEFFIYEH_P2,
            xi.item.ASSIMILATORS_KEFFIYEH_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [109] = -- AF1 119 +2/3 COR
    {
        items =
        {
            xi.item.REGAL_RING,
            xi.item.LAKSAMANAS_BOTTES_P2,
            xi.item.LAKSAMANAS_BOTTES_P3,
            xi.item.LAKSAMANAS_TREWS_P2,
            xi.item.LAKSAMANAS_TREWS_P3,
            xi.item.LASKAMANAS_GANTS_P2,
            xi.item.LASKAMANAS_GANTS_P3,
            xi.item.LAKSAMANAS_FRAC_P2,
            xi.item.LAKSAMANAS_FRAC_P3,
            xi.item.LAKSAMANAS_TRICORNE_P2,
            xi.item.LAKSAMANAS_TRICORNE_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [110] = -- AF1 119 +2/3 PUP
    {
        items =
        {
            xi.item.REGAL_RING,
            xi.item.FOIRE_BABOUCHES_P2,
            xi.item.FOIRE_BABOUCHES_P3,
            xi.item.FOIRE_CHURIDARS_P2,
            xi.item.FOIRE_CHURIDARS_P3,
            xi.item.FOIRE_DASTANAS_P2,
            xi.item.FOIRE_DASTANAS_P3,
            xi.item.FOIRE_TOBE_P2,
            xi.item.FOIRE_TOBE_P3,
            xi.item.FOIRE_TAJ_P2,
            xi.item.FOIRE_TAJ_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [111] = -- AF1 119 +2/3 DNC (M)
    {
        items =
        {
            xi.item.REGAL_RING,
            xi.item.MAXIXI_TIARA_M_P2,
            xi.item.MAXIXI_CASAQUE_M_P2,
            xi.item.MAXIXI_BANGLES_M_P2,
            xi.item.MAXIXI_TIGHTS_M_P2,
            xi.item.MAXIXI_TOE_SHOES_M_P2,
            xi.item.MAXIXI_TIARA_M_P3,
            xi.item.MAXIXI_CASAQUE_M_P3,
            xi.item.MAXIXI_BANGLES_M_P3,
            xi.item.MAXIXI_TIGHTS_M_P3,
            xi.item.MAXIXI_TOE_SHOES_M_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [112] = -- AF1 119 +2/3 DNC (F)
    {
        items =
        {
            xi.item.REGAL_RING,
            xi.item.MAXIXI_TIARA_F_P2,
            xi.item.MAXIXI_CASAQUE_F_P2,
            xi.item.MAXIXI_BANGLES_F_P2,
            xi.item.MAXIXI_TIGHTS_F_P2,
            xi.item.MAXIXI_TOE_SHOES_F_P2,
            xi.item.MAXIXI_TIARA_F_P3,
            xi.item.MAXIXI_CASAQUE_F_P3,
            xi.item.MAXIXI_BANGLES_F_P3,
            xi.item.MAXIXI_TIGHTS_F_P3,
            xi.item.MAXIXI_TOE_SHOES_F_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [113] = -- AF1 119 +2/3 SCH
    {
        items =
        {
            xi.item.REGAL_EARRING,
            xi.item.ACADEMICS_LOAFERS_P2,
            xi.item.ACADEMICS_LOAFERS_P3,
            xi.item.ACADEMICS_PANTS_P2,
            xi.item.ACADEMICS_PANTS_P3,
            xi.item.ACADEMICS_BRACERS_P2,
            xi.item.ACADEMICS_BRACERS_P3,
            xi.item.ACADEMICS_GOWN_P2,
            xi.item.ACADEMICS_GOWN_P3,
            xi.item.ACADEMICS_MORTARBOARD_P2,
            xi.item.ACADEMICS_MORTARBOARD_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [114] = -- AF1 119 +2/3 GEO
    {
        items =
        {
            xi.item.REGAL_EARRING,
            xi.item.GEOMANCY_SANDALS_P2,
            xi.item.GEOMANCY_SANDALS_P3,
            xi.item.GEOMANCY_PANTS_P2,
            xi.item.GEOMANCY_PANTS_P3,
            xi.item.GEOMANCY_MITAINES_P2,
            xi.item.GEOMANCY_MITAINES_P3,
            xi.item.GEOMANCY_TUNIC_P2,
            xi.item.GEOMANCY_TUNIC_P3,
            xi.item.GEOMANCY_GALERO_P2,
            xi.item.GEOMANCY_GALERO_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [115] = -- AF1 119 +2/3 RUN
    {
        items =
        {
            xi.item.REGAL_RING,
            xi.item.RUNEIST_BOOTS_P2,
            xi.item.RUNEIST_BOOTS_P3,
            xi.item.RUNIEST_TROUSERS_P2,
            xi.item.RUNEIST_TROUSERS_P3,
            xi.item.RUNEIST_MITONS_P2,
            xi.item.RUNEIST_MITONS_P3,
            xi.item.RUNEIST_COAT_P2,
            xi.item.RUNEIST_COAT_P3,
            xi.item.RUNEIST_BANDEAU_P2,
            xi.item.RUNEIST_BANDEAU_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 30, 45, 60 },
            { xi.mod.RACC, 15, 30, 45, 60 },
            { xi.mod.MACC, 15, 30, 45, 60 },
        },
    },

    [116] = -- Outrider set (Phys damage taken -10%)
    {
        items =
        {
            xi.item.OUTRIDER_MASK,
            xi.item.OUTRIDER_MAIL,
            xi.item.OUTRIDER_MITTENS,
            xi.item.OUTRIDER_HOSE,
            xi.item.OUTRIDER_GREAVES,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.DMGPHYS, -1000 },
        },
    },

    [117] = -- Espial set (Crit damage +10%)
    {
        items =
        {
            xi.item.ESPIAL_CAP,
            xi.item.ESPIAL_GAMBISON,
            xi.item.ESPIAL_BRACERS,
            xi.item.ESPIAL_HOSE,
            xi.item.ESPIAL_SOCKS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.CRIT_DMG_INCREASE, 10 },
        },
    },

    [118] = -- Wayfarer set (Refresh+3)
    {
        items =
        {
            xi.item.WAYFARER_CIRCLET,
            xi.item.WAYFARER_ROBE,
            xi.item.WAYFARER_CUFFS,
            xi.item.WAYFARER_SLOPS,
            xi.item.WAYFARER_CLOGS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.REFRESH, 3 },
        },
    },

    [119] = -- Apogee +1
    {
        items =
        {
            xi.item.APOGEE_CROWN_P1,
            xi.item.APOGEE_DALMATICA_P1,
            xi.item.APOGEE_MITTS_P1,
            xi.item.APOGEE_SLACKS_P1,
            xi.item.APOGEE_PUMPS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.BP_DAMAGE, 4, 6, 8, 10 },
        },
    },

    [120] = -- Ryuo +1
    {
        items =
        {
            xi.item.RYUO_SOMEN_P1,
            xi.item.RYUO_DOMARU_P1,
            xi.item.RYUO_TEKKO_P1,
            xi.item.RYUO_HAKAMA_P1,
            xi.item.RYUO_SUNE_ATE_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ATT, 20, 30, 40, 50 },
        },
    },

    [121] = -- Souveran +1
    {
        items =
        {
            xi.item.SOUVERAN_SCHALLER_P1,
            xi.item.SOUVERAN_CUIRASS_P1,
            xi.item.SOUVERAN_HANDSCHUHS_P1,
            xi.item.SOUVERAN_DIECHLINGS_P1,
            xi.item.SOUVERAN_SCHUHS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DMG, -4, -6, -8, -10 },
        },
    },

    [122] = -- Emicho +1
    {
        items =
        {
            xi.item.EMICHO_CORONET_P1,
            xi.item.EMICHO_HAUBERT_P1,
            xi.item.EMICHO_GAUNTLETS_P1,
            xi.item.EMICHO_HOSE_P1,
            xi.item.EMICHO_GAMBIERAS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DOUBLE_ATTACK, 4, 6, 8, 10 },
        },
    },

    [123] = -- Kaykaus +1
    {
        items =
        {
            xi.item.KAYKAUS_MITRA_P1,
            xi.item.KAYKAUS_BLIAUT_P1,
            xi.item.KAYKAUS_CUFFS_P1,
            xi.item.KAYKAUS_TIGHTS_P1,
            xi.item.KAYKAUS_BOOTS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.CURE_POTENCY_II, 4, 6, 8, 10 },
        },
    },

    [124] = -- Rao +1
    {
        items =
        {
            xi.item.RAO_KABUTO_P1,
            xi.item.RAO_TOGI_P1,
            xi.item.RAO_KOTE_P1,
            xi.item.RAO_HAIDATE_P1,
            xi.item.RAO_SUNE_ATE_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.MARTIAL_ARTS, 8, 12, 16, 20 },
        },
    },

    [125] = -- Adhemar +1
    {
        items =
        {
            xi.item.ADHEMAR_BONNET_P1,
            xi.item.ADHEMAR_JACKET_P1,
            xi.item.ADHEMAR_WRISTBANDS_P1,
            xi.item.ADHEMAR_KECKS_P1,
            xi.item.ADHEMAR_GAMASHES_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.CRITHITRATE, 4, 6, 8, 10 },
        },
    },

    [126] = -- Carmine +1
    {
        items =
        {
            xi.item.CARMINE_MASK_P1,
            xi.item.CARMINE_SCALE_MAIL_P1,
            xi.item.CARMINE_FINGER_GAUNTLETS_P1,
            xi.item.CARMINE_CUISSES_P1,
            xi.item.CARMINE_GREAVES_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ACC, 20, 30, 40, 50 },
        },
    },

    [127] = -- Lustratio +1
    {
        items =
        {
            xi.item.LUSTRATIO_CAP_P1,
            xi.item.LUSTRATIO_HARNESS_P1,
            xi.item.LUSTRATIO_MITTENS_P1,
            xi.item.LUSTRATIO_SUBLIGAR_P1,
            xi.item.LUSTRATIO_LEGGINGS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ALL_WSDMG_FIRST_HIT, 4, 6, 8, 10 },
        },
    },

    [128] = -- Argosy +1
    {
        items =
        {
            xi.item.ARGOSY_CELATA_P1,
            xi.item.ARGOSY_HAUBERK_P1,
            xi.item.ARGOSY_MUFFLERS_P1,
            xi.item.ARGOSY_BREECHES_P1,
            xi.item.ARGOSY_SOLLERETS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DOUBLE_ATTACK, 4, 6, 8, 10 },
        },
    },

    [129] = -- Amalric +1
    {
        items =
        {
            xi.item.AMALRIC_COIF_P1,
            xi.item.AMALRIC_DOUBLET_P1,
            xi.item.AMALRIC_GAGES_P1,
            xi.item.AMALRIC_SLOPS_P1,
            xi.item.AMALRIC_NAILS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.MATT, 20, 30, 40, 50 },
        },
    },

    [130] = -- Moliones's Sickle/Ring
    {
        items =
        {
            xi.item.MOLIONESS_SICKLE,
            xi.item.MOLIONESS_RING,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ACC,              5 },
            { xi.mod.SOULEATER_EFFECT, 2 },
        },
    },

    [131] = -- Mavi +2 Set: Occasionally triples the WSC of Blue Magic Spells. Will stack with Chain Affinity.
    {
        items =
        {
            xi.item.MAVI_KAVUK_P2,
            xi.item.MAVI_MINTAN_P2,
            xi.item.MAVI_BAZUBANDS_P2,
            xi.item.MAVI_TAYT_P2,
            xi.item.MAVI_BASMAK_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AUGMENT_BLU_MAGIC, 2, 3, 4, 5 },
        },
    },

    [132] = -- AF3 BLU 109/119 Set: Occasionally triples the WSC of Blue Magic Spells. Will stack with Chain Affinity.
    {
        items =
        {
            xi.item.HASHISHIN_KAVUK,
            xi.item.HASHISHIN_KAVUK_P1,
            xi.item.HASHISHIN_MINTAN,
            xi.item.HASHISHIN_MINTAN_P1,
            xi.item.HASHISHIN_BAZUBANDS,
            xi.item.HASHISHIN_BAZUBANDS_P1,
            xi.item.HASHISHIN_TAYT,
            xi.item.HASHISHIN_TAYT_P1,
            xi.item.HASHISHIN_BASMAK,
            xi.item.HASHISHIN_BASMAK_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AUGMENT_BLU_MAGIC, 2, 3, 4, 5 },
        },
    }
}

-- Build Table to lookup Set ID based on Item ID.  This is cached in xi.gear_sets.itemToSetId table,
-- and only rebuilt on loading the gear_sets global into cache.
xi.gear_sets.createItemToSetId = function()
    local itemTable = {}

    for setId, setData in pairs(gearSets) do
        for _, itemId in ipairs(setData.items) do
            if itemTable[itemId] == nil then
                local setIdTable = {}

                itemTable[itemId] = setIdTable
            end

            table.insert(itemTable[itemId], setId)
        end
    end

    return itemTable
end

xi.gear_sets.itemToSetId = xi.gear_sets.createItemToSetId()

-- Global function to check for equipped sets and apply mods.  This is called by
-- core on equip and unequip of an item.
xi.gear_sets.checkForGearSet = function(player)
    player:clearGearSetMods()

    -- Build a table containing equipped Set IDs, and the count for each one.
    local equippedSets = {}
    for equipmentSlot = 0, xi.MAX_SLOTID do
        local equipId = player:getEquipID(equipmentSlot)
        local setId   = xi.gear_sets.itemToSetId[equipId]

        if setId then
            for _, v in ipairs(setId) do
                equippedSets[v] = equippedSets[v] and (equippedSets[v] + 1) or 1
            end
        end
    end

    -- Apply Mods for each set after boundary checking the counts.
    for setId, setCount in pairs(equippedSets) do
        local minEquippedReq = gearSets[setId].minEquipped and gearSets[setId].minEquipped or 2
        local maxEquippedReq = gearSets[setId].maxEquipped and gearSets[setId].maxEquipped or (xi.MAX_SLOTID + 1)

        if setCount >= minEquippedReq then
            local modTierIndex = math.min(setCount, maxEquippedReq) - minEquippedReq

            for _, modData in ipairs(gearSets[setId].mods) do
                player:addGearSetMod(setId, modData[1], modData[modTierIndex + 2])
            end
        end
    end
end
