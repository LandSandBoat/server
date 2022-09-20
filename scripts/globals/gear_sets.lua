-----------------------------------
-- Gear sets
-- Allows the use of gear sets with modifiers
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/status')
-----------------------------------

xi = xi or {}
xi.gear_sets = xi.gear_sets or {}
xi.gear_sets.itemToSetId = xi.gear_sets.createItemToSetId()

local gearSets =
{
    [1] = -- Usukane's set (5% Haste)
    {
        items =
        {
            xi.items.USUKANE_SOMEN,
            xi.items.USUKANE_HARAMAKI,
            xi.items.USUKANE_GOTE,
            xi.items.USUKANE_HIZAYOROI,
            xi.items.USUKANE_SUNE_ATE,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.HASTE_GEAR, 500, 0, 0 },
        },
    },

    [2] = -- Skadi's set (5% critrate is guess)
    {
        items =
        {
            xi.items.SKADIS_VISOR,
            xi.items.SKADIS_CUIRIE,
            xi.items.SKADIS_BAZUBANDS,
            xi.items.SKADIS_CHAUSSES,
            xi.items.SKADIS_JAMBEAUX,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.CRITHITRATE, 5, 0, 0 },
        },
    },

    [3] = -- Ares's set (5% DA)
    {
        items =
        {
            xi.items.ARES_MASK,
            xi.items.ARES_CUIRASS,
            xi.items.ARES_GAUNTLETS,
            xi.items.ARES_FLANCHARD,
            xi.items.ARES_SOLLERETS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.DOUBLE_ATTACK, 5, 0, 0 },
        },
    },

    [4] = -- Denali Jacket Set (Increases Accuracy +20)
    {
        items =
        {
            xi.items.DENALI_BONNET,
            xi.items.DENALI_JACKET,
            xi.items.DENALI_WRISTBANDS,
            xi.items.DENALI_KECKS,
            xi.items.DENALI_GAMASHES,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.ACC, 20, 0, 0 },
        },
    },

    [5] = -- Askar Korazin Set (Max HP Boost %10)
    {
        items =
        {
            xi.items.ASKAR_ZUCCHETTO,
            xi.items.ASKAR_KORAZIN,
            xi.items.ASKAR_MANOPOLAS,
            xi.items.ASKAR_DIRS,
            xi.items.ASKAR_GAMBIERAS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.HPP, 10, 0, 0 },
        },
    },

    [6] = -- Pahluwan Khazagand Set (Needs Verification)
    {
        items =
        {
            xi.items.PAHLUWAN_QALANSUWA,
            xi.items.PAHLUWAN_KHAZAGAND,
            xi.items.PAHLUWAN_DASTANAS,
            xi.items.PAHLUWAN_SERAWEELS,
            xi.items.PAHLUWAN_CRACKOWS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.SUBTLE_BLOW, 8, 0, 0 },
        },
    },

    [7] = -- Morrigan's Robe Set (+5 Magic. Atk Bonus)
    {
        items =
        {
            xi.items.MORRIGANS_CORONAL,
            xi.items.MORRIGANS_ROBE,
            xi.items.MORRIGANS_CUFFS,
            xi.items.MORRIGANS_SLOPS,
            xi.items.MORRIGANS_PIGACHES,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.MATT, 5, 0, 0 },
        },
    },

    [8] = -- Marduk's Jubbah Set (5% fastcast)
    {
        items =
        {
            xi.items.MARDUKS_TIARA,
            xi.items.MARDUKS_JUBBAH,
            xi.items.MARDUKS_DASTANAS,
            xi.items.MARDUKS_SHALWAR,
            xi.items.MARDUKS_CRACKOWS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.FASTCAST, 5, 0, 0 },
        },
    },

    [9] = -- Goliard Saio Set - Total Set Bonus +10% Magic Def. Bonus
    {
        items =
        {
            xi.items.GOLIARD_CHAPEAU,
            xi.items.GOLIARD_SAIO,
            xi.items.GOLIARD_CUFFS,
            xi.items.GOLIARD_TREWS,
            xi.items.GOLIARD_CLOGS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.MDEF, 10, 0, 0 },
        },
    },

    [10] = -- Yigit Gomlek Set (1mp per tick) Adds "Refresh" effect
    {
        items =
        {
            xi.items.YIGIT_TURBAN,
            xi.items.YIGIT_GOMLEK,
            xi.items.YIGIT_GAGES,
            xi.items.YIGIT_SERAWEELS,
            xi.items.YIGIT_CRACKOWS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.REFRESH, 1, 0, 0 },
        },
    },

    [11] = -- Perle Hauberk Set (Haste +5%)
    {
        items =
        {
            xi.items.PERLE_SALADE,
            xi.items.PERLE_HAUBERK,
            xi.items.PERLE_MOUFLES,
            xi.items.PERLE_BRAYETTES,
            xi.items.PERLE_SOLLERETS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.HASTE_GEAR, 500, 0, 0 },
        },
    },

    [12] = -- Aurore Doublet Set (Store TP +8)
    {
        items =
        {
            xi.items.AURORE_BERET,
            xi.items.AURORE_DOUBLET,
            xi.items.AURORE_GLOVES,
            xi.items.AURORE_BRAIS,
            xi.items.AURORE_GAITERS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.STORETP, 8, 0, 0 }
        },
    },

    [13] = -- Teal Set: Fast Cast +4-10%
    {
        items =
        {
            xi.items.TEAL_CHAPEAU,
            xi.items.TEAL_SAIO,
            xi.items.TEAL_CUFFS,
            xi.items.TEAL_SLOPS,
            xi.items.TEAL_PIGACHES,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.FASTCAST, 4, 2, 0 },
        },
    },

    [14] = -- Calma Armor Set haste%6
    {
        items =
        {
            xi.items.CALMA_ARMET,
            xi.items.CALMA_BREASTPLATE,
            xi.items.CALMA_GAUNTLETS,
            xi.items.CALMA_HOSE,
            xi.items.CALMA_LEGGINGS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.HASTE_GEAR, 600, 0, 0 },
        },
    },

    [15] = -- Magavan Armor Set  magic accuracy +5
    {
        items =
        {
            xi.items.MAGAVAN_BERET,
            xi.items.MAGAVAN_FROCK,
            xi.items.MAGAVAN_MITTS,
            xi.items.MAGAVAN_SLOPS,
            xi.items.MAGAVAN_CLOGS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.MACC, 5, 0, 0 },
        },
    },

    [16] = -- Mustela Harness Set  crit rate 5%
    {
        items =
        {
            xi.items.MUSTELA_MASK,
            xi.items.MUSTELA_HARNESS,
            xi.items.MUSTELA_GLOVES,
            xi.items.MUSTELA_BRAIS,
            xi.items.MUSTELA_BOOTS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.CRITHITRATE, 5, 0, 0 },
        },
    },

    [17] = -- Bowman's set: Ranged atk +15
    {
        items =
        {
            xi.items.BOWMANS_MASK,
            xi.items.BOWMANS_LEDELSENS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.RATT, 15, 0, 0 },
        },
    },

    [18] = -- Fourth Division Brune Set
    {
        items =
        {
            xi.items.FOURTH_DIVISION_HAUBE,
            xi.items.FOURTH_DIVISION_BRUNNE,
            xi.items.FOURTH_DIVISION_HENTZES,
            xi.items.FOURTH_DIVISION_SCHOSS,
            xi.items.FOURTH_DIVISION_SCHUHS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ATT, 1, 4.7, 0 },
        },
    },

    [19] = -- Cobra Unit Harness Set
    {
        items =
        {
            xi.items.COBRA_UNIT_CAP,
            xi.items.COBRA_UNIT_HARNESS,
            xi.items.COBRA_UNIT_MITTENS,
            xi.items.COBRA_UNIT_SUBLIGAR,
            xi.items.COBRA_UNIT_LEGGINGS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.COUNTER, 1, 1, 0 },
        },
    },

    [20] = -- Cobra Unit Robe Set
    {
        items =
        {
            xi.items.COBRA_UNIT_CLOCHE,
            xi.items.COBRA_UNIT_ROBE,
            xi.items.COBRA_UNIT_GLOVES,
            xi.items.COBRA_UNIT_TREWS,
            xi.items.COBRA_UNIT_CRACKOWS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.MACC, 1, 1, 0 },
        },
    },

    [21] = -- Iron Ram Chainmail Set.
    {
        items =
        {
            xi.items.IRON_RAM_HELM,
            xi.items.IRON_RAM_CHAINMAIL,
            xi.items.IRON_RAM_MUFFLERS,
            xi.items.IRON_RAM_BREECHES,
            xi.items.IRON_RAM_SOLLERETS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ACC, 1, 1, 0 },
            { xi.mod.ATT, 1, 1, 0 },
        },
    },

    [22] = -- Fourth Division Cuirass Set
    {
        items =
        {
            xi.items.FOURTH_DIVISION_ARMET,
            xi.items.FOURTH_DIVISION_CUIRASS,
            xi.items.FOURTH_DIVISION_GAUNTLETS,
            xi.items.FOURTH_DIVISION_CUISSES,
            xi.items.FOURTH_DIVISION_SABATONS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.HP, 10, 10, 0 },
        },
    },

    [23] = -- Cobra Unit Coat Set
    {
        items =
        {
            xi.items.COBRA_UNIT_HAT,
            xi.items.COBRA_UNIT_COAT,
            xi.items.COBRA_UNIT_CUFFS,
            xi.items.COBRA_UNIT_SLOPS,
            xi.items.COBRA_UNIT_PIGACHES,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.MP, 10, 10, 0 },
        },
    },

    [24] = -- Amir Korazin Set - Double mod here! It is why it has 2 IDs.
    {
        items =
        {
            xi.items.AMIR_PUGGAREE,
            xi.items.AMIR_KORAZIN,
            xi.items.AMIR_KOLLUKS,
            xi.items.AMIR_DIRS,
            xi.items.AMIR_BOOTS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.UDMGBREATH, -800, 0, 0 },
            { xi.mod.UDMGMAGIC,  -800, 0, 0 },
        },
    },

    [25] = -- Hachiryu Haramaki Set - Store tp (5, 10, 20)
    {
        items =
        {
            xi.items.HACHIRYU_HARAMAKI,
            xi.items.HACHIRYU_KOTE,
            xi.items.HACHIRYU_HAIDATE,
            xi.items.HACHIRYU_SUNE_ATE,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.STORETP, 5, 5, 5 },
        },
    },

    [26] = -- Ravager's Armor +2 Set - Double attack double damage chance
    {
        items =
        {
            xi.items.RAVAGERS_MASK_P2,
            xi.items.RAVAGERS_LORICA_P2,
            xi.items.RAVAGERS_MUFFLERS_P2,
            xi.items.RAVAGERS_CUISSES_P2,
            xi.items.RAVAGERS_CALLIGAE_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DA_DOUBLE_DMG_RATE, 2, 1, 0 },
        },
    },

    [27] = -- Fazheluo Mail Set. Set Bonus: "Double Attack"+5%. Active with any 2 pieces.
    {
        items =
        {
            xi.items.FAZHELUO_HELM,
            xi.items.FAZHELUO_HELM_P1,
            xi.items.FAZHELUO_MAIL,
            xi.items.FAZHELUO_RADIANT_MAIL,
            xi.items.FAZHELUO_MAIL_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DOUBLE_ATTACK, 5, 0, 0 },
        },
    },

    [28] = -- Cuauhtli Harness Set. Set Bonus: Haste+8%. Active with any 2 pieces.
    {
        items =
        {
            xi.items.CUAUHTLI_HEADPIECE,
            xi.items.CUAUHTLI_HEADPIECE_P1,
            xi.items.CUAUHTLI_HARNESS,
            xi.items.MEXTLI_HARNESS,
            xi.items.CUAUHTLI_HARNESS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.HASTE_GEAR, 800, 0, 0 },
        },
    },

    [29] = -- Hyskos Robe Set. Set Bonus: Magic Accuracy+5. Active with any 2 pieces.
    {
        items =
        {
            xi.items.HYKSOS_KHAT,
            xi.items.HYKSOS_KHAT_P1,
            xi.items.HYKSOS_ROBE,
            xi.items.ANHUR_ROBE,
            xi.items.HYKSOS_ROBE_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.MACC, 5, 0, 0 },
        },
    },

    [30] = -- Ogier's Armor Set. Set Bonus: Adds "Refresh" xi.effect. Provides 1 mp/tick for 2-3 pieces worn, 2 mp/tick for 4-5 pieces worn.
    {
        items =
        {
            xi.items.OGIERS_HELM,
            xi.items.OGIERS_SURCOAT,
            xi.items.OGIERS_GAUNTLETS,
            xi.items.OGIERS_BREECHES,
            xi.items.OGIERS_LEGGINGS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.REFRESH, 1, 0.4, 0 },
        },
    },

    [31] = -- Athos's Armor Set. Set Bonus: Increases rate of critical hits. Gives +3% for the first 2 pieces and +1% for every additional piece.
    {
        items =
        {
            xi.items.ATHOSS_CHAPEAU,
            xi.items.ATHOSS_TABARD,
            xi.items.ATHOSS_GLOVES,
            xi.items.ATHOSS_TIGHTS,
            xi.items.ATHOSS_BOOTS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.CRITHITRATE, 1, 1, 0 },
        },
    },

    [32] = -- Rubeus Armor Set. Set Bonus: Enhances "Fast Cast" effect. 2 or 3 pieces equipped: Fast Cast +4, 4 or 5 pieces equipped: Fast Cast +10
    {
        items =
        {
            xi.items.RUBEUS_BANDEAU,
            xi.items.RUBEUS_JACKET,
            xi.items.RUBEUS_GLOVES,
            xi.items.RUBEUS_SPATS,
            xi.items.RUBEUS_BOOTS,
        },
        minEquipped = 2,
        maxEquipped = 4, -- Special Case
        mods =
        {
            { xi.mod.FASTCAST, 10, 0, 0 },
        },
    },

    [33] = -- Navarch's Attire +2 Set. Set Bonus: Augments "Quick Draw". Quick Draw will occasionally deal triple damage.
    {
        items =
        {
            xi.items.NAVARCHS_TRICORNE_P2,
            xi.items.NAVARCHS_FRAC_P2,
            xi.items.NAVARCHS_GANTS_P2,
            xi.items.NAVARCHS_CULOTTES_P2,
            xi.items.NAVARCHS_BOTTES_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.QUICK_DRAW_TRIPLE_DAMAGE, 2, 1, 0 },
        },
    },

    [34] = -- Charis Attire +2 Set. Set Bonus: Augments "Samba". Occasionally doubles damage with Samba up. Adds approximately 1-2% per piece past the first.
    {
        items =
        {
            xi.items.CHARIS_TIARA_P2,
            xi.items.CHARIS_CASAQUE_P2,
            xi.items.CHARIS_BANGLES_P2,
            xi.items.CHARIS_TIGHTS_P2,
            xi.items.CHARIS_TOE_SHOES_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.SAMBA_DOUBLE_DAMAGE, 1, 1.8, 0 },
        },
    },

    [35] = -- Iga Garb +2 Set. Set Bonus: Augments "Dual Wield". Attacks made while dual wielding occasionally add an extra attack
    {
        items =
        {
            xi.items.IGA_ZUKIN_P2,
            xi.items.IGA_NINGI_P2,
            xi.items.IGA_TEKKO_P2,
            xi.items.IGA_HAKAMA_P2,
            xi.items.IGA_KYAHAN_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.EXTRA_DUAL_WIELD_ATTACK, 4, 2, 0 },
        }
    },

    [36] = -- Sylvan Attire +2 Set. Set Bonus: Augments "Rapid Shot". Rapid Shots occasionally deal double damage.
    {
        items =
        {
            xi.items.SYLVAN_GAPETTE_P2,
            xi.items.SYLVAN_CABAN_P2,
            xi.items.SYLVAN_GLOVELETTES_P2,
            xi.items.SYLVAN_BRAGUES_P2,
            xi.items.SYLVAN_BOTTILLONS_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.RAPID_SHOT_DOUBLE_DAMAGE, 2, 1, 0 },
        },
    },

    [37] = -- Creed Armor +2 Set. Set Bonus: Occasionally absorbs damage taken. Set proc believed to be somewhere around 5%, more testing needed. Verification Needed Absorb rate likely varies with # of set pieces.
    {
        items =
        {
            xi.items.CREED_ARMET_P2,
            xi.items.CREED_CUIRASS_P2,
            xi.items.CREED_GAUNTLETS_P2,
            xi.items.CREED_CUISSES_P2,
            xi.items.CREED_SABATONS_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ABSORB_DMG_CHANCE, 2, 1, 0 },
        },
    },

    [38] = -- Unkai Domaru +2 Set. Set Bonus: Augments "Zanshin". Zanshin attacks will occasionally deal double damage.
    {
        items =
        {
            xi.items.UNKAI_KABUTO_P2,
            xi.items.UNKAI_DOMARU_P2,
            xi.items.UNKAI_KOTE_P2,
            xi.items.UNKAI_HAIDATE_P2,
            xi.items.UNKAI_SUNE_ATE_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ZANSHIN_DOUBLE_DAMAGE, 2, 1, 0 },
        },
    },

    [39] = -- Tantra Attire +2 Set. Set Bonus: Augments "Kick Attacks". Occasionally allows a second Kick Attack during an attack round without the use of Footwork.
    {
        items =
        {
            xi.items.TANTRA_CROWN_P2,
            xi.items.TANTRA_CYCLAS_P2,
            xi.items.TANTRA_GLOVES_P2,
            xi.items.TANTRA_HOSE_P2,
            xi.items.TANTRA_GAITERS_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.EXTRA_KICK_ATTACK, 2, 1, 0 },
        },
    },

    [40] = -- Raider's Attire +2 Set. Set Bonus: Augments "Triple Attack". Occasionally causes the second and third hits of a Triple Attack to deal triple damage.Verification Needed Requires a minimum of two pieces.
    {
        items =
        {
            xi.items.RAIDERS_BONNET_P2,
            xi.items.RAIDERS_VEST_P2,
            xi.items.RAIDERS_ARMLETS_P2,
            xi.items.RAIDERS_CULOTTES_P2,
            xi.items.RAIDERS_POULAINES_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.TA_TRIPLE_DMG_RATE, 2, 1, 0 },
        },
    },

    [41] = -- Orison Attire +2 Set. Set Bonus: Augments elemental resistance spells. Bar Elemental spells will occasionally nullify damage of the same element.
    {
        items =
        {
            xi.items.ORISON_CAP_P2,
            xi.items.ORISON_BLIAUD_P2,
            xi.items.ORISON_MITTS_P2,
            xi.items.ORISON_PANTALOONS_P2,
            xi.items.ORISON_DUCKBILLS_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.BAR_ELEMENT_NULL_CHANCE, 4, 2, 0 },
        },
    },

    [42] = -- Savant's Attire +2 Set. Set Bonus: Augments Grimoire. Spells that match your current Arts will occasionally cast instantly, without recast.
    {
        items =
        {
            xi.items.SAVANTS_BONNET_P2,
            xi.items.SAVANTS_GOWN_P2,
            xi.items.SAVANTS_BRACERS_P2,
            xi.items.SAVANTS_PANTS_P2,
            xi.items.SAVANTS_LOAFERS_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.GRIMOIRE_INSTANT_CAST, 2, 1, 0 },
        },
    },

    [43] = -- Paramount Earring Sets. Set Bonus: HP+30, VIT+6, Accuracy+6, Ranged Accuracy+6. Set Bonus is active with any 2 items(Earring+Weapon or Weapon+Weapon)
    {
        items =
        {
            xi.items.PARAMOUNT_EARRING,
            xi.items.SINFENDER,
            xi.items.FLEETWING,
            xi.items.KEBBIE,
            xi.items.USESHI,
            xi.items.FARSEER,
            xi.items.AMANOKAKOYUMI,
            xi.items.OSORAKU,
            xi.items.BALISARDE,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.HP,  30, 0, 0 },
            { xi.mod.VIT,  6, 0, 0 },
            { xi.mod.ACC,  6, 0, 0 },
            { xi.mod.RACC, 6, 0, 0 },
        },
    },

    [44] = -- Supremacy Earring Sets. Set Bonus: STR+6, Attack+4, Ranged Attack+4, "Magic Atk. Bonus"+2. Active with any 2 items(Earring+Weapon)
    {
        items =
        {
            xi.items.SUPREMACY_EARRING,
            xi.items.ACANTHA_SHAVERS,
            xi.items.CATALYST,
            xi.items.MERVEILLEUSE,
            xi.items.MURDERER,
            xi.items.SKYSTRIDER,
            xi.items.SPARTH,
            xi.items.VENDETTA,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.STR,  6, 0, 0 },
            { xi.mod.ATT,  4, 0, 0 },
            { xi.mod.RATT, 4, 0, 0 },
            { xi.mod.MATT, 2, 0, 0 },
        },
    },

    [45] = -- Brilliant Earring Set. Set Bonus: Evasion, HP Recovered while healing, Reduces Emnity. Active with any 2 items(Earring+Weapon)
    {
        items =
        {
            xi.items.BRILLIANT_EARRING,
            xi.items.MUKADEMARU,
            xi.items.ALASTOR,
            xi.items.GRANDEUR,
            xi.items.CLEARPATH,
            xi.items.FAUCHEUSE,
            xi.items.SILKTONE,
            xi.items.BASILISK,
            xi.items.YAGENTOSHIRO,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.EVA,    10, 0, 0 },
            { xi.mod.HPHEAL, 10, 0, 0 },
            { xi.mod.ENMITY, -5, 0, 0 },
        }
    },

    [46] = -- Twilight Mail Set. Set Bonus: Auto-Reraise
    {
        items =
        {
            xi.items.TWILIGHT_HELM,
            xi.items.TWILIGHT_MAIL,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.RERAISE_III, 1, 0, 0 },
        },
    },

    [47] = -- Begin Jailer weapons: Set is weapon + Virtue stone, bonus 50% extra melee swing.
    {
        items =
        {
            xi.items.VIRTUE_STONE,
            xi.items.HOPE_STAFF,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50, 0, 0 },
        },
    },

    [48] =
    {
        items =
        {
            xi.items.VIRTUE_STONE,
            xi.items.JUSTICE_SWORD,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50, 0, 0 },
        },
    },

    [49] =
    {
        items =
        {
            xi.items.VIRTUE_STONE,
            xi.items.TEMPERANCE_AXE,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50, 0, 0 },
        },
    },

    [50] =
    {
        items =
        {
            xi.items.VIRTUE_STONE,
            xi.items.LOVE_HALBERD,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50, 0, 0 },
        },
    },

    [51] =
    {
        items =
        {
            xi.items.VIRTUE_STONE,
            xi.items.FORTITUDE_AXE,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50, 0, 0 },
        },
    },

    [52] =
    {
        items =
        {
            xi.items.VIRTUE_STONE,
            xi.items.FAITH_BAGHNAKHS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50, 0, 0 },
        },
    },

    [53] = -- End Jailer weapons
    {
        items =
        {
            xi.items.VIRTUE_STONE,
            xi.items.PRUDENCE_ROD,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AMMO_SWING, 50, 0, 0 },
        },
    },

    [54] = -- Bladeborn/Steelflash Earrings
    {
        items =
        {
            xi.items.STEELFLASH_EARRING,
            xi.items.BLADEBORN_EARRING,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DOUBLE_ATTACK, 7, 0, 0 },
        },
    },

    [55] = -- Dudgeon/Heartseeker Earrings
    {
        items =
        {
            xi.items.DUDGEON_EARRING,
            xi.items.HEARTSEEKER_EARRING,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DUAL_WIELD, 7, 0, 0 },
        },
    },

    [56] = -- Psystorm/Lifestorm Earrings
    {
        items =
        {
            xi.items.LIFESTORM_EARRING,
            xi.items.PSYSTORM_EARRING,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.MACC, 12, 0, 0 },
        },
    },

    [57] = -- Samurai 109/119 af3
    {
        items =
        {
            xi.items.KASUGA_DOMARU,
            xi.items.KASUGA_DOMARU_P1,
            xi.items.KASUGA_SUNE_ATE_P1,
            xi.items.KASUGA_HAIDATE,
            xi.items.KASUGA_HAIDATE_P1,
            xi.items.KASUGA_KABUTO,
            xi.items.KASUGA_KABUTO_P1,
            xi.items.KASUGA_KOTE,
            xi.items.KASUGA_KOTE_P1,
            xi.items.KASUGA_SUNE_ATE,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ZANSHIN_DOUBLE_DAMAGE, 2, 1, 0 },
        },
    },

    [58] = -- MNK 109/119 af3
    {
        items =
        {
            xi.items.BHIKKU_GAITERS_P1,
            xi.items.BHIKKU_GAITERS,
            xi.items.BHIKKU_HOSE_P1,
            xi.items.BHIKKU_HOSE,
            xi.items.BHIKKU_GLOVES_P1,
            xi.items.BHIKKU_GLOVES,
            xi.items.BHIKKU_CYCLAS_P1,
            xi.items.BHIKKU_CYCLAS,
            xi.items.BHIKKU_CROWN_P1,
            xi.items.BHIKKU_CROWN,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.EXTRA_KICK_ATTACK, 2, 1, 0 },
        },
    },

    [59] = -- 109/119 WAR AF3
    {
        items =
        {
            xi.items.BOII_MASK,
            xi.items.BOII_MASK_P1,
            xi.items.BOII_CALLIGAE,
            xi.items.BOII_CALLIGAE_P1,
            xi.items.BOII_CUISSES_P1,
            xi.items.BOII_CUISSES,
            xi.items.BOII_MUFFLERS_P1,
            xi.items.BOII_MUFFLERS,
            xi.items.BOII_LORICA_P1,
            xi.items.BOII_LORICA,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DA_DOUBLE_DMG_RATE, 2, 1, 0 },
        },
    },

    [60] = -- 109/119 THF AF3
    {
        items =
        {
            xi.items.SKULKERS_BONNET,
            xi.items.SKULKERS_BONNET_P1,
            xi.items.SKULKERS_POULAINES,
            xi.items.SKULKERS_POULAINES_P1,
            xi.items.SKULKERS_CULOTTES,
            xi.items.SKULKERS_CULOTTES_P1,
            xi.items.SKULKERS_ARMLETS_P1,
            xi.items.SKULKERS_ARMLETS,
            xi.items.SKULKERS_VEST,
            xi.items.SKULKERS_VEST_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.TA_TRIPLE_DMG_RATE, 2, 1, 0 },
        },
    },

    [61] = -- 109/119 RNG AF3
    {
        items =
        {
            xi.items.AMINI_CABAN,
            xi.items.AMINI_CABAN_P1,
            xi.items.AMINI_GAPETTE_P1,
            xi.items.AMINI_GAPETTE,
            xi.items.AMINI_BOTTILLONS,
            xi.items.AMINI_BOTTILLONS_P1,
            xi.items.AMINI_BRAGUE,
            xi.items.AMINI_BRAGUE_P1,
            xi.items.AMINI_GLOVELETTES,
            xi.items.AMINI_GLOVELETTES_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.RAPID_SHOT_DOUBLE_DAMAGE, 2, 1, 0 },
        },
    },

    [62] = -- 109/119 PLD AF3
    {
        items =
        {
            xi.items.CHEVALIERS_CUIRASS,
            xi.items.CHEVALIERS_CUIRASS_P1,
            xi.items.CHEVALIERS_ARMET,
            xi.items.CHEVALIERS_ARMET_P1,
            xi.items.CHEVALIERS_SABATONS_P1,
            xi.items.CHEVALIERS_SABATONS,
            xi.items.CHEVALIERS_GAUNTLETS,
            xi.items.CHEVALIERS_GAUNTLETS_P1,
            xi.items.CHEVALIERS_CUISSES,
            xi.items.CHEVALIERS_CUISSES_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ABSORB_DMG_CHANCE, 2, 1, 0 },
        },
    },

    [63] = -- 109/119 NIN AF3
    {
        items =
        {
            xi.items.HATTORI_NINGI,
            xi.items.HATTORI_NINGI_P1,
            xi.items.HATTORI_ZUKIN,
            xi.items.HATTORI_ZUKIN_P1,
            xi.items.HATTORI_TEKKO,
            xi.items.HATTORI_TEKKO_P1,
            xi.items.HATTORI_HAKAMA,
            xi.items.HATTORI_HAKAMA_P1,
            xi.items.HATTORI_KYAHAN,
            xi.items.HATTORI_KYAHAN_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.EXTRA_DUAL_WIELD_ATTACK, 4, 2, 0 },
        },
    },

    [64] = -- 109/119 COR AF3
    {
        items =
        {
            xi.items.CHASSEURS_BOTTES,
            xi.items.CHASSEURS_BOTTES_P1,
            xi.items.CHASSEURS_TRICORNE,
            xi.items.CHASSEURS_TRICORNE_P1,
            xi.items.CHASSEURS_FRAC,
            xi.items.CHASSEURS_FRAC_P1,
            xi.items.CHASSEURS_GANTS,
            xi.items.CHASSEURS_GANTS_P1,
            xi.items.CHASSEURS_CULOTTES,
            xi.items.CHASSEURS_CULOTTES_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.QUICK_DRAW_TRIPLE_DAMAGE, 2, 1, 0 },
        },
    },

    [65] = -- 109/119 SCH AF3
    {
        items =
        {
            xi.items.ARBATEL_PANTS,
            xi.items.ARBATEL_PANTS_P1,
            xi.items.ARBATEL_LOAFERS,
            xi.items.ARBATEL_LOAFERS_P1,
            xi.items.ARBATEL_BONNET,
            xi.items.ARBATEL_BONNET_P1,
            xi.items.ARBATEL_GOWN,
            xi.items.ARBATEL_GOWN_P1,
            xi.items.ARBATEL_BRACERS,
            xi.items.ARBATEL_BRACERS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.GRIMOIRE_INSTANT_CAST, 2, 1, 0 },
        },
    },

    [66] = -- 109/119 WHM AF3
    {
        items =
        {
            xi.items.EBERS_PANTALOONS,
            xi.items.EBERS_PANTALOONS_P1,
            xi.items.EBERS_DUCKBILLS,
            xi.items.EBERS_DUCKBILLS_P1,
            xi.items.EBERS_CAP,
            xi.items.EBERS_CAP_P1,
            xi.items.EBERS_BLIAUD,
            xi.items.EBERS_BLIAUD_P1,
            xi.items.EBERS_MITTS,
            xi.items.EBERS_MITTS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.BAR_ELEMENT_NULL_CHANCE, 4, 2, 0 },
        },
    },

    [67] = -- Heka/Nefer body + NQ or HQ Khat = 2 tick refresh
    {
        items =
        {
            xi.items.HEKAS_KALASIRIS,
            xi.items.NEFER_KHAT,
            xi.items.NEFER_KHAT_P1,
            xi.items.NEFER_KALASIRIS,
            xi.items.NEFER_KALASIRIS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.REFRESH, 3, 0, 0 },
        },
    },

    [68] = -- Dasra's/Nasatya's Ring set gives HP/MP +50
    {
        items =
        {
            xi.items.NASATYAS_RING,
            xi.items.DASRAS_RING,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.HP, 50, 0, 0 },
            { xi.mod.MP, 50, 0, 0 },
        },
    },

    [69] = -- Helenus's/Cassandra's earring set: Mag atk bonus+5 and Mag acc +5
    {
        items =
        {
            xi.items.HELENUSS_EARRING,
            xi.items.CASSANDRAS_EARRING,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.MATT, 5, 0, 0 },
            { xi.mod.MACC, 5, 0, 0 },
        },
    },

    [70] = -- Lava's/Kusha's earring set: Atk+6/Acc+12
    {
        items =
        {
            xi.items.LAVAS_RING,
            xi.items.KUSHAS_RING,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ATT,  6, 0, 0 },
            { xi.mod.ACC, 12, 0, 0 },
            { xi.mod.DEF,  6, 0, 0 },
        },
    },

    [71] = -- Iron Ram Haubert Set
    {
        items =
        {
            xi.items.IRON_RAM_SALLET,
            xi.items.IRON_RAM_HAUBERK,
            xi.items.IRON_RAM_DASTANAS,
            xi.items.IRON_RAM_HOSE,
            xi.items.IRON_RAM_GREAVES,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.FIRE_MEVA,    5, 5, 10 },
            { xi.mod.ICE_MEVA,     5, 5, 10 },
            { xi.mod.WIND_MEVA,    5, 5, 10 },
            { xi.mod.EARTH_MEVA,   5, 5, 10 },
            { xi.mod.THUNDER_MEVA, 5, 5, 10 },
            { xi.mod.WATER_MEVA,   5, 5, 10 },
            { xi.mod.LIGHT_MEVA,   5, 5, 10 },
            { xi.mod.DARK_MEVA,    5, 5, 10 },
        },
    },

    [72] = -- Altdorf's/Wilhelm's earring: AGI+8
    {
        items =
        {
            xi.items.ALTDORFS_EARRING,
            xi.items.WILHELMS_EARRING,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AGI, 8, 0, 0 },
        },
    },

    [73] = -- Gothic Gauntlets/Sabatons: Atk/RAtk +5
    {
        items =
        {
            xi.items.GOTHIC_GAUNTLETS,
            xi.items.GOTHIC_SABATONS,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ATT,  5, 0, 0 },
            { xi.mod.RATT, 5, 0, 0 },
        },
    },

    [74] = -- Teal Set +1: Fast Cast +4-10%
    {
        items =
        {
            xi.items.TEAL_CHAPEAU_P1,
            xi.items.TEAL_SAIO_P1,
            xi.items.TEAL_CUFFS_P1,
            xi.items.TEAL_SLOPS_P1,
            xi.items.TEAL_PIGACHES_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.FASTCAST, 4, 2, 0 },
        },
    },

    [75] = -- Aurore Set +1: Store TP +2-8
    {
        items =
        {
            xi.items.AURORE_BERET_P1,
            xi.items.AURORE_DOUBLET_P1,
            xi.items.AURORE_GLOVES_P1,
            xi.items.AURORE_BRAIS_P1,
            xi.items.AURORE_GAITERS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.STORETP, 2, 2, 0 },
        },
    },

    [76] = -- Perle Set +1: Haste +2-5%
    {
        items =
        {
            xi.items.PERLE_SALADE_P1,
            xi.items.PERLE_HAUBERK_P1,
            xi.items.PERLE_MOUFLES_P1,
            xi.items.PERLE_BRAYETTES_P1,
            xi.items.PERLE_SOLLERETS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.HASTE_GEAR, 200, 100, 0 },
        },
    },

    [77] = -- Morrigan's Attire Set +1: Magic Atk. Bonus +3-9%
    {
        items =
        {
            xi.items.MORRIGANS_CORONAL_P1,
            xi.items.MORRIGANS_ROBE_P1,
            xi.items.MORRIGANS_CUFFS_P1,
            xi.items.MORRIGANS_SLOPS_P1,
            xi.items.MORRIGANS_PIGACHES_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.MATT, 3, 2, 0 },
        },
    },

    [78] = -- Marduk's Attire Set +1: Fast Cast +3-9%
    {
        items =
        {
            xi.items.MARDUKS_TIARA_P1,
            xi.items.MARDUKS_JUBBAH_P1,
            xi.items.MARDUKS_DASTANAS_P1,
            xi.items.MARDUKS_SHALWAR_P1,
            xi.items.MARDUKS_CRACKOWS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.FASTCAST, 3, 2, 0 },
        },
    },

    [79] = -- Usukane Armor Set +1: Haste +3-9%
    {
        items =
        {
            xi.items.USUKANE_SOMEN_P1,
            xi.items.USUKANE_HARAMAKI_P1,
            xi.items.USUKANE_GOTE_P1,
            xi.items.USUKANE_HIZAYOROI_P1,
            xi.items.USUKANE_SUNE_ATE_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.HASTE_GEAR, 300, 200, 0 },
        },
    },

    [80] = -- Skadi's Attire Set +1: Critical hit rate +3-9%
    {
        items =
        {
            xi.items.SKADIS_VISOR_P1,
            xi.items.SKADIS_CUIRIE_P1,
            xi.items.SKADIS_BAZUBANDS_P1,
            xi.items.SKADIS_CHAUSSES_P1,
            xi.items.SKADIS_JAMBEAUX_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.CRITHITRATE, 3, 2, 0 },
        },
    },

    [81] = -- Ares' Armor Set +1: Double Attack +3-9%
    {
        items =
        {
            xi.items.ARES_MASK_P1,
            xi.items.ARES_CUIRASS_P1,
            xi.items.ARES_GAUNTLETS_P1,
            xi.items.ARES_FLANCHARD_P1,
            xi.items.ARES_SOLLERETS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DOUBLE_ATTACK, 3, 2, 0 },
        },
    },

    [82] = -- Alcedo Cuisses and Gauntlets: Magic damage taken -5%
    {
        items =
        {
            xi.items.ALCEDO_GAUNTLETS,
            xi.items.ALCEDO_CUISSES,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DMGMAGIC, -500, 0, 0 },
        },
    },

    [83] = -- Sulevia's Armor Set +2: Subtle Blow +5-20
    {
        items =
        {
            xi.items.SULEVIAS_RING,
            xi.items.SULEVIAS_MASK_P2,
            xi.items.SULEVIAS_PLATEMAIL_P2,
            xi.items.SULEVIAS_GAUNTLETS_P2,
            xi.items.SULEVIAS_CUISSES_P2,
            xi.items.SULEVIAS_LEGGINGS_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.SUBTLE_BLOW, 5, 5, 0 },
        },
    },

    [84] = -- Hizamaru Armor Set +2: Counter +4-16%
    {
        items =
        {
            xi.items.HIZAMARU_RING,
            xi.items.HIZAMARU_SOMEN_P2,
            xi.items.HIZAMARU_HARAMAKI_P2,
            xi.items.HIZAMARU_KOTE_P2,
            xi.items.HIZAMARU_HIZAYOROI_P2,
            xi.items.HIZAMARU_SUNE_ATE_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.COUNTER, 4, 4, 0 },
        },
    },

    [85] = -- Inyanga Armor Set +2: Refresh +1-4
    {
        items =
        {
            xi.items.INYANGA_RING,
            xi.items.INYANGA_TIARA_P2,
            xi.items.INYANGA_JUBBAH_P2,
            xi.items.INYANGA_DASTANAS_P2,
            xi.items.INYANGA_SHALWAR_P2,
            xi.items.INYANGA_CRACKOWS_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.REFRESH, 1, 1, 0 },
        },
    },

    [86] = -- Meghanada Armor Set +2: Regen +3-12
    {
        items =
        {
            xi.items.MEGHANADA_RING,
            xi.items.MEGHANADA_VISOR_P2,
            xi.items.MEGHANADA_CUIRIE_P2,
            xi.items.MEGHANADA_GLOVES_P2,
            xi.items.MEGHANADA_CHAUSSES_P2,
            xi.items.MEGHANADA_JAMBEAUX_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.REGEN, 3, 3, 0 },
        },
    },

    [87] = -- Jhakri Armor Set +2: Fast Cast +1-4%
    {
        items =
        {
            xi.items.JHAKRI_RING,
            xi.items.JHAKRI_CORONAL_P2,
            xi.items.JHAKRI_ROBE_P2,
            xi.items.JHAKRI_CUFFS_P2,
            xi.items.JHAKRI_SLOPS_P2,
            xi.items.JHAKRI_PIGACHES_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.FAST_CAST, 1, 1, 0 },
        },
    },

    [88] = -- Flamma Armor Set +2 STR/DEX/VIT +8-32
    {
        items =
        {
            xi.items.FLAMMA_RING,
            xi.items.FLAMMA_ZUCCHETTO_P2,
            xi.items.FLAMMA_KORAZIN_P2,
            xi.items.FLAMMA_MANOPOLAS_P2,
            xi.items.FLAMMA_DIRS_P2,
            xi.items.FLAMMA_GAMBIERAS_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.STR, 8, 8, 0 },
            { xi.mod.DEX, 8, 8, 0 },
            { xi.mod.VIT, 8, 8, 0 },
        },
    },

    [89] = -- Tali'ah Armor Set +2 DEX/VIT/CHR +8-32
    {
        items =
        {
            xi.items.TALIAH_RING,
            xi.items.TALIAH_TURBAN_P2,
            xi.items.TALIAH_MANTEEL_P2,
            xi.items.TALIAH_GAGES_P2,
            xi.items.TALIAH_SERAWEELS_P2,
            xi.items.TALIAH_CRACKOWS_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.DEX, 8, 8, 0 },
            { xi.mod.VIT, 8, 8, 0 },
            { xi.mod.CHR, 8, 8, 0 },
        }
    },

    [90] = -- Mummu Armor Set +2 DEX/AGI/CHR +8-32
    {
        items =
        {
            xi.items.MUMMU_RING,
            xi.items.MUMMU_BONNET_P2,
            xi.items.MUMMU_JACKET_P2,
            xi.items.MUMMU_WRISTS_P2,
            xi.items.MUMMU_KECKS_P2,
            xi.items.MUMMU_GAMASHES_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.DEX, 8, 8, 0 },
            { xi.mod.AGI, 8, 8, 0 },
            { xi.mod.CHR, 8, 8, 0 },
        },
    },

    [91] = -- Ayanmo Armor Set +2 STR/VIT/MND +8-32
    {
        items =
        {
            xi.items.AYANMO_RING,
            xi.items.AYANMO_ZUCCHETTO_P2,
            xi.items.AYANMO_CORAZZA_P2,
            xi.items.AYANMO_MANOPOLAS_P2,
            xi.items.AYANMO_COSCIALES_P2,
            xi.items.AYANMO_GAMBIERAS_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.STR, 8, 8, 0 },
            { xi.mod.VIT, 8, 8, 0 },
            { xi.mod.MND, 8, 8, 0 },
        }
    },

    [92] = -- Mallquis Armor Set +2 VIT/INT/MND +8-32
    {
        items =
        {
            xi.items.MALLQUIS_RING,
            xi.items.MALLQUIS_CHAPEAU_P2,
            xi.items.MALLQUIS_SAIO_P2,
            xi.items.MALLQUIS_CUFFS_P2,
            xi.items.MALLQUIS_TREWS_P2,
            xi.items.MALLQUIS_CLOGS_P2,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.VIT, 8, 8, 0 },
            { xi.mod.INT, 8, 8, 0 },
            { xi.mod.MND, 8, 8, 0 },
        }
    },

    [93] = -- AF1 119 +2/3 WAR
    {
        items =
        {
            xi.items.REGAL_RING,
            xi.items.PUMMELERS_CALLIGAE_P2,
            xi.items.PUMMELERS_CALLIGAE_P3,
            xi.items.PUMMELERS_CUISSES_P2,
            xi.items.PUMMELERS_CUISSES_P3,
            xi.items.PUMMELERS_MUFFLERS_P2,
            xi.items.PUMMELERS_MUFFLERS_P3,
            xi.items.PUMMELERS_LORICA_P2,
            xi.items.PUMMELERS_LORICA_P3,
            xi.items.PUMMELERS_MASK_P2,
            xi.items.PUMMELERS_MASK_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [94] = -- AF1 119 +2/3 MNK
    {
        items =
        {
            xi.items.REGAL_RING,
            xi.items.ANCHORITES_GAITERS_P2,
            xi.items.ANCHORITES_GAITERS_P3,
            xi.items.ANCHORITES_HOSE_P2,
            xi.items.ANCHORITES_HOSE_P3,
            xi.items.ANCHORITES_GLOVES_P2,
            xi.items.ANCHORITES_GLOVES_P3,
            xi.items.ANCHORITES_CYCLAS_P2,
            xi.items.ANCHORITES_CYCLAS_P3,
            xi.items.ANCHORITES_CROWN_P2,
            xi.items.ANCHORITES_CROWN_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [95] = -- AF1 119 +2/3 WHM
    {
        items =
        {
            xi.items.REGAL_EARRING,
            xi.items.THEOPHANY_DUCKBILLS_P2,
            xi.items.THEOPHANY_DUCKBILLS_P3,
            xi.items.THEOPHANY_PANTALOONS_P2,
            xi.items.THEOPHANY_PANTALOONS_P3,
            xi.items.THEOPHANY_MITTS_P2,
            xi.items.THEOPHANY_MITTS_P3,
            xi.items.THEOPHANY_BRIAULT_P2,
            xi.items.THEOPHANY_BRIAULT_P3,
            xi.items.THEOPHANY_CAP_P2,
            xi.items.THEOPHANY_CAP_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [96] = -- AF1 119 +2/3 BLM
    {
        items =
        {
            xi.items.REGAL_EARRING,
            xi.items.SPAEKONAS_SABOTS_P2,
            xi.items.SPAEKONAS_SABOTS_P3,
            xi.items.SPAEKONAS_TONBAN_P2,
            xi.items.SPAEKONAS_TONBAN_P3,
            xi.items.SPAEKONAS_GLOVES_P2,
            xi.items.SPAEKONAS_GLOVES_P3,
            xi.items.SPAEKONAS_COAT_P2,
            xi.items.SPAEKONAS_COAT_P3,
            xi.items.SPAEKONAS_PETASOS_P2,
            xi.items.SPAEKONAS_PETASOS_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [97] = -- AF1 119 +2/3 RDM
    {
        items =
        {
            xi.items.REGAL_EARRING,
            xi.items.ATROPHY_BOOTS_P2,
            xi.items.ATROPHY_BOOTS_P3,
            xi.items.ATROPHY_TIGHTS_P2,
            xi.items.ATROPHY_TIGHTS_P3,
            xi.items.ATROPHY_GLOVES_P2,
            xi.items.ATROPHY_GLOVES_P3,
            xi.items.ATROPHY_TABARD_P2,
            xi.items.ATROPHY_TABARD_P3,
            xi.items.ATROPHY_CHAPEAU_P2,
            xi.items.ATROPHY_CHAPEAU_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [98] = -- AF1 119 +2/3 THF
    {
        items =
        {
            xi.items.REGAL_RING,
            xi.items.PILLAGERS_POULAINES_P2,
            xi.items.PILLAGERS_POULAINES_P3,
            xi.items.PILLAGERS_CULOTTES_P2,
            xi.items.PILLAGERS_CULOTTES_P3,
            xi.items.PILLAGERS_ARMLETS_P2,
            xi.items.PILLAGERS_ARMLETS_P3,
            xi.items.PILLAGERS_VEST_P2,
            xi.items.PILLAGERS_VEST_P3,
            xi.items.PILLAGERS_BONNET_P2,
            xi.items.PILLAGERS_BONNET_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [99] = -- AF1 119 +2/3 PLD
    {
        items =
        {
            xi.items.REGAL_RING,
            xi.items.REVERENCE_LEGGINGS_P2,
            xi.items.REVERENCE_LEGGINGS_P3,
            xi.items.REVERENCE_BREECHES_P2,
            xi.items.REVERENCE_BREECHES_P3,
            xi.items.REVERENCE_GAUNTLETS_P2,
            xi.items.REVERENCE_GAUNTLETS_P3,
            xi.items.REVERENCE_SURCOAT_P2,
            xi.items.REVERENCE_SURCOAT_P3,
            xi.items.REVERENCE_CORONET_P2,
            xi.items.REVERENCE_CORONET_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [100] = -- AF1 119 +2/3 DRK
    {
        items =
        {
            xi.items.REGAL_RING,
            xi.items.IGNOMINY_SOLLERETS_P2,
            xi.items.IGNOMINY_SOLLERETS_P3,
            xi.items.IGNOMINY_FLANCHARD_P2,
            xi.items.IGNOMINY_FLANCHARD_P3,
            xi.items.IGNOMINY_GAUNTLETS_P2,
            xi.items.IGNOMINY_GAUNTLETS_P3,
            xi.items.IGNOMINY_CUIRASS_P2,
            xi.items.IGNOMINY_CUIRASS_P3,
            xi.items.IGNOMINY_BURGONET_P2,
            xi.items.IGNOMINY_BURGONET_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [101] = -- AF1 119 +2/3 BST
    {
        items =
        {
            xi.items.REGAL_RING,
            xi.items.TOTEMIC_GAITERS_P2,
            xi.items.TOTEMIC_GAITERS_P3,
            xi.items.TOTEMIC_TROUSERS_P2,
            xi.items.TOTEMIC_TROUSERS_P3,
            xi.items.TOTEMIC_GLOVES_P2,
            xi.items.TOTEMIC_GLOVES_P3,
            xi.items.TOTEMIC_JACKCOAT_P2,
            xi.items.TOTEMIC_JACKCOAT_P3,
            xi.items.TOTEMIC_HELM_P2,
            xi.items.TOTEMIC_HELM_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [102] = -- AF1 119 +2/3 BRD
    {
        items =
        {
            xi.items.REGAL_EARRING,
            xi.items.BRIOSO_SLIPPERS_P2,
            xi.items.BRIOSO_SLIPPERS_P3,
            xi.items.BRIOSO_CANNIONS_P2,
            xi.items.BRIOSO_CANNIONS_P3,
            xi.items.BRIOSO_CUFFS_P2,
            xi.items.BRIOSO_CUFFS_P3,
            xi.items.BRIOSO_JUSTAUCORPS_P2,
            xi.items.BRIOSO_JUSTAUCORPS_P3,
            xi.items.BRIOSO_ROUNDLET_P2,
            xi.items.BRIOSO_ROUNDLET_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [103] = -- AF1 119 +2/3 RNG
    {
        items =
        {
            xi.items.REGAL_RING,
            xi.items.ORION_SOCKS_P2,
            xi.items.ORION_SOCKS_P3,
            xi.items.ORION_BRACCAE_P2,
            xi.items.ORION_BRACCAE_P3,
            xi.items.ORION_BRACERS_P2,
            xi.items.ORION_BRACERS_P3,
            xi.items.ORION_JERKIN_P2,
            xi.items.ORION_JERKIN_P3,
            xi.items.ORION_BERET_P2,
            xi.items.ORION_BERET_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [104] = -- AF1 119 +2/3 SAM
    {
        items =
        {
            xi.items.REGAL_RING,
            xi.items.WAKIDO_SUNE_ATE_P2,
            xi.items.WAKIDO_SUNE_ATE_P3,
            xi.items.WAKIDO_HAIDATE_P2,
            xi.items.WAKIDO_HAIDATE_P3,
            xi.items.WAKIDO_KOTE_P2,
            xi.items.WAKIDO_KOTE_P3,
            xi.items.WAKIDO_DOMARU_P2,
            xi.items.WAKIDO_DOMARU_P3,
            xi.items.WAKIDO_KABUTO_P2,
            xi.items.WAKIDO_KABUTO_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [105] = -- AF1 119 +2/3 NIN
    {
        items =
        {
            xi.items.REGAL_RING,
            xi.items.HACHIYA_KYAHAN_P2,
            xi.items.HACHIYA_KYAHAN_P3,
            xi.items.HACHIYA_HAKAMA_P2,
            xi.items.HACHIYA_HAKAMA_P3,
            xi.items.HACHIYA_TEKKO_P2,
            xi.items.HACHIYA_TEKKO_P3,
            xi.items.HACHIYA_CHAINMAIL_P2,
            xi.items.HACHIYA_CHAINMAIL_P3,
            xi.items.HACHIYA_HATSUBURI_P2,
            xi.items.HACHIYA_HATSUBURI_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        }
    },

    [106] = -- AF1 119 +2/3 DRG
    {
        items =
        {
            xi.items.REGAL_RING,
            xi.items.VISHAP_GREAVES_P2,
            xi.items.VISHAP_GREAVES_P3,
            xi.items.VISHAP_BRAIS_P2,
            xi.items.VISHAP_BRAIS_P3,
            xi.items.VISHAP_FINGER_GAUNTLETS_P2,
            xi.items.VISHAP_FINGER_GAUNTLETS_P3,
            xi.items.VISHAP_MAIL_P2,
            xi.items.VISHAP_MAIL_P3,
            xi.items.VISHAP_ARMET_P2,
            xi.items.VISHAP_ARMET_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [107] = -- AF1 119 +2/3 SMN
    {
        items =
        {
            xi.items.REGAL_BELT,
            xi.items.CONVOKERS_PIGACHES_P2,
            xi.items.CONVOKERS_PIGACHES_P3,
            xi.items.CONVOKERS_SPATS_P2,
            xi.items.CONVOKERS_SPATS_P3,
            xi.items.CONVOKERS_BRACERS_P2,
            xi.items.CONVOKERS_BRACERS_P3,
            xi.items.CONVOKERS_DOUBLET_P2,
            xi.items.CONVOKERS_DOUBLET_P3,
            xi.items.CONVOKERS_HORN_P2,
            xi.items.CONVOKERS_HORN_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        }
    },

    [108] = -- AF1 119 +2/3 BLU
    {
        items =
        {
            xi.items.REGAL_EARRING,
            xi.items.ASSIMILATORS_CHARUQS_P2,
            xi.items.ASSIMILATORS_CHARUQS_P3,
            xi.items.ASSIMILATORS_SHALWAR_P2,
            xi.items.ASSIMILATORS_SHALWAR_P3,
            xi.items.ASSIMILATORS_BAZUBANDS_P2,
            xi.items.ASSIMILATORS_BAZUBANDS_P3,
            xi.items.ASSIMILATORS_JUBBAH_P2,
            xi.items.ASSIMILATORS_JUBBAH_P3,
            xi.items.ASSIMILATORS_KEFFIYEH_P2,
            xi.items.ASSIMILATORS_KEFFIYEH_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [109] = -- AF1 119 +2/3 COR
    {
        items =
        {
            xi.items.REGAL_RING,
            xi.items.LAKSAMANAS_BOTTES_P2,
            xi.items.LAKSAMANAS_BOTTES_P3,
            xi.items.LAKSAMANAS_TREWS_P2,
            xi.items.LAKSAMANAS_TREWS_P3,
            xi.items.LASKAMANAS_GANTS_P2,
            xi.items.LASKAMANAS_GANTS_P3,
            xi.items.LAKSAMANAS_FRAC_P2,
            xi.items.LAKSAMANAS_FRAC_P3,
            xi.items.LAKSAMANAS_TRICORNE_P2,
            xi.items.LAKSAMANAS_TRICORNE_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [110] = -- AF1 119 +2/3 PUP
    {
        items =
        {
            xi.items.REGAL_RING,
            xi.items.FOIRE_BABOUCHES_P2,
            xi.items.FOIRE_BABOUCHES_P3,
            xi.items.FOIRE_CHURIDARS_P2,
            xi.items.FOIRE_CHURIDARS_P3,
            xi.items.FOIRE_DASTANAS_P2,
            xi.items.FOIRE_DASTANAS_P3,
            xi.items.FOIRE_TOBE_P2,
            xi.items.FOIRE_TOBE_P3,
            xi.items.FOIRE_TAJ_P2,
            xi.items.FOIRE_TAJ_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [111] = -- AF1 119 +2/3 DNC (M)
    {
        items =
        {
            xi.items.REGAL_RING,
            xi.items.MAXIXI_TIARA_M_P2,
            xi.items.MAXIXI_CASAQUE_M_P2,
            xi.items.MAXIXI_BANGLES_M_P2,
            xi.items.MAXIXI_TIGHTS_M_P2,
            xi.items.MAXIXI_TOE_SHOES_M_P2,
            xi.items.MAXIXI_TIARA_M_P3,
            xi.items.MAXIXI_CASAQUE_M_P3,
            xi.items.MAXIXI_BANGLES_M_P3,
            xi.items.MAXIXI_TIGHTS_M_P3,
            xi.items.MAXIXI_TOE_SHOES_M_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [112] = -- AF1 119 +2/3 DNC (F)
    {
        items =
        {
            xi.items.REGAL_RING,
            xi.items.MAXIXI_TIARA_F_P2,
            xi.items.MAXIXI_CASAQUE_F_P2,
            xi.items.MAXIXI_BANGLES_F_P2,
            xi.items.MAXIXI_TIGHTS_F_P2,
            xi.items.MAXIXI_TOE_SHOES_F_P2,
            xi.items.MAXIXI_TIARA_F_P3,
            xi.items.MAXIXI_CASAQUE_F_P3,
            xi.items.MAXIXI_BANGLES_F_P3,
            xi.items.MAXIXI_TIGHTS_F_P3,
            xi.items.MAXIXI_TOE_SHOES_F_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [113] = -- AF1 119 +2/3 SCH
    {
        items =
        {
            xi.items.REGAL_EARRING,
            xi.items.ACADEMICS_LOAFERS_P2,
            xi.items.ACADEMICS_LOAFERS_P3,
            xi.items.ACADEMICS_PANTS_P2,
            xi.items.ACADEMICS_PANTS_P3,
            xi.items.ACADEMICS_BRACERS_P2,
            xi.items.ACADEMICS_BRACERS_P3,
            xi.items.ACADEMICS_GOWN_P2,
            xi.items.ACADEMICS_GOWN_P3,
            xi.items.ACADEMICS_MORTARBOARD_P2,
            xi.items.ACADEMICS_MORTARBOARD_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [114] = -- AF1 119 +2/3 GEO
    {
        items =
        {
            xi.items.REGAL_EARRING,
            xi.items.GEOMANCY_SANDALS_P2,
            xi.items.GEOMANCY_SANDALS_P3,
            xi.items.GEOMANCY_PANTS_P2,
            xi.items.GEOMANCY_PANTS_P3,
            xi.items.GEOMANCY_MITAINES_P2,
            xi.items.GEOMANCY_MITAINES_P3,
            xi.items.GEOMANCY_TUNIC_P2,
            xi.items.GEOMANCY_TUNIC_P3,
            xi.items.GEOMANCY_GALERO_P2,
            xi.items.GEOMANCY_GALERO_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [115] = -- AF1 119 +2/3 RUN
    {
        items =
        {
            xi.items.REGAL_RING,
            xi.items.RUNEISTS_BOOTS_P2,
            xi.items.RUNEISTS_BOOTS_P3,
            xi.items.RUNIESTS_TROUSERS_P2,
            xi.items.RUNEISTS_TROUSERS_P3,
            xi.items.RUNEISTS_MITONS_P2,
            xi.items.RUNEISTS_MITONS_P3,
            xi.items.RUNEISTS_COAT_P2,
            xi.items.RUNEISTS_COAT_P3,
            xi.items.RUNEISTS_BANDEAU_P2,
            xi.items.RUNEISTS_BANDEAU_P3,
        },
        minEquipped = 2,
        maxEquipped = 5,
        mods =
        {
            { xi.mod.ACC,  15, 0, 0 },
            { xi.mod.RACC, 15, 0, 0 },
            { xi.mod.MACC, 15, 0, 0 },
        },
    },

    [116] = -- Outrider set (Phys damage taken -10%)
    {
        items =
        {
            xi.items.OUTRIDER_MASK,
            xi.items.OUTRIDER_MAIL,
            xi.items.OUTRIDER_MITTENS,
            xi.items.OUTRIDER_HOSE,
            xi.items.OUTRIDER_GREAVES,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.DMGPHYS, -1000, 0, 0 },
        },
    },

    [117] = -- Espial set (Crit damage +10%)
    {
        items =
        {
            xi.items.ESPIAL_CAP,
            xi.items.ESPIAL_GAMBISON,
            xi.items.ESPIAL_BRACERS,
            xi.items.ESPIAL_HOSE,
            xi.items.ESPIAL_SOCKS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.CRIT_DMG_INCREASE, 10, 0, 0 },
        },
    },

    [118] = -- Wayfarer set (Refresh+3)
    {
        items =
        {
            xi.items.WAYFARER_CIRCLET,
            xi.items.WAYFARER_ROBE,
            xi.items.WAYFARER_CUFFS,
            xi.items.WAYFARER_SLOPS,
            xi.items.WAYFARER_CLOGS,
        },
        minEquipped = 5,
        mods =
        {
            { xi.mod.REFRESH, 3, 0, 0 },
        },
    },

    [119] = -- Apogee +1
    {
        items =
        {
            xi.items.APOGEE_CROWN_P1,
            xi.items.APOGEE_DALMATICA_P1,
            xi.items.APOGEE_MITTS_P1,
            xi.items.APOGEE_SLACKS_P1,
            xi.items.APOGEE_PUMPS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.BP_DAMAGE, 4, 2, 0 },
        },
    },

    [120] = -- Ryuo +1
    {
        items =
        {
            xi.items.RYUO_SOMEN_P1,
            xi.items.RYUO_DOMARU_P1,
            xi.items.RYUO_TEKKO_P1,
            xi.items.RYUO_HAKAMA_P1,
            xi.items.RYUO_SUNE_ATE_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ATT, 20, 10, 0 },
        },
    },

    [121] = -- Souveran +1
    {
        items =
        {
            xi.items.SOUVERAN_SCHALLER_P1,
            xi.items.SOUVERAN_CUIRASS_P1,
            xi.items.SOUVERAN_HANDSCHUHS_P1,
            xi.items.SOUVERAN_DIECHLINGS_P1,
            xi.items.SOUVERAN_SCHUHS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DMG, -4, -2, 0 },
        },
    },

    [122] = -- Emicho +1
    {
        items =
        {
            xi.items.EMICHO_CORONET_P1,
            xi.items.EMICHO_HAUBERT_P1,
            xi.items.EMICHO_GAUNTLETS_P1,
            xi.items.EMICHO_HOSE_P1,
            xi.items.EMICHO_GAMBIERAS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DOUBLE_ATTACK, 4, 2, 0 },
        },
    },

    [123] = -- Kaykaus +1
    {
        items =
        {
            xi.items.KAYKAUS_MITRA_P1,
            xi.items.KAYKAUS_BLIAUT_P1,
            xi.items.KAYKAUS_CUFFS_P1,
            xi.items.KAYKAUS_TIGHTS_P1,
            xi.items.KAYKAUS_BOOTS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.CURE_POTENCY_II, 4, 2, 0 },
        },
    },

    [124] = -- Rao +1
    {
        items =
        {
            xi.items.RAO_KABUTO_P1,
            xi.items.RAO_TOGI_P1,
            xi.items.RAO_KOTE_P1,
            xi.items.RAO_HAIDATE_P1,
            xi.items.RAO_SUNE_ATE_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.MARTIAL_ARTS, 8, 4, 0 },
        },
    },

    [125] = -- Adhemar +1
    {
        items =
        {
            xi.items.ADHEMAR_BONNET_P1,
            xi.items.ADHEMAR_JACKET_P1,
            xi.items.ADHEMAR_WRISTBANDS_P1,
            xi.items.ADHEMAR_KECKS_P1,
            xi.items.ADHEMAR_GAMASHES_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.CRITHITRATE, 4, 2, 0 },
        },
    },

    [126] = -- Carmine +1
    {
        items =
        {
            xi.items.CARMINE_MASK_P1,
            xi.items.CARMINE_SCALE_MAIL_P1,
            xi.items.CARMINE_FINGER_GAUNTLETS_P1,
            xi.items.CARMINE_CUISSES_P1,
            xi.items.CARMINE_GREAVES_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ACC, 20, 10, 0 },
        },
    },

    [127] = -- Lustratio +1
    {
        items =
        {
            xi.items.LUSTRATIO_CAP_P1,
            xi.items.LUSTRATIO_HARNESS_P1,
            xi.items.LUSTRATIO_MITTENS_P1,
            xi.items.LUSTRATIO_SUBLIGAR_P1,
            xi.items.LUSTRATIO_LEGGINGS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ALL_WSDMG_FIRST_HIT, 4, 2, 0 },
        },
    },

    [128] = -- Argosy +1
    {
        items =
        {
            xi.items.ARGOSY_CELATA_P1,
            xi.items.ARGOSY_HAUBERK_P1,
            xi.items.ARGOSY_MUFFLERS_P1,
            xi.items.ARGOSY_BREECHES_P1,
            xi.items.ARGOSY_SOLLERETS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.DOUBLE_ATTACK, 4, 2, 0 },
        },
    },

    [129] = -- Amalric +1
    {
        items =
        {
            xi.items.AMALRIC_COIF_P1,
            xi.items.AMALRIC_DOUBLET_P1,
            xi.items.AMALRIC_GAGES_P1,
            xi.items.AMALRIC_SLOPS_P1,
            xi.items.AMALRIC_NAILS_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.MATT, 20, 10, 0 },
        },
    },

    [130] = -- Moliones's Sickle/Ring
    {
        items =
        {
            xi.items.MOLIONESS_SICKLE,
            xi.items.MOLIONESS_RING,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.ACC,              5, 0, 0 },
            { xi.mod.SOULEATER_EFFECT, 2, 0, 0 },
        },
    },

    [131] = -- Mavi +2 Set: Occasionally triples the WSC of Blue Magic Spells. Will stack with Chain Affinity.
    {
        items =
        {
            xi.items.MAVI_KAVUK_P2,
            xi.items.MAVI_MINTAN_P2,
            xi.items.MAVI_BAZUBANDS_P2,
            xi.items.MAVI_TAYT_P2,
            xi.items.MAVI_BASMAK_P2,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AUGMENT_BLU_MAGIC, 2, 1, 0 },
        },
    },

    [132] = -- AF3 BLU 109/119 Set: Occasionally triples the WSC of Blue Magic Spells. Will stack with Chain Affinity.
    {
        items =
        {
            xi.items.HASHISHIN_KAVUK,
            xi.items.HASHISHIN_KAVUK_P1,
            xi.items.HASHISHIN_MINTAN,
            xi.items.HASHISHIN_MINTAN_P1,
            xi.items.HASHISHIN_BAZUBANDS,
            xi.items.HASHISHIN_BAZUBANDS_P1,
            xi.items.HASHISHIN_TAYT,
            xi.items.HASHISHIN_TAYT_P1,
            xi.items.HASHISHIN_BASMAK,
            xi.items.HASHISHIN_BASMAK_P1,
        },
        minEquipped = 2,
        mods =
        {
            { xi.mod.AUGMENT_BLU_MAGIC, 2, 1, 0 },
        },
    }
}

-- Build Table to lookup Set ID based on Item ID.  This is cached in xi.gear_sets.itemToSetId table,
-- and only rebuilt on loading the gear_sets global into cache.

xi.gear_sets.createItemToSetId = function()
    local itemTable = {}

    for setId, setData in pairs(gearSets) do
        for _, itemId in ipairs(setData.items) do
            itemTable[itemId] = setId
        end
    end

    return itemTable
end

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
            equippedSets[setId] = equippedSets[setId] and (equippedSets[setId] + 1) or 1
        end
    end

    -- Apply Mods for each set after boundary checking the counts.
    for setId, setCount in pairs(equippedSets) do
        local minEquippedReq = gearSets[setId].minEquipped and gearSets[setId].minEquipped or 2
        local maxEquippedReq = gearSets[setId].maxEquipped and gearSets[setId].maxEquipped or 0

        if setCount >= minEquipped then
            local modTierIndex = math.min(setCount, maxEquippedReq) - minEquippedReq

            for _, modData in gearSets[setId].mods do
                player:addGearSetMod(setId, modData[1], modData[modTierIndex + 2])
            end
        end
    end
end
